//
//  PrivacyViewController.swift
//  CrazyBird
//
//  Created by 7x on 2024/3/7.
//

import Foundation

class PrivacyViewController:WebViewController  {
    
  
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.navigationItem.title = UserManager.shared.translateModel?.t2305
        
        self.webView?.frame = CGRectMake(0.uiX, UIDevice.navigationBarHeight, UIDevice.screenWidth,  UIDevice.screenHeight-UIDevice.navigationBarHeight - UIDevice.safeAreaBottom)

        let home = NetManager.requestObj(.privacy, type: PrivacyModel.self).asObservable()
        home.subscribe(onNext: { model in
            self.webView?.loadHTMLString(model?.content ?? "", baseURL: nil)

        },onError: {error in
            
        }).disposed(by: self.rx.disposeBag)
        
    }
    
    override func setupBinding() {
        super.setupBinding()
    }
}
