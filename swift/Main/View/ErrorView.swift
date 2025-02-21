//
//  EmptyView.swift
//  CrazyBird
//
//  Created by 7x on 2024/3/1.
//

import UIKit
import SnapKit
//import YYText
class ErrorView: UIView {
    
//    let bgImgView = UIImageView(image: UIImage(named: "bg_image"))
    let bgImgView = UIImageView(image: UIImage(named: ""))
    let imgView = UIImageView(image: UIImage(named: "nonetwork"))
//    let label: YYLabel = {
//        let l = YYLabel()
//        l.text = "No network. Tap to try again~"
//        let attributedStr = NSMutableAttributedString(string: l.text ?? "")
//        attributedStr.yy_setUnderlineStyle(NSUnderlineStyle.single, range: NSRange(location: 0, length: attributedStr.length))
//        attributedStr.yy_setColor(UIColor.init(hexString: "#45906A"), range: NSRange(location: 0, length: attributedStr.length))
//        attributedStr.yy_setFont(.init(style: .ARIALBold, size: 17), range: NSRange(location: 0, length: attributedStr.length))
//        attributedStr.yy_setAlignment(.center, range: NSRange(location: 0, length: attributedStr.length))
//        l.attributedText = attributedStr
//        l.numberOfLines = 0
//
//        return l
//    }()
    
        let label: UILabel = {
            let l = UILabel()
            let str = "No network. Tap to try again~"
            l.textAlignment = .center
            let attributedStr = NSMutableAttributedString(string: str)
            attributedStr.addAttribute(NSAttributedString.Key.underlineStyle,value: 1, range: NSRange(location: 0, length: str.count))
            attributedStr.addAttribute(.foregroundColor, value: UIColor(hexString: "#70490B")!, range: NSRange(location: 0, length: str.count))
            attributedStr.addAttribute(.font, value: UIFont(style: .ARIALBold, size: 17), range: NSRange(location: 0, length: str.count))

            l.attributedText = attributedStr
            l.numberOfLines = 0
            
            return l
        }()

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
        addSubview(bgImgView)
        addSubview(imgView)
        addSubview(label)
        self.backgroundColor = UIColor(hexString: "#FFFAE1")
        setUI()
    }
    
    func setUI()
    {
        snp.removeConstraints()
        bgImgView.snp.makeConstraints { make in
            make.leading.trailing.top.bottom.equalToSuperview()
        }
        
        imgView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(0.uiX)
            make.width.equalTo(imgView.snpSize.width)
            make.height.equalTo(imgView.snpSize.height)
        }
        
        label.snp.makeConstraints { make in
            make.top.equalTo(imgView.snp.bottom).offset(40.uiX)
            make.leading.equalToSuperview().offset(60.uiX)
            make.trailing.equalToSuperview().offset(-60.uiX)
        }

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
