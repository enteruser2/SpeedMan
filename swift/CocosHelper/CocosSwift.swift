//
//  CocosHelper.swift
//  Crazy Hero
//
//  Created by 7x on 2024/1/3.
//

import Foundation
import RxSwift
import SwiftyJSON
import HandyJSON
import AudioToolbox
enum ADSceneType: String {
    case VideoAdId     = "iosVideoAdId"
    case VideoAdIdFreePlay     = "iosVideoAdIdFreePlay"
}


@objc class CocosSwift: NSObject {
    static var disposeBag = DisposeBag()

    @objc static func getLookVideo(videotype:String)
    {
        var secenType = ""
        var type = videotype
        type = "ios\(type)"
        switch type {
        case ADSceneType.VideoAdId.rawValue:
            secenType = ADSceneType.VideoAdId.rawValue
            break
        case ADSceneType.VideoAdIdFreePlay.rawValue:
            secenType = ADSceneType.VideoAdIdFreePlay.rawValue
            break
        default:
            break
        }
        
        AdsSwift.shared.adShow(secenType: secenType)
        
        
        //        ProgressHUD().showProgressTipHUD(view:CocosHelper.getCurrentVC().view)
        //
        //        NetManager.requestObj(.fetchAd(position: secenType), type: FetchAdModel.self).asObservable().subscribe(onNext: { fetchAdModel in
        //            ProgressHUD().hiddenProgressTipHUD(view: CocosHelper.getCurrentVC().view)
        //
        //            var params:[String:Any] = [:]
        //                        params["slotId"] = "981116191"
        //                        params["adType"] = "1"
        //                        params["postionADSceneType"] = secenType
        //            if(fetchAdModel?.type ?? 0 > 100)
        //            {
        //                AdsManager.share().loadAdType(FullVideoAd_Type, parameters: params.jsonString()!)
        //            }
        //            else
        //            {
        //                AdsManager.share().loadAdType(RewardAd_Type, parameters: params.jsonString()!)
        //            }
        //
        //        },onError: {error in
        //
        //            ProgressHUD().hiddenProgressTipHUD(view: CocosHelper.getCurrentVC().view)
        //
        //        }).disposed(by: disposeBag)
        
        
    }
    
    @objc static func getTranslateInfo() ->String{
        CommonTool.LogLine(message: "CocosHelper----getTranslateInfo")
        if  let translateModel = UserManager.shared.translateModel
        {
            let translate = translateModel.toJSONString()!
            //            translate = translate.replacingOccurrences(of: "'", with: "")
            return translate
        }
        return ""
    }
    
    @objc static func setShareContent(shareBean:String,type:String)
    {
        let model = ShareModel.deserialize(from: shareBean)
        switch(type){
        case "1":
            do{
                (CocosHelper.getCurrentVC() as! ViewController).showFaceBookShareDialog(model: model!)
            }
            break;
        case "2":
            do {
                // 初始化并展示分享控制器
                let activityItem = [model?.text ?? "" ,URL(string: model?.url ?? "") ?? ""] as [Any]
                let activityViewController = UIActivityViewController(activityItems: activityItem, applicationActivities: nil)
                // 展示分享控制器
                CocosHelper.getCurrentVC().present(activityViewController, animated: true, completion: nil)
            }
            break;
        case "3":
            do{
                let shareStr = String(format: "%@%@", model?.text ?? "",model?.url ?? "")
                let url = String(format:"twitter://post?message=%@",shareStr.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) ?? "")
                let twitterURL = URL(string: url)
                
                if(UIApplication.shared.canOpenURL(URL(string: "twitter://")!))
                {
                    UIApplication.shared.open(twitterURL!)
                }
                else
                {
                    ProgressHUD.shared.showProgressTipHUD(view:CocosHelper.getCurrentVC().view , withText: UserManager.shared.translateModel!.t1907, afterDelay: 2)
                }
            }
            
            break;
        default: break
            
        }
    }
    
    @objc static func OpenActivity(type:String,param:String)
    {
        switch(type){
        case "1":
            let vc = PrivacyViewController()
            vc.modalPresentationStyle = .fullScreen
            CocosHelper.getCurrentVC().present(vc, animated: true)

//            CocosHelper.getCurrentVC().navigationController?.pushViewController(PrivacyViewController(), animated: true)
        
            break;
        default: break

        }
    }
    
    @objc static func SendJSError(error:String)
    {
        CommonTool.LogLine(message: "SendJSError \(error)")
        let model = ExceptionModel.init(name: "SendJSError", reason: error)
        Crashlytics.crashlytics().record(exceptionModel: model)
    }
    
    
    
    @objc static func setLanguageChange(code:String)
    {
        if(UserdefaultManager.shared.appleLanguages == code)
        {
            return
        }
        UserManager.shared.isChangeLanguage = true
        UserdefaultManager.shared.appleLanguages = code
        //        CocosHelper.getCurrentVC().navigationController?.pushViewController(LaunchViewController(), animated: true)
        let vc = LaunchViewController()
        vc.modalPresentationStyle = .fullScreen
        CocosHelper.getCurrentVC().present(vc, animated: false)
    }
    
    @objc static func copyContent(text:String)
    {
        ProgressHUD.shared.showProgressTipHUD(view: CocosHelper.getCurrentVC().view, withText: UserManager.shared.translateModel!.t1904, afterDelay: 2)
        NSString.copy(toUIPasteboard: text)
    }
    
    @objc static func getVersionNumber()->String{

        return UserdefaultManager.shared.version
    }
    
    
    @objc static func getAppName()->String{
        return UserdefaultManager.shared.appName
    }
    
    @objc static func getUserInfo()->String{
        
        return UserManager.shared.user!.toJSONString()!
    }
    
    @objc static func updataApp(){
        
    }
    
    @objc static func loginOut(){
        if(CocosHelper.getCurrentVC() is LaunchViewController)
        {
            return
        }
        UserManager.shared.login.accept((nil, .loginOut))
        UserdefaultManager.shared.userToken = ""
        UserManager.shared.isGameRestart = true
//        Application.shared.configureMainInterface(in: Application.shared.window)
        let vc = LaunchViewController()
        vc.modalPresentationStyle = .fullScreen
        CocosHelper.getCurrentVC().present(vc, animated: false)
    }
    
    
    @objc static func getRequestHeaderInfo()->String{
        let token     = UserdefaultManager.shared.userToken
        let channel   = "AppStore"
        let model = HeaderModel()
        model.platform = "2"
        model.channel = channel
        model.language = UserdefaultManager.shared.appleLanguages
        model.version = UserdefaultManager.shared.version
        model.token = token
        model.url = NetAPI.getBaseURL
        CommonTool.LogLine(message: "CocosHelper----getRequestHeaderInfo：" + model.toJSONString()!)
        
        return model.toJSONString()!
    }
    
    @objc static func vibrate(){
        AudioServicesPlaySystemSound(1519)
    }
    
    @objc static func openWebView(url:String){
        ProgressHUD.shared.showProgressTipHUD(view: CocosHelper.getCurrentVC().view, withText: UserManager.shared.translateModel!.t1904, afterDelay: 2)
        NSString.copy(toUIPasteboard: url)
    }
}
