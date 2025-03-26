//
//  ViewController.swift
//  WallPaper
//
//  Created by LiQi on 2020/4/13.
//  Copyright © 2020 Qire. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class BaseViewController: UIViewController{
    
    private var isFirst = true
    
    var emptyImageName: String?
    var emptyTitle: String?
    var emptyBtnTitle: String?
    var emptyBtnTap = PublishRelay<Void>()
    var isHideEmptyBtn = true
    var emptyView: EmptyView?
    var bgImage:UIImageView = UIImageView()
    
    var errorBtnTap = PublishRelay<Void>()
    var errorView: ErrorView?
    
    private var disposeBag:DisposeBag?

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if #available(iOS 11, *) {
        } else {
            automaticallyAdjustsScrollViewInsets = false
        }
        
        hbd_barAlpha = 0
        hbd_barShadowHidden = true
        
        //        view.backgroundColor = UIColor(hexString: "#ffffff")
        if(self.navigationController?.viewControllers.count ?? 1 > 1)
        {
            bgImage.frame = CGRectMake(0, 0,UIDevice.screenWidth, UIDevice.screenHeight)
//            bgImage.image = UIImage(named: "bg_image")
            bgImage.backgroundColor = UIColor(hexString: "#EFF1FB")
            bgImage.contentMode = .scaleToFill
            view.addSubview(bgImage)
        }
        
        hbd_titleTextAttributes = [
            NSAttributedString.Key.font: UIFont(style: .ARIALBold, size: 20),
            NSAttributedString.Key.foregroundColor : UIColor(hexString: "#254B62") as Any
        ]
        

    }

    
    func setupBinding()
    {
        self.disposeBag = DisposeBag()

        UserManager.shared.login.subscribe(onNext: {[weak self] user in
            guard let self = self else { return }
            if user.1 == .loginOut {
                
                UserdefaultManager.shared.userToken = ""
//                Application.shared.configureMainInterface(in: Application.shared.window)
                self.disposeBag = nil
            }
        }).disposed(by: self.disposeBag!)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if(self.navigationController?.viewControllers.count ?? 1 > 1)
        {
            self.navigationController?.isNavigationBarHidden = false
        }
        else
        {
            self.navigationController?.isNavigationBarHidden = true
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if isFirst {
            onceWhenViewDidAppear(animated)
            isFirst = false
        }
    }
    
    func onceWhenViewDidAppear(_ animated: Bool) {
        
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    @objc
    func onClickBack() {
        if let nav = navigationController {
            nav.popViewController(animated: true)
        } else {
            dismiss(animated: true, completion: nil)
        }
        
        self.disposeBag = nil
    }
    
    
}

extension Reactive where Base: BaseViewController {
    
    func showEmptyView(imageName: String = "empty_pop_image",
                       title: String = UserManager.shared.translateModel?.t448 ?? "",
                       btnTitle: String? = nil,
                       btnTap: PublishRelay<Void>? = nil,
                       inset: UIEdgeInsets = .zero,
                       subView: UIView = UIView.init(frame: CGRectZero),
                       addBottom: Bool = false) -> Binder<Bool> {
        return Binder(self.base) { view, show in
            if show {
                let emptyView = EmptyView()
                emptyView.backgroundColor = UIColor.clear
                emptyView.imgView.image = UIImage(named: imageName)
                emptyView.label.text = title
                
                if addBottom {
                    subView.insertSubview(emptyView, at: 0)
                } else {
                    subView.addSubview(emptyView)
                }
                emptyView.snp.makeConstraints { make in
                    make.edges.equalToSuperview().inset(inset)
                }
                view.emptyView = emptyView
            } else {
                view.emptyView?.removeFromSuperview()
            }
        }
    }
    
    func showErrorView(inset: UIEdgeInsets = .zero) -> Binder<Bool> {
        return Binder(self.base) { controller, show in
            if show {
                let errorView = ErrorView()
                errorView.label.rx.tap().bind(to: controller.errorBtnTap).disposed(by: controller.rx.disposeBag)
                controller.view.addSubview(errorView)
                errorView.snp.makeConstraints { make in
                    make.edges.equalToSuperview().inset(inset)
                }
                controller.errorView = errorView
            } else {
                controller.errorView?.removeFromSuperview()
            }
        }
    }
}

