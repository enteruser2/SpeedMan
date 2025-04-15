//
//  PrivacyViewController.swift
//  CrazyBird
//
//  Created by 7x on 2024/3/7.
//

import Foundation
import AppLovinSDK

class PrivacyViewController:WebViewController  {
    
    lazy var titleBgView: UIView = {
       let titleBgView = UIView.init(frame: CGRectMake(0, UIDevice.navigationBarHeight - 44, UIDevice.screenWidth, 44))
        titleBgView.backgroundColor = UIColor(hexString: "#EFF1FB")
       return titleBgView
   }()
    
    fileprivate lazy var titleLabel: UILabel = {
        let titleLabel = UILabel.init()
        titleLabel.frame = CGRectMake(50.uiX, 0, UIDevice.screenWidth - 100.uiX, 44)
        titleLabel.textColor = UIColor(hexString: "#254B62")
        titleLabel.font = UIFont.init(style: .ARIALBold, size: 19)
        titleLabel.numberOfLines = 0
        titleLabel.textAlignment = .center
        titleLabel.text = UserManager.shared.translateModel?.t2305
        return titleLabel
    }()
    
    // 关闭按钮
     lazy var closeBtn: UIButton = {
        let closeBtn = UIButton.init(type: .custom)
         closeBtn.frame = CGRectMake(0, 0, 50.uiX, 44)
        closeBtn.setImage(UIImage.init(named: "back_icon"), for: .normal)
        closeBtn.addTarget(self, action: #selector(onCloseView), for: .touchUpInside)

        return closeBtn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.view.addSubview(self.titleBgView)
        self.titleBgView.addSubview(self.titleLabel)
        self.titleBgView.addSubview(self.closeBtn)
        


        
        if(self.navigationController?.navigationBar != nil)
        {
            self.navigationItem.title = UserManager.shared.translateModel?.t2305
        }
        else
        {
            self.view.backgroundColor = UIColor(hexString: "#EFF1FB")
        }
        
        self.webView?.frame = CGRectMake(0.uiX, UIDevice.navigationBarHeight, UIDevice.screenWidth,  UIDevice.screenHeight-UIDevice.navigationBarHeight - UIDevice.safeAreaBottom)

        let home = NetManager.requestObj(.privacy, type: PrivacyModel.self).asObservable()
        home.subscribe(onNext: { model in
            self.webView?.loadHTMLString(model?.content ?? "", baseURL: nil)

        },onError: {error in
            
        }).disposed(by: self.rx.disposeBag)
        
        ALSdk.shared().showMediationDebugger()

        
    }
    
    override func setupBinding() {
        super.setupBinding()
    }
    
    @objc func onCloseView()
    {
        self.dismiss(animated: false)
    }
}
