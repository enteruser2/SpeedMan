//
//  DeleteAccountTip4.swift
//  CrazyBird
//
//  Created by 7x on 2024/3/12.
//

import Foundation
import RxSwift
protocol DeleteAccountDelegate: AnyObject {
    
    func DeleteAccountEvent()
    
}
class DeleteAccountTip4: BaseDialogView {
    var delegate:DeleteAccountDelegate?
    private var loading = DisposeBag()
    fileprivate lazy var okBtn: UIButton = {
        let okBtn = UIButton.init(type: .custom)
        okBtn.setTitle(UserManager.shared.translateModel?.t2715, for: .normal)
        okBtn.setTitleColor(UIColor(hexString:"#165D93"), for: .normal)
        okBtn.titleLabel?.font = UIFont(style: .ARIALBold, size: 20)
//        okBtn.titleLabel?.addStroke(color: UIColor(hexString: "#753A23")!, width: -3.uiX)
        okBtn.titleLabel?.textAlignment = .center
        okBtn.titleLabel?.numberOfLines = 0
        okBtn.setBackgroundImage(UIImage(named: "account_dialog_green_nor"), for: .normal)
        okBtn.setBackgroundImage(UIImage(named: "account_dialog_green_sel"), for: .highlighted)
        okBtn.rx.tap.subscribe (onNext:{ _ in
            NetManager.requestObj(.recovery, type: BaseModel.self).asObservable().subscribe(onNext: { _ in
                self.removeFromSuperview()
                self.delegate?.DeleteAccountEvent()

//                Application.shared.configureMainInterface(in: Application.shared.window)
            },onError: {error in
                
            }).disposed(by: self.rx.disposeBag)
           
        }).disposed(by: self.rx.disposeBag)
        
        
        return okBtn
    }()
    
    fileprivate lazy var contentLabel: UILabel = {
        let contentLabel = UILabel()
        contentLabel.textAlignment = .left
        contentLabel.textColor = UIColor(hexString: "#254B62")
        contentLabel.font = UIFont(style: .ARIAL, size: 17)
        contentLabel.numberOfLines = 0
        
        return contentLabel
    }()
    
    func setLogOutAt(logOutAt : Int64,ID:Int64)
    {
        let currentDateString = NSDate().dateString(fromDateStamp: TimeInterval(logOutAt), styleFormatter: "YYYY-MM-dd HH:mm:ss")
        contentLabel.text = UserManager.shared.translateModel?.t2714.replaceString([String(format: "%ld", ID) ,currentDateString!])
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.conentBgView.addSubview(self.contentLabel)
        self.conentBgView.addSubview(self.okBtn)
        setTitleText(text: UserManager.shared.translateModel?.t2713)
    }
    

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setUI() {
        super.setUI()
        self.conentBgView.snp.makeConstraints { make in
            make.leading.trailing.equalTo(0)
            make.top.equalTo(self.titleBgView.snp.bottom).offset(-1)
        }
        

        self.contentLabel.snp.makeConstraints { make in
            make.leading.equalTo(25.uiX)
            make.trailing.equalTo(-25.uiX)
            make.top.equalTo(30.uiX)
            make.bottom.equalTo(self.okBtn.snp.top).offset(-30.uiX)
        }
        
        
        self.okBtn.snp.makeConstraints { make in
            make.leading.equalTo(50.uiX)
            make.trailing.equalTo(-50.uiX)
            make.bottom.equalTo(-20.uiX)
        }
        
        self.okBtn.titleEdgeInsets = UIEdgeInsets(top: -5, left: 0, bottom: 0, right: 0)
        
        self.layoutIfNeeded()
        self.closeBtn.isHidden = false

    }
    
    override func onCloseView() {
        UserdefaultManager.shared.userToken = ""
        exit(0)
    }
    
}

