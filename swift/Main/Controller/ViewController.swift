//
//  ViewController.swift
//  swift
//
//  Created by 7x on 2023/12/7.
//

import UIKit
import SwiftUI
import RxSwift
import FBSDKShareKit
import FBSDKCoreKit
class ViewController: BaseViewController, SharingDelegate {

    func sharer(_ sharer: FBSDKShareKit.Sharing, didCompleteWithResults results: [String : Any]) {
        
    }
    
    func sharer(_ sharer: FBSDKShareKit.Sharing, didFailWithError error: Error) {
        
    }
    
    func sharerDidCancel(_ sharer: FBSDKShareKit.Sharing) {
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if(UserManager.shared.isGameRestart){
            CocosHelper.nativeCallCocosRootEvent("", argument: "", callbackId: "HEADER_UPDATE_EVENT")
            UserManager.shared.isGameRestart = false
        }
        else if(UserManager.shared.isChangeLanguage)
        {
            CocosHelper.nativeCallCocosRootEvent("", argument: "", callbackId: "LANGUAGE_UPDATE_EVENT")
            UserManager.shared.isChangeLanguage = false
            
        }
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        //        self.navigationController?.navigationBar.isHidden = true
        CommonTool.LogLine(message: "ViewController viewDidLoad :")

    }
    
    @objc func hideSplashView(){
        CommonTool.LogLine(message: "ViewController hideSplashView :")
        for view in Application.shared.window.subviews {
            if let lanchScreenView = view as? LanchScreenView {
                // 可能存在多个LanchScreenView
                lanchScreenView.removeFromSuperview()
            }
        }
    }
    

    func showFaceBookShareDialog(model:ShareModel){
        let content = ShareLinkContent()
        content.quote = model.text
        content.contentURL = URL(string: model.url)
        let dialog = ShareDialog(
            viewController: self,
            content: content,
            delegate: self
        )
        dialog.mode = .native
        if(!dialog.canShow)
        {
            dialog.mode = .feedBrowser
        }
        dialog.show()
        
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
}

