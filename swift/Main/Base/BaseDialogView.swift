//
//  BaseDialogView.swift
//  CrazyBird
//
//  Created by 7x on 2024/2/19.
//

import Foundation
import UIKit
import RxSwift
import RxRelay

class BaseDialogView: UIView {
    
    var emptyView: EmptyView?
    var errorBtnTap = PublishRelay<Void>()
    var errorView: ErrorView?
    
     lazy var bgView: UIView = {
        let bgView = UIView.init()
        return bgView
    }()
    
    
    lazy var bgImageView: UIImageView = {
       let bgImageView = UIImageView.init()
//        bgImageView.image = .init(named: "dialog_title_bg")
       return bgImageView
   }()
    
     lazy var titleBgView: UIView = {
        let titleBgView = UIView.init()
        return titleBgView
    }()
    
    fileprivate lazy var titleImageView: UIImageView = {
        let titleImageView = UIImageView.init()
        titleImageView.image = .init(named: "dialog_title_bg")
        return titleImageView
    }()
    
    fileprivate lazy var titleLabel: UILabel = {
        let titleLabel = UILabel.init()
        titleLabel.frame = CGRectMake(0, 0, 300, 0)
        titleLabel.textColor = UIColor(hexString: "#254B62")
        titleLabel.font = UIFont.init(style: .ARIALBold, size: 26)
        titleLabel.numberOfLines = 0
        titleLabel.textAlignment = .center
        return titleLabel
    }()
    
    // 关闭按钮
     lazy var closeBtn: UIButton = {
        let closeBtn = UIButton.init(type: .custom)
        closeBtn.frame = CGRectZero
        closeBtn.setImage(UIImage.init(named: "dialog_close_icon"), for: .normal)
        closeBtn.addTarget(self, action: #selector(onCloseView), for: .touchUpInside)

//        closeBtn.rx.tap.subscribe(onNext: { _ in
//        }).disposed(by: self.rx.disposeBag)

        return closeBtn
    }()

    
     lazy var conentBgView: UIView = {
        let conentBgView = UIView.init()
        return conentBgView
    }()
    
     lazy var contentImageView: UIImageView = {
        let contentImageView = UIImageView.init()
        contentImageView.image = .init(named: "dialog_content_bg")
        return contentImageView
    }()
    

    func setTitleText(text:String?){
        
        titleLabel.text = text
//        titleLabel.addStroke(color: UIColor(hexString: "#254B62")!, width: -5.0)
        setUI()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.black.withAlphaComponent(0.7)
        
        self.addSubview(self.bgView)
        self.bgView.addSubview(self.bgImageView)
        self.bgView.addSubview(self.titleBgView)
        self.bgView.addSubview(self.closeBtn)
        self.bgView.addSubview(self.contentImageView)
        self.bgView.addSubview(self.conentBgView)
        self.titleBgView.addSubview(self.titleImageView)
        self.titleBgView.addSubview(self.titleLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUI(){
        titleLabel.sizeToFit()
        bgView.snp.removeConstraints()
        
        bgView.snp.makeConstraints { make in
            make.center.equalTo(self)
            make.leading.equalTo(self).offset(25.uiX)
            make.trailing.equalTo(self).offset(-25.uiX)
            make.top.equalTo(self.titleBgView.snp.top).offset(-70.uiX)
            make.bottom.equalTo(self.conentBgView.snp.bottom).offset(20.uiX)
        }
        
        bgImageView.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalTo(0)
            make.top.equalTo(50.uiX)
        }
        
        closeBtn.snp.makeConstraints { make in
            make.top.equalTo(0.uiX)
            make.trailing.equalTo(self.bgView).offset(0.uiX)
            make.height.equalTo(50.uiX)
            make.width.equalTo(50.uiX)
        }
        
        titleBgView.snp.makeConstraints { make in
            make.leading.trailing.equalTo(0)
            make.height.equalTo(titleLabel)
        }
        
        titleImageView.snp.makeConstraints { make in
            make.leading.trailing.equalTo(0)
            make.height.equalTo(titleLabel)

        }
        
        titleLabel.snp.makeConstraints { make in
            
            make.leading.equalTo(5.uiX)
            make.trailing.equalTo(-5.uiX)
            make.height.equalTo(titleLabel.size.height + 30.uiX)
        }
        
        
        contentImageView.snp.makeConstraints { make in
            
            make.leading.equalTo(0.uiX)
            make.trailing.equalTo(-0.uiX)
            make.bottom.equalTo(-20.uiX)
            make.height.equalTo(conentBgView)
        }
            
    }
    
    @objc func onCloseView()
    {
        CommonTool.LogLine(message: "onCloseView ")
        self.removeFromSuperview()
    }

}


extension Reactive where Base: BaseDialogView {
    
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

