//
//  AdModel.swift
//  CrazyBird
//
//  Created by 7x on 2024/3/21.
//

import HandyJSON

class FetchAdModel : HandyJSON {
    
    var type: Int = 0
    var id: String = ""
    var MaxVideoTotal: Int = 0
    var sId: String = ""
    
    required init() {
        
    }
    
    func mapping(mapper: HelpingMapper) {
        mapper <<< type <-- "Cuttype"
        mapper <<< id <-- "Cutid"
        mapper <<< MaxVideoTotal <-- "CutMaxVideoTotal"
        mapper <<< sId <-- "CutsId"
    }
}

