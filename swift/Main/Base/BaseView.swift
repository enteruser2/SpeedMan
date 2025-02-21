//
//  BaseView.swift
//  CrazyBird
//
//  Created by 7x on 2024/3/28.
//

import Foundation
import UIKit
import RxSwift
import RxRelay

class BaseView: UIView {
    
    var emptyView: EmptyView?
    var errorBtnTap = PublishRelay<Void>()
    var errorView: ErrorView?
    

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    


}


extension Reactive where Base: BaseView {
    
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
        return Binder(self.base) { view, show in
            if show {
                let errorView = ErrorView()
                errorView.label.rx.tap().bind(to: view.errorBtnTap).disposed(by: view.rx.disposeBag)
                view.addSubview(errorView)
                errorView.snp.makeConstraints { make in
                    make.edges.equalToSuperview().inset(inset)
                }
                view.errorView = errorView
            } else {
                view.errorView?.removeFromSuperview()
            }
        }
    }
}

