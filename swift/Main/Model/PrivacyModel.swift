//
//  AdModel.swift
//  CrazyBird
//
//  Created by 7x on 2024/3/21.
//

import HandyJSON

class PrivacyModel : HandyJSON {
    
    var content: String = ""

    required init() {
        
    }
    
    func mapping(mapper: HelpingMapper) {
        mapper <<< content <-- "Mancontent"
    }
}

