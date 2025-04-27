//
//  NetProvider.swift
//  WallPaper
//
//  Created by LiQi on 2020/4/10.
//  Copyright © 2020 Qire. All rights reserved.
//

import Foundation
import Moya
import Alamofire


let NetProvider = MoyaProvider<NetAPI>(requestClosure: { (endpoint, done) in
    do {
        var request = try endpoint.urlRequest()
        request.timeoutInterval = 20//设置请求超时时间
        done(.success(request))
    } catch {

    }
})


enum NetAPI {
    /// 翻译表
    case translate
    /// 用户登录
    case login(loginModel: LoginModel)
    /// 恢复账号
    case recovery
    /// 设备登录
    case deviceLogin
    /// 用户信息
    case userInfo
    /// 获取广告位
    case fetchAd(position:String)
    /// 广告信息上报
    case adPoster(dic:[String:Any])
    /// 广告点击
    case clickVideoAd
    /// 隐私政策
    case privacy

}

var raw = ""

extension NetAPI: TargetType {
        
    static var getBaseURL: String {
        let baseURL = String(format: "https://%@", ConfigManager.shared.getNETURLAPI())
        CommonTool.LogLine(message: "baseURL :\(baseURL)")
        return baseURL
    
    }
    
    static func getHtmlProtocol(type: Int) -> URL? {
        return URL(string: String(format: "%@api/agreement/detail?id=%d", NetAPI.getBaseURL, type))
    }
    
    public var baseURL: URL {
        switch self {
        default:
            let baseUrl = URL(string: NetAPI.getBaseURL)!
            return baseUrl
        }
    }
    
    public var path: String {
        switch self {
        case .translate:
            return "/Api/A11"
        case .deviceLogin:
            return "/Api/A13"
        case .recovery:
            return "/Api/A30"
        case .login:
            return "/Api/A15"
        case .userInfo:
            return "/Api/A16"
        case .fetchAd:
            return "/Api/A34"
        case .adPoster:
            return "/Api/A35"
        case .clickVideoAd:
            return "/Api/A37"
        case .privacy:
            return "/Api/A12"
        }
        
    }
    
    public var method: Moya.Method {
        switch self {
        default:
            return .post
        }
    }
    
    public var sampleData: Data {
        return "{}".data(using: String.Encoding.utf8)!
    }
    
    var parameters: String  {
        
        var params:[String:Any] = [:]
        switch self{
        case .deviceLogin:
            let bundleID = Bundle.main.bundleIdentifier;
            var deviceid = ""
            if SAMKeychain.password(forService: bundleID!, account: AppDefine.kDEVICE_ID_KEY) == nil{
                let date = NSDate().dateStampFromDate13()
                deviceid = String(format: "%@%@", deviceid.nsString .randomString(19),date ?? "")
                SAMKeychain.setPassword(deviceid, forService: bundleID!, account: AppDefine.kDEVICE_ID_KEY)
            }
            else
            {
                deviceid = SAMKeychain.password(forService: bundleID!, account: AppDefine.kDEVICE_ID_KEY) ?? ""
            }
            
//            deviceid = "f9c4f136b13a25dc691714037375689"
            let inviteStr = NSString.readUIPasteboard()
            var invite_id = ""
            if let inviteText = inviteStr{
                if(!inviteText.isEmpty && inviteText.contains("speed_man-"))
                {
                    invite_id = inviteText
                }
            }
            let timeZone   = UIDevice.getTimeZone()
            let times      = NSTimeZone.system.secondsFromGMT(for: Date()) * 1000
            let carrier    = UIDevice.getCarrierName()
            let mcc_mnc    = UIDevice.getCarrierCode()
            let countryIOS = UIDevice.getisoCountryCode()
            let model      = UIDevice.getPhoneModel()
            let os_version = UIDevice.systemVersion()
            let resolution = UIDevice.getScreenPix()
            let country    = UserdefaultManager.shared.appleCountry
            let lang       = UserdefaultManager.shared.appleLanguages
            let os_type    = 2
            let vpn        = ReachabilityManager.shared.isUsingProxy() == true ? 1 : 0
            let vpn2       = ReachabilityManager.shared.isUsingVPN() == true ? 1 : 0

            
            params["device_id"] = deviceid
            params["invite"]    = invite_id
            params["country"]   = country
            params["lang"]      = lang
            params["carrier"]   = carrier
            params["mcc_mnc"]   = mcc_mnc
            params["countryIOS"]   = countryIOS
            params["resolution"]  = resolution
            params["os_version"]  = os_version
            params["model"]  = model
            params["gmt"]    = times
            params["tz"]     = timeZone
            params["os_type"] = os_type
            params["vpn"] = vpn
            params["vpn2"] = vpn2

            break
        case .recovery:
            break
        case .translate:
            break
        case let .login(loginModel):
            params["login_id"]=loginModel.login_id
            params["login_type"]=loginModel.login_type
            params["avatar"]=loginModel.avatar
            params["nickname"]=loginModel.nickname
            params["email"]=loginModel.email
            params["access_token"]=loginModel.access_token
            params["os_type"]=loginModel.os_type
            break
        case .userInfo:
            break
        case let .fetchAd(position):
            params["position"]=position
            break
        case let .adPoster(dic):
            params = dic
            break
        case .clickVideoAd:
            break
        case .privacy:
            break
        }
        
        CommonTool.LogLine(message: "\(params)")
        raw = params.jsonString()!.nsString.encryptAESDynamicIV()
        return raw
    }
    
    public var task: Task {
        
        switch self {

        default:
            return .requestData(parameters.data(using: String.Encoding.utf8)!)
        }
        
    }
    
    public var headers: [String : String]? {
//        UserdefaultManager.shared.userToken = "eyJpZCI6OTczMjg3MDIsInRva2VuIjoiMzI4OWI1NDIzMzYyM2NmMjIyMjhjZDNmZDZlMWE4ZDgifQ"
        let token     = UserdefaultManager.shared.userToken
        let timestamp = NSDate().dateStampFromDate13()
        let channel   = "AppStore"
        var headers:[String : String] = [:]
        headers["Content-Type"]  = "application/json"
        headers["Accept"]        = "application/json"
        headers["Manplatform"]      = "2"
        headers["Manchannel"]       = channel
        headers["Manlanguage"]      = UserdefaultManager.shared.appleLanguages
        headers["Manversion"]       = UserdefaultManager.shared.version
        headers["Mantimestamp"]     = timestamp!
        headers["Mantoken"]         = token
        CommonTool.LogLine(message: "token:"+(headers.jsonString() ?? ""))
        let sign = String(format: "%@%@%@%@%@", token,timestamp!,channel,raw,ConfigManager.shared.getPSWSIGNKEY())
        headers["Mansign"]          = sign.md5.uppercased()
        return headers
    }
    
}


