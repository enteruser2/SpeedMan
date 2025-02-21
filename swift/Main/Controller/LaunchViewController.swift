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

class LaunchViewController : BaseViewController,LoginCloseDelegate {
    func LoginCloseEvent() {
        self.getuserModel()
    }
    

    var lanchScreenView: LanchScreenView!

    private var loading = DisposeBag()
    let showErrorView = BehaviorRelay<Bool>(value: false)

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = CocosBridge.shared().getCocosView()
        view.contentScaleFactor   = UIScreen.main.scale;
        view.isMultipleTouchEnabled = true;
        lanchScreenView = LanchScreenView(frame: CGRectMake(0, 0, UIDevice.screenWidth, UIDevice.screenHeight))
        CocosBridge.shared().getCocosView().addSubview(lanchScreenView)
        
        
        

//        self.navigationController?.isNavigationBarHidden = true
//        
//        errorBtnTap.asObservable().subscribe(onNext: { _ in
//            self.lanchScreenView.progressViwe.progress = 0
//            self.lanchScreenView.progressLabel.text = "0%"
//            self.lanchScreenView.isHidden = false
//            self.getTranslateModel()
//            
//        }, onError: {error in
//
//
//        }).disposed(by: loading)
//        
//        
//        self.showErrorView.bind(to: rx.showErrorView()).disposed(by: rx.disposeBag)
//        
        self.openViewController()

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
        if(!UserdefaultManager.shared.userToken.isEmpty)
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
                    Application.shared.window.addSubview(dialog)
                }
                else
                {
                    if(deviceLogin?.login_status == 1)
                    {
                        // 登录弹窗 非运营国家可以选择自动进入
                        let loginView = LoginView(frame:CGRectMake(0, 0, UIDevice.screenWidth, UIDevice.screenHeight))
                        loginView.closeBtn.isHidden = false
                        loginView.delegate = self
                        self.lanchScreenView.addSubview(loginView)
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

        UserManager.shared.loginUser().asObservable().subscribe(onNext: { uiserModel in
            CommonTool.LogLine(message: "uiserModel ： \(String(describing: uiserModel?.toJSONString()))")
            self.lanchScreenView.type = 2
            
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
//            self.lanchScreenView.type = 3
// 
//            var index = 0
//            if(self.navigationController!.viewControllers.count > 1)
//            {
//              index = 1
//            }
//            else
//            {
//                index = 0
//            }
//            self.navigationController?.pushViewController(ViewController(), animated: false)
//            let updatedViewControllers = NSMutableArray(array: self.navigationController!.viewControllers)
//            updatedViewControllers.removeObject(at: index)
//            self.navigationController?.viewControllers = updatedViewControllers as! [UIViewController]
//            
//        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
            // 2秒后执行的代码
            print("这条消息将在2秒后打印")
            self.lanchScreenView.removeFromSuperview()
//            var nav = NavigationController(rootViewController: self)
//            self.navigationController?.pushViewController(ViewController(), animated: true)
            var vc = ViewController()
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true)
            // 例如，更新UI
            // self.someLabel.text = "更新后的文本"
        }
    }
    
 
 
    
    func notNetWorkEvent() {
        self.lanchScreenView.isHidden = true
        self.showErrorView.accept(true)
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
}
