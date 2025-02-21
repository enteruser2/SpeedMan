//
//  UpdateDialogView.swift
//  CrazyBird
//
//  Created by 7x on 2024/3/23.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa
//import YYText
class UpdateDialogView: UIView {
    
    
    
    //    let items = BehaviorRelay<[String]>(value: [])
    
    
    let items = NSMutableArray()
    var table_height = 0.0
    lazy var bgView: UIView = {
        let bgView = UIView.init()
        return bgView
    }()
    
    lazy var titleBgView: UIView = {
        let titleBgView = UIView.init()
        return titleBgView
    }()
    
    fileprivate lazy var titleImageView: UIImageView = {
        let titleImageView = UIImageView.init()
        titleImageView.image = .init(named: "update_bg1")
        titleImageView.contentMode = .scaleToFill
        return titleImageView
    }()
    
    fileprivate lazy var titleLabel: UILabel = {
        let titleLabel = UILabel.init()
        titleLabel.textColor = UIColor(hexString: "#FFFFFF")
        titleLabel.font = UIFont.init(style: .ARIALBold, size: 23)
        titleLabel.numberOfLines = 0
        titleLabel.textAlignment = .center
        titleLabel.text = UserManager.shared.translateModel?.t2001
        titleLabel.addStroke(color: UIColor(hexString: "#0A7526")!, width: -2.0)
        return titleLabel
    }()
    
    fileprivate lazy var titleLabel1: UILabel = {
        let titleLabel = UILabel.init()
        titleLabel.textColor = UIColor(hexString: "#03694C")
        titleLabel.font = UIFont.init(style: .ARIALBold, size: 16)
        titleLabel.numberOfLines = 0
        titleLabel.textAlignment = .center
        titleLabel.text = UserManager.shared.translateModel?.t2002
        return titleLabel
    }()
    
    lazy var titleLabel2: UIButton = {
        let btn = UIButton.init(type: .custom)
        btn.setTitle("V\(UserdefaultManager.shared.version)", for: .normal)
        btn.setTitleColor(UIColor(hexString: "#8A4B00"), for: .normal)
        btn.setBackgroundImage(UIImage.init(named: "update_bg3"), for: .normal)
        btn.titleLabel?.font = UIFont.init(style: .ARIALBold, size: 14)
        return btn
    }()
    
    lazy var conentBgView: UIView = {
        let conentBgView = UIView.init()
        conentBgView.backgroundColor = UIColor(hexString: "#FCFEF0")
        return conentBgView
    }()
    
    lazy var rewardLabel: UILabel = {
        let titleLabel = UILabel.init()
        titleLabel.textColor = UIColor(hexString: "#ED5900")
        titleLabel.font = UIFont.init(style: .ARIALBold, size: 17)
        titleLabel.numberOfLines = 0
        titleLabel.textAlignment = .center
        
        let attri = NSMutableAttributedString(string: UserManager.shared.translateModel!.t2006)
        let attch = NSTextAttachment()
        attch.image = UIImage(named: "update_coin_icon")
        attch.bounds = CGRect(x: 0, y: -3, width: attch.image!.size.width, height: attch.image!.size.height)
        
        let stringImage = NSAttributedString(attachment: attch)
        attri.insert(stringImage, at: attri.length)
        var str = NSAttributedString(string:" "+String().unitConversionNumInt(num: UserManager.shared.user!.UpdateVersionRewardGold, isUnit: true, isFormat: true))
        attri.insert(str, at: attri.length)
        titleLabel.attributedText = attri
        return titleLabel
    }()
    
    
    lazy var okBtn: UIButton = {
        let okBtn = UIButton.init(type: .custom)
        okBtn.setTitle(UserManager.shared.translateModel?.t2004, for: .normal)
        okBtn.setTitleColor(UIColor(hexString:"#FEFEFE"), for: .normal)
        okBtn.titleLabel?.font = UIFont(style: .ARIALBold, size: 21)
        okBtn.titleLabel?.addStroke(color: UIColor(hexString: "#A54718")!, width: -3.uiX)
        okBtn.titleLabel?.textAlignment = .center
        okBtn.setBackgroundImage(UIImage(named: "me_feedback_Orangebutton_nor"), for: .normal)
        okBtn.setBackgroundImage(UIImage(named: "me_feedback_Orangebutton_sel"), for: .highlighted)
        okBtn.titleEdgeInsets = UIEdgeInsets(top: -2, left: 0, bottom: 0, right: 0)
        okBtn.rx.tap.subscribe (onNext:{ _ in
            
        }).disposed(by: self.rx.disposeBag)
        
        return okBtn
    }()
    
    
    fileprivate lazy var cancel: UILabel = {
        let l = UILabel()
        let str = UserManager.shared.translateModel?.t2005
        l.textAlignment = .center
        let attributedStr = NSMutableAttributedString(string: str ?? "")
        attributedStr.addAttribute(NSAttributedString.Key.underlineStyle,value: 1, range: NSRange(location: 0, length: str!.count))
        attributedStr.addAttribute(.foregroundColor, value: UIColor(hexString: "#6F6F6F")!, range: NSRange(location: 0, length: str!.count))
        attributedStr.addAttribute(.font, value: UIFont(style: .ARIAL, size: 16), range: NSRange(location: 0, length: str!.count))

        l.rx.tap().subscribe (onNext:{ _ in
            self.removeFromSuperview()
            CocosSwift.onDialogDismiss(type: "1")
        }).disposed(by: self.rx.disposeBag)
        l.attributedText = attributedStr
                
        return l
    }()
    

    
    
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: CGRectZero, style: .plain)
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        tableView.showsHorizontalScrollIndicator = false
        tableView.backgroundColor = .clear
        tableView.bounces = false
        tableView.delegate = self
        tableView.dataSource = self
        if #available(iOS 11, *) {
            tableView.contentInsetAdjustmentBehavior = .never
        }
        tableView.register(cellType: UpdateViewCell.self)
        
        return tableView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.black.withAlphaComponent(0.7)
        
        self.addSubview(self.bgView)
        self.bgView.addSubview(self.titleBgView)
        self.bgView.addSubview(self.conentBgView)
        
        self.titleBgView.addSubview(self.titleImageView)
        self.titleBgView.addSubview(self.titleLabel)
        self.titleBgView.addSubview(self.titleLabel1)
        self.titleBgView.addSubview(self.titleLabel2)
        
        self.conentBgView.addSubview(self.tableView)
        self.conentBgView.addSubview(self.rewardLabel)
        self.conentBgView.addSubview(self.okBtn)
        self.conentBgView.addSubview(self.cancel)
        
        
        setUI()
        
        setdata()
        
    }
    
    func setdata()
    {
        let str = UserManager.shared.user?.versionUpgradeDesc
        let result = str!.split(separator: "\n")
        for i in result {
            self.items.add(i)
        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUI(){
        bgView.snp.makeConstraints { make in
            make.center.equalTo(self)
            make.leading.equalTo(self).offset(21.uiX)
            make.trailing.equalTo(self).offset(-21.uiX)
        }
        
        titleBgView.snp.makeConstraints { make in
            make.top.leading.trailing.equalTo(0)
        }
        
        titleImageView.snp.makeConstraints { make in
            make.top.leading.trailing.equalTo(0)
        }
        
        titleLabel.snp.makeConstraints { make in
            
            make.top.equalTo(20.uiX)
            make.leading.equalTo(30.uiX)
            make.trailing.equalTo(-30.uiX)
        }
        
        
        titleLabel1.snp.makeConstraints { make in
            make.top.equalTo(self.titleLabel.snp.bottom).offset(5.uiX)
            make.leading.equalTo(30.uiX)
            make.trailing.equalTo(-30.uiX)
        }
        
        titleLabel2.snp.makeConstraints { make in
            make.top.equalTo(self.titleLabel1.snp.bottom).offset(6.uiX)
            make.height.equalTo(25.uiX)
            make.width.equalTo(70.uiX)
            
            make.centerX.equalToSuperview()
            make.bottom.equalTo(self.titleBgView.snp.bottom).offset(-30.uiX)
        }
        
        conentBgView.snp.makeConstraints { make in
            
            make.top.equalTo(self.titleBgView.snp.bottom).offset(-10.uiX)
            make.leading.trailing.equalTo(0)
            make.bottom.equalTo(self.bgView.snp.bottom)
            
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(self.conentBgView).offset(10.uiX)
            make.leading.equalTo(25.uiX)
            make.trailing.equalTo(-20.uiX)
            make.height.equalTo(500.uiX)
            
        }
        
        
        rewardLabel.snp.makeConstraints { make in
            make.top.equalTo(tableView.snp.bottom).offset(20.uiX)
            make.leading.trailing.equalTo(tableView)
        }
        
        if(UserManager.shared.user!.mustUpdateVersionStatus == 2)
        {
            okBtn.snp.makeConstraints { make in
                
                make.top.equalTo(rewardLabel.snp.bottom).offset(10.uiX)
                make.leading.equalTo(50.uiX)
                make.trailing.equalTo(-50.uiX)
                make.bottom.equalTo(conentBgView.snp.bottom).offset(-20.uiX)
            }
            
        }
        else
        {
            okBtn.snp.makeConstraints { make in
                
                make.top.equalTo(rewardLabel.snp.bottom).offset(10.uiX)
                make.leading.equalTo(50.uiX)
                make.trailing.equalTo(-50.uiX)
            }
            
            cancel.snp.makeConstraints { make in
                
                make.top.equalTo(okBtn.snp.bottom).offset(10.uiX)
                make.leading.trailing.equalTo(tableView)
                make.bottom.equalTo(conentBgView.snp.bottom).offset(-20.uiX)
            }
        }
        
        self.layoutIfNeeded()
        conentBgView.roundCorners([.bottomLeft, .bottomRight], radius: 10.uiX)
        
    }
}

extension UpdateDialogView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        let height =  tableView.fd_heightForCell(withIdentifier: UpdateViewCell.reuseIdentifier, cacheBy: indexPath) { (cell) in
            if let cell1 = cell as? UpdateViewCell {
                cell1.setTitleName(title: self.items[indexPath.row] as! String)
            }
        }
        table_height += height
        if(indexPath.row == self.items.count-1)
        {
            tableView.snp.updateConstraints { make in
                
                make.height.equalTo(table_height)
            }
            self.layoutIfNeeded()
            table_height = 0
        }
        return height
    }
}

extension UpdateDialogView: UITableViewDataSource {
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.items.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell =  tableView.dequeueReusableCell(withIdentifier: UpdateViewCell.reuseIdentifier)
        if cell == nil{
            cell = UpdateViewCell(style: .default, reuseIdentifier: UpdateViewCell.reuseIdentifier)
        }
        
        (cell as! UpdateViewCell).setTitleName(title: self.items[indexPath.row] as! String)
        return cell!
    }
}


class UpdateViewCell: TableViewCell {
    
    fileprivate lazy var titleImageView: UIImageView = {
        let titleImageView = UIImageView.init()
        titleImageView.image = .init(named: "update_circular")
        titleImageView.contentMode = .scaleToFill
        return titleImageView
    }()
    
    fileprivate lazy var titleLabel: UILabel = {
        let titleLabel = UILabel.init()
        titleLabel.textColor = UIColor(hexString: "#000000")
        titleLabel.font = UIFont.init(style: .ARIAL, size: 16)
        titleLabel.numberOfLines = 0
        return titleLabel
    }()
    
    fileprivate lazy var mainContentView: UIView = {
        let lbl = UIView()
        return lbl
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .clear
        selectionStyle = .none
        contentView.backgroundColor = .clear
        
        contentView.addSubview(self.mainContentView)
        self.mainContentView.addSubview(self.titleImageView)
        self.mainContentView.addSubview(self.titleLabel)
        
    }
    
    func setTitleName(title:String){
        self.titleLabel.text = title
        setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUI(){
        
        mainContentView.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.top.equalTo(10.uiX)
            make.bottom.equalTo(contentView.snp.bottom).offset(0.uiX).priority(750);// 设置自己的约束权限高于系统cell 默认高度44的权限 防止约束冲突
        }
        
        self.titleImageView.snp.makeConstraints { make in
            make.top.equalTo(10.uiX)
            make.leading.equalTo(0)
            make.width.height.equalTo(8.uiX)
        }
        
        self.titleLabel.snp.makeConstraints { make in
            make.top.equalTo(5.uiX)
            make.leading.equalTo(self.titleImageView.snp.trailing).offset(15.uiX)
            make.trailing.equalTo(0)
            make.bottom.equalTo(mainContentView.snp.bottom).offset(0.uiX)
        }
    }
}
