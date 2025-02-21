//
//  NavigationController.swift
//  WallPaper
//
//  Created by LiQi on 2020/4/9.
//  Copyright © 2020 Qire. All rights reserved.
//

import UIKit
import HBDNavigationBar

class NavigationController: HBDNavigationController {    

    override func viewDidLoad() {
        super.viewDidLoad()
  
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        
//        if let pre = presentedViewController {
//            return pre.preferredStatusBarStyle
//        }
        if let top = topViewController {
//            if let pre = top.presentedViewController {
//                return pre.preferredStatusBarStyle
//            }
            return top.preferredStatusBarStyle
        }
        return .lightContent
    }
    
    override var prefersStatusBarHidden: Bool {
        if let top = topViewController {
            return top.prefersStatusBarHidden
        }
        return false
    }
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {

        if (viewControllers.count > 0 && !(viewController is ViewController)) {
            let backBtn = UIButton()
            backBtn.addTarget(self, action: #selector(onClickBack), for: .touchUpInside)
            backBtn.setImage(UIImage(named: "back_icon"), for: .normal)
            backBtn.frame = .init(x: 0, y: 0, width: 40, height: 40)
            backBtn.contentHorizontalAlignment = .leading
            viewController.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backBtn)
            viewController.hidesBottomBarWhenPushed = true
        }
        super.pushViewController(viewController, animated: animated)
    }

    @objc
    func onClickBack() {
        
        var current: UIViewController?
        if let pre = presentedViewController {
            current = pre
        } else if let top = topViewController {
            if let pre = top.presentedViewController {
                current = pre
            } else {
                current = top
            }
        }
        if let vc = current as? BaseViewController {
            vc.onClickBack()
        } else {
            popViewController(animated: true)
        }
        
    }

}


