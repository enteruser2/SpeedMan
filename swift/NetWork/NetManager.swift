//
//  NetManager.swift
//  WallPaper
//
//  Created by LiQi on 2020/4/10.
//  Copyright © 2020 Qire. All rights reserved.
//

import Foundation
import Moya
import RxSwift
import RxCocoa
import HandyJSON
import SwiftyJSON

enum NetError: Error {
    case error(code: Int, msg: String)
}

struct Response {
    var code = 0
    var data: JSON?
    var message = ""
}

class NetManager {
    
    static var SuccessCode = 200
    static let LoginOutCode = 4004
    static let NotJsonCode = 999999
    
    class func requestResponseObj(_ target: NetAPI) -> Single<Response> {
        
        return Single.create { single in
            let cancellableToken = NetProvider.request(target) { result in
                switch result {
                case let .success(response):
                    let jsonString = (String(data: response.data, encoding: .utf8))?.nsString.decryptAESDynamicIV() ?? ""
                    if let jsonData = jsonString.data(using: .utf8) {
                        do {
                            let jsonObject = try JSONSerialization.jsonObject(with: jsonData, options: [])
                            
                            if let jsonDict = jsonObject as? [String: Any] {
                                let json = JSON(jsonDict)
                                let ybResponse = Response(code: json["Cutcode"].intValue, data: json["Cutdata"], message: json["Cutmessage"].stringValue)
                                switch ybResponse.code {
                                case SuccessCode:
                                    single(.success(ybResponse))
                                    break
                                case LoginOutCode:
                                    UserdefaultManager.shared.userToken = ""
                                    UserManager.shared.login.accept((nil, .loginOut))
                                    single(.failure(NetError.error(code: ybResponse.code, msg: ybResponse.message)))
                                    break
                                default:
                                    single(.failure(NetError.error(code: ybResponse.code, msg: ybResponse.message)))
                                    break
                                }
                            }
                        } catch {
                            CommonTool.LogLine(message:"Error parsing JSON: \(error),API:\(target)")
                            single(.failure(NetError.error(code: self.NotJsonCode, msg: "Error parsing JSON: \(error)")))
                        }
                    } else {
                        CommonTool.LogLine(message:"Invalid JSON string,API:\(target)")
                        single(.failure(NetError.error(code: self.NotJsonCode, msg: "Invalid JSON string")))
                    }
                    break
                case let .failure(error):
                    single(.failure(NetError.error(code: error.errorCode, msg: error.localizedDescription)))
                    break
                }
            }
            return Disposables.create {
                cancellableToken.cancel()
            }
        }
    }
    //
    //    class func requestResponse(_ target: NetAPI) -> Single<Void> {
    //
    //        return Single.create { single in
    //            let cancellableToken = NetProvider.request(target) { result in
    //                switch result {
    //                case let .success(response):
    //                    let dataOptional = try? response.mapJSON()
    //                    guard let data = dataOptional else {
    //                        single(.failure(NetError.error(code: self.NotJsonCode, msg: "PayText14".localized())))
    //                        return
    //                    }
    //                    let json = JSON(data)
    //                    let ybResponse = Response(code: json["code"].intValue, data: json["data"], msg: json["message"].stringValue)
    //                    switch ybResponse.code {
    //                    case SuccessCode:
    //                        single(.success(()))
    //                    case LoginOutCode:
    ////                        UserManager.shared.login.accept((nil, .loginOut))
    //                        single(.failure(NetError.error(code: ybResponse.code, msg: ybResponse.msg)))
    //                    default:
    //                        single(.failure(NetError.error(code: ybResponse.code, msg: ybResponse.msg)))
    //                    }
    //                case let .failure(error):
    //                    single(.failure(NetError.error(code: error.errorCode, msg: error.localizedDescription)))
    //                }
    //            }
    //            return Disposables.create {
    //                cancellableToken.cancel()
    //            }
    //        }
    //    }
    
    class func requestObj<T: HandyJSON>(_ target: NetAPI, type: T.Type) -> Single<T?> {
        return Single.create { single in
            let cancellableToken = NetProvider.request(target) { result in
                switch result {
                case let .success(response):
                   
                    if let string = String(data: response.data, encoding: .utf8) {
                        // 这里 string 是解码后的字符串

                        let jsonString = string.nsString.decryptAESDynamicIV()
                        CommonTool.LogLine(message:"jsonString \(jsonString)")

                        if let jsonData = jsonString.data(using: .utf8) {
                            do {
                                let jsonObject = try JSONSerialization.jsonObject(with: jsonData, options: [])
                                
                                if let jsonDict = jsonObject as? [String: Any] {
                                    let json = JSON(jsonDict)
                                    let ybResponse = Response(code: json["Cutcode"].intValue, data: json["Cutdata"], message: json["Cutmessage"].stringValue)
                                    CommonTool.LogLine(message:"code \(ybResponse.code),msg: \(ybResponse.message),API:\(target)")
                                    switch ybResponse.code {
                                    case SuccessCode:
                                        guard let responseData = ybResponse.data else {
                                            single(.success(nil))
                                            return
                                        }
                                        CommonTool.LogLine(message:"requestObj parsing JSON: \(responseData)")
                                        let obj = T.deserialize(from: responseData.dictionaryObject)
                                        single(.success(obj))
                                        break
                                    case LoginOutCode:
                                        UserdefaultManager.shared.userToken = ""
                                        UserManager.shared.login.accept((nil, .loginOut))
                                        single(.failure(NetError.error(code: ybResponse.code, msg: ybResponse.message)))
                                        break
                                    default:
                                        single(.failure(NetError.error(code: ybResponse.code, msg: ybResponse.message)))
                                        break
                                    }
                                }
                            } catch {
                                CommonTool.LogLine(message:"Error parsing JSON: \(error) ----- \(string),API:\(target)")
                                single(.failure(NetError.error(code: self.NotJsonCode, msg: "Error parsing JSON: \(error)")))
                            }
                        } else {
                            CommonTool.LogLine(message:"Invalid JSON string ,API:\(target)")
                            single(.failure(NetError.error(code: self.NotJsonCode, msg: "Invalid JSON string")))
                        }
                    }
                    break
                case let .failure(error):
                    single(.failure(NetError.error(code: error.errorCode, msg: error.localizedDescription)))
                    break
                }
            }
            return Disposables.create {
                cancellableToken.cancel()
            }
        }
    }
    
    
    
    class func requestObjArray<T: HandyJSON>(_ target: NetAPI, type: T.Type) -> Single<[T]> {
        return Single.create { single in
            let cancellableToken = NetProvider.request(target) { result in
                switch result {
                case let .success(response):
                    if let string = String(data: response.data, encoding: .utf8) {
                        // 这里 string 是解码后的字符串
                        let jsonString = string.nsString.decryptAESDynamicIV()
                        if let jsonData = jsonString.data(using: .utf8) {
                            do {
                                let jsonObject = try JSONSerialization.jsonObject(with: jsonData, options: [])
                                
                                if let jsonDict = jsonObject as? [String: Any] {
                                    let json = JSON(jsonDict)
                                    let ybResponse = Response(code: json["Cutcode"].intValue, data: json["Cutdata"], message: json["Cutmessage"].stringValue)
                                    CommonTool.LogLine(message:"code \(ybResponse.code),msg: \(ybResponse.message),API:\(target)")

                                    switch ybResponse.code {
                                    case SuccessCode:
                                        guard let responseData = ybResponse.data else {
                                            single(.success([]))
                                            return
                                        }
                                        
                                        var objArray: [T] = []
                                        for json in responseData {
                                            guard let jsonDict = json.1.dictionaryObject else {
                                                continue // 如果转换失败，跳过当前元素
                                            }
                                            if let model = T.deserialize(from: jsonDict) {
                                                objArray.append(model)
                                            }
                                        }
                                        
                                        single(.success(objArray))
                                        break
                                    case LoginOutCode:
                                        UserdefaultManager.shared.userToken = ""
                                        UserManager.shared.login.accept((nil, .loginOut))
                                        single(.failure(NetError.error(code: ybResponse.code, msg: ybResponse.message)))
                                        break
                                    default:
                                        single(.failure(NetError.error(code: ybResponse.code, msg: ybResponse.message)))
                                        break
                                    }
                                }
                            } catch {
                                CommonTool.LogLine(message:"Error parsing JSON: \(error)  ----- \(string)")
                                single(.failure(NetError.error(code: self.NotJsonCode, msg: "Error parsing JSON: \(error)")))
                            }
                        } else {
                            CommonTool.LogLine(message:"Invalid JSON string")
                            single(.failure(NetError.error(code: self.NotJsonCode, msg: "Invalid JSON string")))
                        }
                    }
                    break
                case let .failure(error):
                    single(.failure(NetError.error(code: error.errorCode, msg: error.localizedDescription)))
                    break
                }
            }
            return Disposables.create {
                cancellableToken.cancel()
            }
        }
    }
    
    //    // MARK: - Download
    //
    //    class func download(_ target: NetAPI) -> Observable<Double> {
    //
    //        return Observable<Double>.create { observer in
    //            let cancellableToken = NetProvider.request(target, callbackQueue: .main, progress: { progressResponse in
    //                observer.onNext(progressResponse.progress)
    //            }) { result in
    //                switch result {
    //                case .success:
    //                    observer.onCompleted()
    //                case let .failure(error):
    //                    observer.onError(NetError.error(code: error.errorCode, msg: error.localizedDescription))
    //                }
    //            }
    //            return Disposables.create {
    //                cancellableToken.cancel()
    //            }
    //        }
    //    }
    
    
}
