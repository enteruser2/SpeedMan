//
//  AdModel.swift
//  CrazyBird
//
//  Created by 7x on 2024/3/21.
//

import HandyJSON

class ShareModel : HandyJSON {
    
    var title: String = ""
    var text: String = ""
    var url: String = ""

    required init() {
        
    }
    
    func mapping(mapper: HelpingMapper) {
        mapper <<< title <-- "Mantitle"
        mapper <<< text <-- "Mantext"
        mapper <<< url <-- "Manurl"
    }
}

