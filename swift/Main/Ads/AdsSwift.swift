//
//  AdsSwift.swift
//  CrazyBird
//
//  Created by 7x on 2024/3/21.
//




import Foundation
import RxSwift
import HandyJSON
import AppLovinSDK
@objcMembers class AdsSwift: NSObject {
    var price: Double = 0.0
    var band: String = ""
    var clickNumber: Int = 0
    var viewController = UIViewController()

    static let shared = AdsSwift()
    override init() {
        super.init()
    }
    
    func run() { print(price, band, "run") }
    static func run() { print("Car run") }
    
    func updateLog(dic:[String:Any]){
        
        CommonTool.LogLine(message: "AdsSwift updateLog : \(dic)")
        NetManager.requestObj(.adPoster(dic: dic), type: AdPosterModel.self).asObservable().subscribe(onNext: { model in
            CommonTool.LogLine(message: "AdsSwift updateLog success: \(String(describing: model))")
            
        },onError: {error in
            
        }).disposed(by: self.rx.disposeBag)
        
    }
    
    func closeEvent(postionADSceneType:String){
        CommonTool.LogLine(message: "closeEvent postionADSceneType : \(postionADSceneType)")
        switch postionADSceneType {
        case ADSceneType.VideoAdId.rawValue:  videoCallCocosSuccess(postionADSceneType:postionADSceneType); break
        case ADSceneType.VideoAdIdFreePlay.rawValue:  videoCallCocosSuccess(postionADSceneType:postionADSceneType); break

//        case ADSceneType.VideoIdCocosInteractive.rawValue:
            // 游戏首页互动任务
//            NetManager.requestObj(.interactDraw(id: UserManager.shared.cocos_InteractID), type: DrawModel.self).asObservable().subscribe(onNext: { model in
//                if let new_model = model{
//                    DrawRewardCommon.shared.showDrawReward(it: new_model)
//                }
//            },onError: {error in
//                
//            }).disposed(by: self.rx.disposeBag)
//            
//            CocosHelper.nativeCallCocosEvent("", argument: "", callbackId: "getHomeInfo")
//            break

//        case ADSceneType.VideoIdWatchVideosTask.rawValue:
//            
//            // 每日任务看视频任务奖励
//            if(self.viewController.isKind(of: TaskViewController.self))
//            {
//
//                let vc = (self.viewController as! TaskViewController)
//                if let task_content = vc.task_content{
//                    vc.taskDraw(type: task_content.type)
//                }
//            }
//            
//            break
//        case ADSceneType.VideoIdTaskInteractive.rawValue:
//            // 每日任务互动任务奖励
//            if(self.viewController.isKind(of: TaskViewController.self))
//            {
//                let vc = (self.viewController as! TaskViewController)
//                if let task_content = vc.task_content{
//                    vc.taskInteractDraw(id: task_content.InteractID)
//                }
//                
//            }
//            
//            break
 
        default:
            break
        }
        
    }
    
    func  clickEvent(postionADSceneType:String){
        switch postionADSceneType {
        case ADSceneType.VideoAdIdFreePlay.rawValue:
            CommonTool.LogLine(message: "AdsSwift clickEvent ")
            // 诱导任务
            NetManager.requestObj(.clickVideoAd, type: BaseModel.self).asObservable().subscribe(onNext: { model in
                CommonTool.LogLine(message: "AdsSwift clickEvent success: \(String(describing: model))")
//                if(self.viewController.isKind(of: TaskViewController.self))
//                {
//                    let vc = (self.viewController as! TaskViewController)
//                    vc.refreshData()
//                }
                
            },onError: {error in
                
            }).disposed(by: self.rx.disposeBag)
            
            break
            
        default:
            break
        }
    }
    
    
    func videoError(postionADSceneType:String){
        
        switch postionADSceneType {
        case ADSceneType.VideoAdId.rawValue:  videoCallCocosError(postionADSceneType:postionADSceneType); break
        default:
            break
        }
        
    }
    
    
    private func videoCallCocosError(postionADSceneType:String)
    {
        var type = postionADSceneType
        if(type.contains("ios"))
        {
            type = type.replacingOccurrences(of: "ios", with: "")
        }
        CocosHelper.nativeCallCocosEvent("", argument: "SpeedManFail", callbackId: type)
    }
    
    private func videoCallCocosSuccess(postionADSceneType:String)
    {
        var type = postionADSceneType
        if(type.contains("ios"))
        {
            type = type.replacingOccurrences(of: "ios", with: "")
        }
        CocosHelper.nativeCallCocosEvent("", argument: "SpeedManSuccess", callbackId: type)
    }
    
    func adShow(secenType:String) {
        
        ProgressHUD().showProgressTipHUD(view:Application.shared.window)
        NetManager.requestObj(.fetchAd(position: secenType), type: FetchAdModel.self).asObservable().subscribe(onNext: { fetchAdModel in
            ProgressHUD().hiddenProgressTipHUD(view: Application.shared.window)
            if let model = fetchAdModel {
                CommonTool.LogLine(message: "AdsSwift adShow  \(model.type)")

                if (model.MaxVideoTotal <= 0)
                {
                    ProgressHUD.shared.showProgressTipHUD(view: Application.shared.window, withText: UserManager.shared.translateModel?.t1920 ?? "", afterDelay: 2)
                    return
                }
                var params:[String:Any] = [:]
                params["slotId"] = model.id
                params["adType"] = model.type.description
//                params["slotId"] = "ca-app-pub-3940256099942544/1712485313"
//                params["adType"] = "2"
                params["postionADSceneType"] = secenType
                if(model.type > 100)
                {
                    let adtype = model.type - 100
                    params["adType"] = adtype.description
                    AdsManager.share().loadAdType(FullVideoAd_Type, parameters: params.jsonString()!)
                }
                else
                {

                    AdsManager.share().loadAdType(RewardAd_Type, parameters: params.jsonString()!)
                }
                
            }
            
            
        },onError: {error in
            
            ProgressHUD().hiddenProgressTipHUD(view: Application.shared.window)
            
        }).disposed(by: self.rx.disposeBag)
    }
}

extension AdsSwift {
    func test() { print(price, band, "test")}
}


class AdPosterModel : HandyJSON {
    
    var Xlabgoogle_block_at: Int64 = 0
    required init() {
        
    }
}
