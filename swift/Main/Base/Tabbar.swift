//
//  Tabbar.swift
//  VideoChat
//
//  Created by liqi on 2020/11/16.
//

import UIKit
import RxSwift
import RxCocoa
import SwifterSwift
import SnapKit

class TabBar: UITabBar {
    
    lazy var messageLbl: UILabel = {
        let lbl = UILabel()
        lbl.text = "0"
        lbl.textAlignment = .center
        lbl.textColor = .init(hex: "#FF007D")
        lbl.backgroundColor = .white
        lbl.cornerRadius = 8
        lbl.font = .init(style: .regular, size: 11)
        lbl.isHidden = true
        return lbl
    }()
    
    lazy var squareLbl: UILabel = {
        let lbl = UILabel()
        lbl.text = "0"
        lbl.textAlignment = .center
        lbl.textColor = .init(hex: "#FF007D")
        lbl.backgroundColor = .white
        lbl.cornerRadius = 8
        lbl.font = .init(style: .regular, size: 11)
        lbl.isHidden = true
        return lbl
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
//        roundCorners([.topLeft, .topRight], radius: 10)
        if let tabBarButtonClass = NSClassFromString("UITabBarButton") {
            let items = subviews.filter { sub -> Bool in
                return sub.isKind(of: tabBarButtonClass)
            }
            
            for (idx, v) in items.enumerated() {
                if idx == 1 {
                    v.addSubview(squareLbl)
                    squareLbl.frame = .init(x: v.width/2.0 + 15, y: 2, width: 16, height: 16)
                }
                if idx == 3 {
                    v.addSubview(messageLbl)
                    messageLbl.frame = .init(x: v.width/2.0 + 15, y: 2, width: 16, height: 16)
                }
            }
        }
    }
    
}

