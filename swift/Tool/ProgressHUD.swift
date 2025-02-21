//
//  ProgressHUD.swift
//  CrazyBird
//
//  Created by 7x on 2024/3/6.
//

import Foundation
import MBProgressHUD
@objcMembers class ProgressHUD: NSObject {
    
    static let shared = ProgressHUD()
    override init() {
        super.init()

    }
        
    
    func showProgressTipHUD( view: UIView, withText text: String, afterDelay delay: TimeInterval) {
    
        let progressHUD = MBProgressHUD.showAdded(to: view, animated: true)
        progressHUD.isUserInteractionEnabled = false
        progressHUD.backgroundColor = UIColor.black.withAlphaComponent(0.1)
          
        // Multi-line display
        progressHUD.detailsLabel.text = text
        progressHUD.detailsLabel.font = UIFont(style: .ARIALBold, size: 18) // Assuming KARIAL is a valid font
        progressHUD.mode = .text
        progressHUD.removeFromSuperViewOnHide = true
        progressHUD.bezelView.style = .solidColor
        progressHUD.bezelView.color = .init(white: 0, alpha: 0.8)
        progressHUD.contentColor = .white
        DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
            progressHUD.hide(animated: true)
        }
    }
    
    func showProgressTipHUD( view: UIView) {
    
        let progressHUD = MBProgressHUD.showAdded(to: view, animated: false)
        progressHUD.isUserInteractionEnabled = true
        progressHUD.backgroundColor = UIColor.black.withAlphaComponent(0.1)
          
        // Multi-line display
        progressHUD.mode = .indeterminate
        progressHUD.removeFromSuperViewOnHide = true
        progressHUD.bezelView.style = .solidColor
        progressHUD.bezelView.color = .init(white: 0, alpha: 0.8)
        progressHUD.contentColor = .white
    }
    
    func hiddenProgressTipHUD( view: UIView) {
    
        for progressHUD in view.subviews {
            if(progressHUD.isKind(of: MBProgressHUD.self))
            {
                progressHUD.removeFromSuperview()
            }
        }
    }
    
}
