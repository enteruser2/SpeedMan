//
//  UIImageView+Extension.swift
//  WallPaper
//
//  Created by LiQi on 2020/4/13.
//  Copyright © 2020 Qire. All rights reserved.
//

import UIKit

extension UIImageView {
    
    var snpSize: CGSize {
        if let image = image {
            return .init(width: Float(image.size.width).uiX, height: Float(image.size.height).uiX)
        }
        return .zero
    }
    
    var snpScale: CGFloat {
        let size = snpSize
        if size == .zero {
            return 0
        }
        let scale = size.height/size.width
        return scale
    }
    
    func getPeyIcon(id:Int) -> String{
        
        var imageStr  = "icon_default"
        let imageView = UIImageView()
        switch id {
        case 11:
            // dana
            imageStr = "icon_dana_11"
            break
        case 12:
            // gopay
            imageStr = "icon_gopay_12"
            break
        case 13:
            // ovo
            imageStr = "icon_ovo_13"
            break
        case 31:
            // pagbank
            imageStr = "icon_pagbank_31"
            break
        case 32:
            // pix
            imageStr = "icon_pix_32"
            break
        case 35:
            // pagsmile
            imageStr = "icon_pagsmile_35"
            break
        case 41:
            // truemoney
            imageStr = "icon_truemoney_41"
            break
        case 51:
            // gcash
            imageStr = "icon_gcash_51"
            break
        case 52:
            // lazada
            imageStr = "icon_lazada_52"
            break
        case 131:
            // papara
            imageStr = "icon_papara_131"
            break
        case 141:
            // vodafone
            imageStr = "icon_vodafone_141"
            break
        case 142:
            // etisalat
            imageStr = "icon_etisalat_142"
            break
        case 143:
            // orange
            imageStr = "icon_orange_143"
            break
        case 171:
            // transfer
            imageStr = "icon_transfer_171"
            break
        case 201:
            // jazzcash
            imageStr = "icon_jazzcash_201"
            break
        case 202:
            // easypaisa
            imageStr = "icon_easypaisa_202"
            break
        case 10001:
            // paypal
            imageStr = "icon_paypal_10001"
            break
        default:
            // default
            imageStr = "icon_default"
            break
        }

        return imageStr
    }
    
}
