//
//  LoginModel.swift
//  CrazyBird
//
//  Created by 7x on 2024/2/22.
//Ï

import HandyJSON
class LoginModel :HandyJSON {
        
    var  login_id: String = ""
    var  login_type: Int = 0
    var  avatar: String = ""
    var  nickname: String = ""
    var  email: String = ""
    var  access_token: String = ""
    var  os_type: Int = 2 // 0 android  2 ios
    required init() {
        
    }
    
    func mapping(mapper: HelpingMapper) {
        mapper <<< login_id <-- "Manlogin_id"
        mapper <<< login_type <-- "Manlogin_type"
        mapper <<< avatar <-- "Manavatar"
        mapper <<< nickname <-- "Mannickname"
        mapper <<< email <-- "Manemail"
        mapper <<< access_token <-- "Manaccess_token"
        mapper <<< os_type <-- "Manos_type"
    }
}


class FBLoginModel :HandyJSON {
        
    var  email: String = ""
    var  id: String = ""
    var  first_name: String = ""
    var  link: String = ""
    var  name: String = ""
    var  picture: FBLoginPictureModel = FBLoginPictureModel()

    required init() {
        
    }
}

class FBLoginPictureModel : HandyJSON {
        
    var  data: FBLoginPictureDataModel = FBLoginPictureDataModel()


    required init() {
        
    }
}

class FBLoginPictureDataModel : HandyJSON {
        
    var  url: String = ""
    required init() {
        
    }
}
