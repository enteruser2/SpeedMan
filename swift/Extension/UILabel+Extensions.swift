//
//  UILabel+Extensions.swift
//  Crazy Hero
//
//  Created by 7x on 2023/12/19.
//

import UIKit

//#define KARIALBold(value) [UIFont fontWithName:@"Arial-BoldMT" size:value*ScreenScale]
//#define KARIAL(value) [UIFont fontWithName:@"Arial" size:value*ScreenScale]
//#define KARIALBoldITALIC(value) [UIFont fontWithName:@"Arial-BoldItalicMT" size:value*ScreenScale]
//#define KARIALITALIC(value) [UIFont fontWithName:@"Arial-ItalicMT" size:value*ScreenScale]



extension UILabel {
        
    // 添加描边效果的方法
    func addStroke(color: UIColor, width: CGFloat) {
        let strokeTextAttributes: [NSAttributedString.Key: Any] = [
            .strokeColor: color,
            .foregroundColor: self.textColor as UIColor,
            .strokeWidth: width,
        ]
        
        self.attributedText = NSAttributedString(string: self.text ?? "", attributes: strokeTextAttributes)
    }

    
    
    
    
    
}

