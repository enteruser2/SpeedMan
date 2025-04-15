//
//  UserdefaultManager.swift
//  VideoChat
//
//  Created by 宋道彰 on 2021/1/12.
//

import Foundation

class UserdefaultManager: NSObject {

    static let shared = UserdefaultManager()
    let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? ""
    let appName = Bundle.main.object(forInfoDictionaryKey: "CFBundleDisplayName") as? String ?? ""
    override init() {
        super.init()

    }

    
    var userToken:String{
        get{
            if let token = UserDefaults.standard.value(forKey: "UserToken"){
                return token as! String
            }else{
                return ""
            }
        }
        set{
            UserDefaults.standard.set(newValue, forKey: "UserToken")
            UserDefaults.standard.synchronize()
        }
    }


    
    
    var appleLanguages:String{
        get{
            if let language = UserDefaults.standard.value(forKey: AppDefine.KAPPLANGUAGE_KEY){
                return language as! String
            }else{
                let languages = UserDefaults.standard.value(forKey: "AppleLanguages")
                let language:String = (languages as! Array<Any>).first as! String
                let arr = (language.components(separatedBy: "-") as Array<Any>)
                var languageStr = arr.first as! String
                switch (languageStr)
                {
                case LanguageType.Language_in.rawValue:break
                case LanguageType.Language_pt.rawValue: break
                case LanguageType.Language_fil.rawValue: break
                case LanguageType.Language_tr.rawValue: break
                case LanguageType.Language_th.rawValue: break
                case LanguageType.Language_vi.rawValue: break
                case LanguageType.Language_ar.rawValue: break
                case LanguageType.Language_ms.rawValue: break
                case LanguageType.Language_hi.rawValue: break
                case LanguageType.Language_zh.rawValue: break
                case LanguageType.Language_ur.rawValue: break
                default:
                    languageStr = LanguageType.Language_en.rawValue
                    break
                }
                CommonTool.LogLine(message:"appleLanguages languages:\(String(describing: languages))")
                self.appleLanguages = languageStr
                return languageStr
            }
        }
        set{
            CommonTool.LogLine(message:"appleLanguages newValue:\(String(describing: newValue))  ")
            UserDefaults.standard.set(newValue, forKey: AppDefine.KAPPLANGUAGE_KEY)
            UserDefaults.standard.synchronize()

        }
    }
    
    var appleCountry:String{
        get{
            if let country = UserDefaults.standard.value(forKey: AppDefine.KAPPCOUNTRY_KEY){
                return country as! String
            }else{
                let languages = UserDefaults.standard.value(forKey: "AppleLanguages")
                let language:String = (languages as! Array<Any>).last as! String
                let arr = (language.components(separatedBy: "-") as Array<Any>)
                let country = arr.last as! String
                self.appleCountry = country
                return country
            }
        }
        set{
            CommonTool.LogLine(message: "appleLanguages country newValue:\(String(describing: newValue)) ")
            UserDefaults.standard.set(newValue, forKey: AppDefine.KAPPCOUNTRY_KEY)
            UserDefaults.standard.synchronize()
        }
    }
    
    
    var isShowNotificationDialog:Bool{
        get{
            if let isShow = UserDefaults.standard.value(forKey: "showNotificationDialog"){
                return isShow as! Bool
            }else{
                return false
            }
        }
        set{
            UserDefaults.standard.set(newValue, forKey: "showNotificationDialog")
            UserDefaults.standard.synchronize()
        }
    }
    
    var isShowDate:NSDate{
        get{
            if let data = UserDefaults.standard.value(forKey: "currentday"){
                return data as! NSDate
            }else{
                return NSDate()
            }
        }
        set{
            UserDefaults.standard.set(newValue, forKey: "currentday")
            UserDefaults.standard.synchronize()
        }
    }
    
    var loginStatus:Int{
        get{
            if let Status = UserDefaults.standard.value(forKey: "loginStatus"){
                return Status as! Int
            }else{
                return 0
            }
        }
        set{
            UserDefaults.standard.set(newValue, forKey: "loginStatus")
            UserDefaults.standard.synchronize()
        }
    }

}
