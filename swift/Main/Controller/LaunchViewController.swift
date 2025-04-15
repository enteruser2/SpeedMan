//
//  LaunchViewController.swift
//  Crazy Hero
//
//  Created by 7x on 2023/12/19.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa
import AppLovinSDK
class LaunchViewController : BaseViewController,LoginCloseDelegate,DeleteAccountDelegate {
    func DeleteAccountEvent() {
        self.getuserModel()
    }
    
    func LoginCloseEvent() {
        self.getuserModel()
    }
    
    
    var lanchScreenView: LanchScreenView!
    
    private var loading = DisposeBag()
    let showErrorView = BehaviorRelay<Bool>(value: false)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        lanchScreenView = LanchScreenView(frame: CGRectMake(0, 0, UIDevice.screenWidth, UIDevice.screenHeight))
        Application.shared.window.addSubview(lanchScreenView)
        self.navigationController?.isNavigationBarHidden = true
        errorBtnTap.asObservable().subscribe(onNext: { _ in
            self.lanchScreenView.progressViwe.progress = 0
            self.lanchScreenView.progressLabel.text = "0%"
            self.lanchScreenView.isHidden = false
            self.getTranslateModel()
            
        }, onError: {error in
            
            
        }).disposed(by: loading)
        
        
        self.showErrorView.bind(to: rx.showErrorView()).disposed(by: rx.disposeBag)
//        self.getTranslateModel()
        
    }
    
    
    func getTranslateModel() {
        UserManager.shared.translateRequest().asObservable().subscribe(onNext: { translatemodel in
            
            CommonTool.LogLine(message: "translateRequest： \(String(describing: translatemodel))")
            UserManager.shared.translateModel = translatemodel
            self.getdeviceLoginModel()
            
        }, onError: {error in
            CommonTool.LogLine(message: "translateRequest error： \(String(describing: error))")
            self.notNetWorkEvent()
        }).disposed(by: loading)
    }
    
    
    func getdeviceLoginModel() {
        CommonTool.LogLine(message: "LaunchViewController getdeviceLoginModel() \(UserdefaultManager.shared.userToken.isEmpty)")
        if(!UserdefaultManager.shared.userToken.isEmpty && UserdefaultManager.shared.loginStatus == 0)
        {
            self.getuserModel()
        }
        else
        {
            UserManager.shared.deviceLogin().asObservable().subscribe(onNext: { deviceLogin in
                
                CommonTool.LogLine(message: "deviceLogin222： \(String(describing: deviceLogin))")
                self.lanchScreenView.type = 1
                let LogoutAt = deviceLogin?.LogoutAt ?? 0
                let ID = deviceLogin?.id ?? 0
                if(LogoutAt > 0)
                {
                    let dialog = DeleteAccountTip4(frame:CGRectMake(0, 0, UIDevice.screenWidth, UIDevice.screenHeight))
                    dialog.setLogOutAt(logOutAt:LogoutAt,ID: ID)
                    dialog.delegate = self
                    Application.shared.window.addSubview(dialog)
                }
                else
                {
                    if(deviceLogin?.login_status == 1)
                    {
                        UserdefaultManager.shared.loginStatus = 1
                        // 登录弹窗 非运营国家可以选择自动进入
                        let loginView = LoginView(frame:CGRectMake(0, 0, UIDevice.screenWidth, UIDevice.screenHeight))
                        loginView.closeBtn.isHidden = false
                        loginView.delegate = self
                        Application.shared.window.addSubview(loginView)
                    }
                    else
                    {
                        if(deviceLogin?.login_type == 1 || deviceLogin?.login_type == 2 || deviceLogin?.login_type == 3)
                        {
                            // 用户信息
                            self.getuserModel()
                        }
                        else
                        {
                            // 登录弹窗
                            let loginView = LoginView(frame:CGRectMake(0, 0, UIDevice.screenWidth, UIDevice.screenHeight))
                            loginView.closeBtn.isHidden = true
                            self.lanchScreenView.addSubview(loginView)
                        }
                    }
                }
                
                
            }, onError: {error in
                CommonTool.LogLine(message: "deviceLogin error： \(String(describing: error))")
                self.notNetWorkEvent()
            }).disposed(by: loading)
        }
    }
    
    func getuserModel() {
        CommonTool.LogLine(message: "LaunchViewController getuserModel()")
        self.lanchScreenView.type = 2
        
        UserManager.shared.loginUser().asObservable().subscribe(onNext: { uiserModel in
            CommonTool.LogLine(message: "uiserModel ： \(String(describing: uiserModel?.toJSONString()))")
            ALSdk.shared().settings.userIdentifier = String(describing:uiserModel?.homeId)
            self.openViewController()
            
        }, onError: {error in
            CommonTool.LogLine(message: "uiserModel error： \(String(describing: error))")
            self.notNetWorkEvent()
        }).disposed(by: self.loading)
        
    }
    
    func openViewController()
    {
        //        if(self.navigationController != nil)
        //        {
        
        //                        var index = 0
        //                        if(self.navigationController!.viewControllers.count > 1)
        //                        {
        //                          index = 1
        //                        }
        //                        else
        //                        {
        //                            index = 0
        //                        }
        //
        //                        self.navigationController?.pushViewController(ViewController(), animated: true)
        //                        let updatedViewControllers = NSMutableArray(array: self.navigationController!.viewControllers)
        //                        updatedViewControllers.removeObject(at: index)
        //                        self.navigationController?.viewControllers = updatedViewControllers as! [UIViewController]
        
        CommonTool.LogLine(message: "openViewController：22222222")
        
        if(!CocosBridge.shared().isLoadView)
        {
            let vc = ViewController()
            Application.shared.window?.rootViewController = vc
            Application.shared.window.addSubview(self.lanchScreenView)
            self.lanchScreenView.type = 3
            
            
            CocosBridge.shared().initCocosMain()
            vc.view = CocosBridge.shared().getCocosView()
            vc.view.contentScaleFactor   = UIScreen.main.scale;
            vc.view.isMultipleTouchEnabled = true;
            CocosBridge.shared().application(Application.shared.application!,didFinishLaunchingWithOptions: Dictionary())
            
            CommonTool.LogLine(message: "openViewController：3333333")

        }
        else
        {
            Application.shared.window.addSubview(self.lanchScreenView)
            self.lanchScreenView.type = 3
            self.dismiss(animated: false)
            
            CommonTool.LogLine(message: "openViewController：444444")

        }
        
        
        //        }
    }
    
    
    
    
    func notNetWorkEvent() {
        self.lanchScreenView.isHidden = true
        self.showErrorView.accept(true)
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
}
