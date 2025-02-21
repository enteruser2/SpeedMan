//
//  UIFont+Extensions.swift
//  WallPaper
//
//  Created by LiQi on 2020/4/10.
//  Copyright © 2020 Qire. All rights reserved.
//

import UIKit

extension UIFont {
    
    enum FontName: String {
        case ARIAL            = "Arial"
        case ARIALBold        = "Arial-BoldMT"
        case ARIALBoldITALIC  = "Arial-BoldItalicMT"
        case ARIALITALIC      = "Arial-ItalicMT"
    }

    convenience init(style: FontName, size: CGFloat) {
        self.init(name: style.rawValue, size: size.uiX)!
    }
    

}
