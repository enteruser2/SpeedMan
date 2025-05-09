/****************************************************************************
 Copyright (c) 2012 greathqy
 Copyright (c) 2012 cocos2d-x.org
 Copyright (c) 2013-2016 Chukong Technologies Inc.
 Copyright (c) 2017-2023 Xiamen Yaji Software Co., Ltd.

 http://www.cocos.com

 Permission is hereby granted, free of charge, to any person obtaining a copy
 of this software and associated documentation files (the "Software"), to deal
 in the Software without restriction, including without limitation the rights to
 use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies
 of the Software, and to permit persons to whom the Software is furnished to do so,
 subject to the following conditions:

 The above copyright notice and this permission notice shall be included in
 all copies or substantial portions of the Software.

 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 THE SOFTWARE.
****************************************************************************/

#include "network/HttpClient.h"
#include <curl/curl.h>
#include <errno.h>
#include "application/ApplicationManager.h"
#include "base/Log.h"
#include "base/ThreadPool.h"
#include "base/memory/Memory.h"
#include "platform/FileUtils.h"
#include "platform/StdC.h"

namespace cc {

namespace network {

#if (CC_PLATFORM == CC_PLATFORM_WINDOWS)
typedef int int32_t;
#endif

static HttpClient *_httpClient = nullptr; // pointer to singleton
static LegacyThreadPool *gThreadPool = nullptr;

typedef size_t (*write_callback)(void *ptr, size_t size, size_t nmemb, void *stream);

// Callback function used by libcurl for collect response data
static size_t writeData(void *ptr, size_t size, size_t nmemb, void *stream) {
    ccstd::vector<char> *recvBuffer = (ccstd::vector<char> *)stream;
    size_t sizes = size * nmemb;

    // add data to the end of recvBuffer
    // write data maybe called more than once in a single request
    recvBuffer->insert(recvBuffer->end(), (char *)ptr, (char *)ptr + sizes);

    return sizes;
}

// Callback function used by libcurl for collect header data
static size_t writeHeaderData(void *ptr, size_t size, size_t nmemb, void *stream) {
    ccstd::vector<char> *recvBuffer = (ccstd::vector<char> *)stream;
    size_t sizes = size * nmemb;

    // add data to the end of recvBuffer
    // write data maybe called more than once in a single request
    recvBuffer->insert(recvBuffer->end(), (char *)ptr, (char *)ptr + sizes);

    return sizes;
}

static int processGetTask(HttpClient *client, HttpRequest *request, write_callback callback, void *stream, long *errorCode, write_callback headerCallback, void *headerStream, char *errorBuffer);
static int processPostTask(HttpClient *client, HttpRequest *request, write_callback callback, void *stream, long *errorCode, write_callback headerCallback, void *headerStream, char *errorBuffer);
static int processPutTask(HttpClient *client, HttpRequest *request, write_callback callback, void *stream, long *errorCode, write_callback headerCallback, void *headerStream, char *errorBuffer);
static int processDeleteTask(HttpClient *client, HttpRequest *request, write_callback callback, void *stream, long *errorCode, write_callback headerCallback, void *headerStream, char *errorBuffer);
// int processDownloadTask(HttpRequest *task, write_callback callback, void *stream, int32_t *errorCode);

// Worker thread
void HttpClient::networkThread() {
    increaseThreadCount();

    while (true) {
        HttpRequest *request;

        // step 1: send http request if the requestQueue isn't empty
        {
            std::lock_guard<std::mutex> lock(_requestQueueMutex);
            while (_requestQueue.empty()) {
                _sleepCondition.wait(_requestQueueMutex);
            }
            request = _requestQueue.at(0);
            _requestQueue.erase(0);
        }

        if (request == _requestSentinel) {
            break;
        }

        // step 2: libcurl sync access

        // Create a HttpResponse object, the default setting is http access failed
        HttpResponse *response = ccnew HttpResponse(request);
        response->addRef(); // NOTE: RefCounted object's reference count is changed to 0 now. so needs to addRef after ccnew.

        processResponse(response, _responseMessage);

        // add response packet into queue
        _responseQueueMutex.lock();
        _responseQueue.pushBack(response);
        _responseQueueMutex.unlock();

        _schedulerMutex.lock();
        if (auto sche = _scheduler.lock()) {
            sche->performFunctionInCocosThread(CC_CALLBACK_0(HttpClient::dispatchResponseCallbacks, this));
        }
        _schedulerMutex.unlock();
    }

    // cleanup: if worker thread received quit signal, clean up un-completed request queue
    _requestQueueMutex.lock();
    _requestQueue.clear();
    _requestQueueMutex.unlock();

    _responseQueueMutex.lock();
    _responseQueue.clear();
    _responseQueueMutex.unlock();

    decreaseThreadCountAndMayDeleteThis();
}

// Worker thread
void HttpClient::networkThreadAlone(HttpRequest *request, HttpResponse *response) {
    increaseThreadCount();

    char responseMessage[RESPONSE_BUFFER_SIZE] = {0};
    processResponse(response, responseMessage);

    _schedulerMutex.lock();
    if (auto sche = _scheduler.lock()) {
        sche->performFunctionInCocosThread([this, response, request] {
            const ccHttpRequestCallback &callback = request->getResponseCallback();

            if (callback != nullptr) {
                callback(this, response);
            }
            response->release();
            // do not release in other thread
            request->release();
        });
    }
    _schedulerMutex.unlock();

    decreaseThreadCountAndMayDeleteThis();
}

//Configure curl's timeout property
static bool configureCURL(HttpClient *client, HttpRequest *request, CURL *handle, char *errorBuffer) {
    if (!handle) {
        return false;
    }

    int32_t code;
    code = curl_easy_setopt(handle, CURLOPT_ERRORBUFFER, errorBuffer);
    if (code != CURLE_OK) {
        return false;
    }
    // In the openharmony platform, the long type must be used, otherwise there will be an exception.
    long timeout = static_cast<long>(request->getTimeout());
    code = curl_easy_setopt(handle, CURLOPT_TIMEOUT, timeout);
    if (code != CURLE_OK) {
        return false;
    }
    code = curl_easy_setopt(handle, CURLOPT_CONNECTTIMEOUT, timeout);
    if (code != CURLE_OK) {
        return false;
    }

    ccstd::string sslCaFilename = client->getSSLVerification();
    if (sslCaFilename.empty()) {
        curl_easy_setopt(handle, CURLOPT_SSL_VERIFYPEER, 0L);
        curl_easy_setopt(handle, CURLOPT_SSL_VERIFYHOST, 0L);
    } else {
        curl_easy_setopt(handle, CURLOPT_SSL_VERIFYPEER, 1L);
        curl_easy_setopt(handle, CURLOPT_SSL_VERIFYHOST, 2L);
        curl_easy_setopt(handle, CURLOPT_CAINFO, sslCaFilename.c_str());
    }

    // FIXED #3224: The subthread of CCHttpClient interrupts main thread if timeout comes.
    // Document is here: http://curl.haxx.se/libcurl/c/curl_easy_setopt.html#CURLOPTNOSIGNAL
    curl_easy_setopt(handle, CURLOPT_NOSIGNAL, 1L);

    curl_easy_setopt(handle, CURLOPT_ACCEPT_ENCODING, "");

    return true;
}

class CURLRaii {
    /// Instance of CURL
    CURL *_curl;
    /// Keeps custom header data
    curl_slist *_headers;

public:
    CURLRaii()
    : _curl(curl_easy_init()),
      _headers(nullptr) {
    }

    ~CURLRaii() {
        if (_curl)
            curl_easy_cleanup(_curl);
        /* free the linked list for header data */
        if (_headers)
            curl_slist_free_all(_headers);
    }

    template <class T>
    bool setOption(CURLoption option, T data) {
        return CURLE_OK == curl_easy_setopt(_curl, option, data);
    }

    /**
     * @brief Inits CURL instance for common usage
     * @param request Null not allowed
     * @param callback Response write callback
     * @param stream Response write stream
     */
    bool init(HttpClient *client, HttpRequest *request, write_callback callback, void *stream, write_callback headerCallback, void *headerStream, char *errorBuffer) {
        if (!_curl)
            return false;
        if (!configureCURL(client, request, _curl, errorBuffer))
            return false;

        /* get custom header data (if set) */
        ccstd::vector<ccstd::string> headers = request->getHeaders();
        if (!headers.empty()) {
            /* append custom headers one by one */
            for (auto &header : headers)
                _headers = curl_slist_append(_headers, header.c_str());
            /* set custom headers for curl */
            if (!setOption(CURLOPT_HTTPHEADER, _headers))
                return false;
        }
        ccstd::string cookieFilename = client->getCookieFilename();
        if (!cookieFilename.empty()) {
            if (!setOption(CURLOPT_COOKIEFILE, cookieFilename.c_str())) {
                return false;
            }
            if (!setOption(CURLOPT_COOKIEJAR, cookieFilename.c_str())) {
                return false;
            }
        }

        return setOption(CURLOPT_URL, request->getUrl()) && setOption(CURLOPT_WRITEFUNCTION, callback) && setOption(CURLOPT_WRITEDATA, stream) && setOption(CURLOPT_HEADERFUNCTION, headerCallback) && setOption(CURLOPT_HEADERDATA, headerStream);
    }

    /// @param responseCode Null not allowed
    bool perform(long *responseCode) {
        if (CURLE_OK != curl_easy_perform(_curl))
            return false;
        CURLcode code = curl_easy_getinfo(_curl, CURLINFO_RESPONSE_CODE, responseCode);
        if (code != CURLE_OK || !(*responseCode >= 200 && *responseCode < 300)) {
            CC_LOG_ERROR("Curl curl_easy_getinfo failed: %s", curl_easy_strerror(code));
            return false;
        }
        // Get some mor data.

        return true;
    }
};

//Process Get Request
static int processGetTask(HttpClient *client, HttpRequest *request, write_callback callback, void *stream, long *responseCode, write_callback headerCallback, void *headerStream, char *errorBuffer) {
    CURLRaii curl;
    bool ok = curl.init(client, request, callback, stream, headerCallback, headerStream, errorBuffer) && curl.setOption(CURLOPT_FOLLOWLOCATION, true) && curl.perform(responseCode);
    return ok ? 0 : 1;
}

//Process POST Request
static int processPostTask(HttpClient *client, HttpRequest *request, write_callback callback, void *stream, long *responseCode, write_callback headerCallback, void *headerStream, char *errorBuffer) {
    CURLRaii curl;
    bool ok = curl.init(client, request, callback, stream, headerCallback, headerStream, errorBuffer) && curl.setOption(CURLOPT_POST, 1) && curl.setOption(CURLOPT_POSTFIELDS, request->getRequestData()) && curl.setOption(CURLOPT_POSTFIELDSIZE, request->getRequestDataSize()) && curl.perform(responseCode);
    return ok ? 0 : 1;
}

//Process PUT Request
static int processPutTask(HttpClient *client, HttpRequest *request, write_callback callback, void *stream, long *responseCode, write_callback headerCallback, void *headerStream, char *errorBuffer) {
    CURLRaii curl;
    bool ok = curl.init(client, request, callback, stream, headerCallback, headerStream, errorBuffer) && curl.setOption(CURLOPT_CUSTOMREQUEST, "PUT") && curl.setOption(CURLOPT_POSTFIELDS, request->getRequestData()) && curl.setOption(CURLOPT_POSTFIELDSIZE, request->getRequestDataSize()) && curl.perform(responseCode);
    return ok ? 0 : 1;
}

//Process HEAD Request
static int processHeadTask(HttpClient *client, HttpRequest *request, write_callback callback, void *stream, long *responseCode, write_callback headerCallback, void *headerStream, char *errorBuffer) {
    CURLRaii curl;
    bool ok = curl.init(client, request, callback, stream, headerCallback, headerStream, errorBuffer) && curl.setOption(CURLOPT_NOBODY, "HEAD") && curl.setOption(CURLOPT_POSTFIELDS, request->getRequestData()) && curl.setOption(CURLOPT_POSTFIELDSIZE, request->getRequestDataSize()) && curl.perform(responseCode);
    return ok ? 0 : 1;
}

//Process DELETE Request
static int processDeleteTask(HttpClient *client, HttpRequest *request, write_callback callback, void *stream, long *responseCode, write_callback headerCallback, void *headerStream, char *errorBuffer) {
    CURLRaii curl;
    bool ok = curl.init(client, request, callback, stream, headerCallback, headerStream, errorBuffer) && curl.setOption(CURLOPT_CUSTOMREQUEST, "DELETE") && curl.setOption(CURLOPT_FOLLOWLOCATION, true) && curl.perform(responseCode);
    return ok ? 0 : 1;
}

// HttpClient implementation
HttpClient *HttpClient::getInstance() {
    if (_httpClient == nullptr) {
        _httpClient = ccnew HttpClient();
    }

    return _httpClient;
}

void HttpClient::destroyInstance() {
    if (nullptr == _httpClient) {
        CC_LOG_DEBUG("HttpClient singleton is nullptr");
        return;
    }

    CC_LOG_DEBUG("HttpClient::destroyInstance begin");
    auto thiz = _httpClient;
    _httpClient = nullptr;

    if (auto sche = thiz->_scheduler.lock()) {
        sche->unscheduleAllForTarget(thiz);
    }

    thiz->_schedulerMutex.lock();
    thiz->_scheduler.reset();
    thiz->_schedulerMutex.unlock();

    thiz->_requestQueueMutex.lock();
    thiz->_requestQueue.pushBack(thiz->_requestSentinel);
    thiz->_requestQueueMutex.unlock();

    thiz->_sleepCondition.notify_one();
    thiz->decreaseThreadCountAndMayDeleteThis();

    CC_LOG_DEBUG("HttpClient::destroyInstance() finished!");
}

void HttpClient::enableCookies(const char *cookieFile) {
    std::lock_guard<std::mutex> lock(_cookieFileMutex);
    if (cookieFile) {
        _cookieFilename = ccstd::string(cookieFile);
    } else {
        _cookieFilename = (FileUtils::getInstance()->getWritablePath() + "cookieFile.txt");
    }
}

void HttpClient::setSSLVerification(const ccstd::string &caFile) {
    std::lock_guard<std::mutex> lock(_sslCaFileMutex);
    _sslCaFilename = caFile;
}

HttpClient::HttpClient()
: _isInited(false),
  _timeoutForConnect(30),
  _timeoutForRead(60),
  _threadCount(0),
  _cookie(nullptr),
  _requestSentinel(ccnew HttpRequest()) {
    CC_LOG_DEBUG("In the constructor of HttpClient!");
    _requestSentinel->addRef();
    if (gThreadPool == nullptr) {
        gThreadPool = LegacyThreadPool::newFixedThreadPool(4);
    }
    memset(_responseMessage, 0, RESPONSE_BUFFER_SIZE * sizeof(char));
    _scheduler = CC_CURRENT_ENGINE()->getScheduler();
    increaseThreadCount();
}

HttpClient::~HttpClient() {
    CC_SAFE_RELEASE(_requestSentinel);
    CC_LOG_DEBUG("HttpClient destructor");
}

//Lazy create semaphore & mutex & thread
bool HttpClient::lazyInitThreadSemaphore() {
    if (_isInited) {
        return true;
    } else {
        auto t = std::thread(CC_CALLBACK_0(HttpClient::networkThread, this));
        t.detach();
        _isInited = true;
    }

    return true;
}

//Add a get task to queue
void HttpClient::send(HttpRequest *request) {
    if (false == lazyInitThreadSemaphore()) {
        return;
    }

    if (!request) {
        return;
    }

    request->addRef();

    _requestQueueMutex.lock();
    _requestQueue.pushBack(request);
    _requestQueueMutex.unlock();

    // Notify thread start to work
    _sleepCondition.notify_one();
}

void HttpClient::sendImmediate(HttpRequest *request) {
    if (!request) {
        return;
    }

    request->addRef();
    // Create a HttpResponse object, the default setting is http access failed
    HttpResponse *response = ccnew HttpResponse(request);
    response->addRef(); // NOTE: RefCounted object's reference count is changed to 0 now. so needs to addRef after ccnew.

    gThreadPool->pushTask([this, request, response](int /*tid*/) { HttpClient::networkThreadAlone(request, response); });
}

// Poll and notify main thread if responses exists in queue
void HttpClient::dispatchResponseCallbacks() {
    // log("CCHttpClient::dispatchResponseCallbacks is running");
    //occurs when cocos thread fires but the network thread has already quited
    HttpResponse *response = nullptr;

    _responseQueueMutex.lock();
    if (!_responseQueue.empty()) {
        response = _responseQueue.at(0);
        _responseQueue.erase(0);
    }
    _responseQueueMutex.unlock();

    if (response) {
        HttpRequest *request = response->getHttpRequest();
        const ccHttpRequestCallback &callback = request->getResponseCallback();

        if (callback != nullptr) {
            callback(this, response);
        }

        response->release();
        // do not release in other thread
        request->release();
    }
}

// Process Response
void HttpClient::processResponse(HttpResponse *response, char *responseMessage) {
    auto request = response->getHttpRequest();
    long responseCode = -1;
    int retValue = 0;

    // Process the request -> get response packet
    switch (request->getRequestType()) {
        case HttpRequest::Type::GET: // HTTP GET
            retValue = processGetTask(this, request,
                                      writeData,
                                      response->getResponseData(),
                                      &responseCode,
                                      writeHeaderData,
                                      response->getResponseHeader(),
                                      responseMessage);
            break;

        case HttpRequest::Type::POST: // HTTP POST
            retValue = processPostTask(this, request,
                                       writeData,
                                       response->getResponseData(),
                                       &responseCode,
                                       writeHeaderData,
                                       response->getResponseHeader(),
                                       responseMessage);
            break;

        case HttpRequest::Type::PUT:
            retValue = processPutTask(this, request,
                                      writeData,
                                      response->getResponseData(),
                                      &responseCode,
                                      writeHeaderData,
                                      response->getResponseHeader(),
                                      responseMessage);
            break;

        case HttpRequest::Type::HEAD:
            retValue = processHeadTask(this, request,
                                       writeData,
                                       response->getResponseData(),
                                       &responseCode,
                                       writeHeaderData,
                                       response->getResponseHeader(),
                                       responseMessage);
            break;

        case HttpRequest::Type::DELETE:
            retValue = processDeleteTask(this, request,
                                         writeData,
                                         response->getResponseData(),
                                         &responseCode,
                                         writeHeaderData,
                                         response->getResponseHeader(),
                                         responseMessage);
            break;

        default:
            CC_ABORT();
            break;
    }

    // write data to HttpResponse
    response->setResponseCode(responseCode);
    if (retValue != 0) {
        response->setSucceed(false);
        response->setErrorBuffer(responseMessage);
    } else {
        response->setSucceed(true);
    }
}

void HttpClient::increaseThreadCount() {
    _threadCountMutex.lock();
    ++_threadCount;
    _threadCountMutex.unlock();
}

void HttpClient::decreaseThreadCountAndMayDeleteThis() {
    bool needDeleteThis = false;
    _threadCountMutex.lock();
    --_threadCount;
    if (0 == _threadCount) {
        needDeleteThis = true;
    }

    _threadCountMutex.unlock();
    if (needDeleteThis) {
        delete this;
    }
}

const ccstd::string &HttpClient::getCookieFilename() {
    std::lock_guard<std::mutex> lock(_cookieFileMutex);
    return _cookieFilename;
}

const ccstd::string &HttpClient::getSSLVerification() {
    std::lock_guard<std::mutex> lock(_sslCaFileMutex);
    return _sslCaFilename;
}

} // namespace network

} // namespace cc
