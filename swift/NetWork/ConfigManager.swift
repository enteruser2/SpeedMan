//
//  ConfigManager.swift
//  swift
//
//  Created by 7x on 2023/12/14.
//

import Foundation


class ConfigManager:NSObject {
    
    static let shared = ConfigManager()
    
    override init() {
        super.init()
    }
    
    func getInfoPlistString(str:String)->String{
        if let path = Bundle.main.path(forResource: "Info", ofType: "plist"),
           let config = NSDictionary(contentsOfFile: path) as? [String: Any] {
           let value = config[str]
            return value as! String
        }
        return ""
    }
    
    func getNETURLAPI()->String{
        if let path = Bundle.main.path(forResource: "Info", ofType: "plist"),
           let config = NSDictionary(contentsOfFile: path) as? [String: Any] {
            let value = config["NET_API_URL"]
            return value as! String
        }
        return ""
    }
    
    func getPSWAESKEY()->String{
        if let path = Bundle.main.path(forResource: "Info", ofType: "plist"),
           let config = NSDictionary(contentsOfFile: path) as? [String: Any] {
           let value = config["PSW_AES_KEY"]
            return value as! String
        }
        return ""
    }
    
    func getPSWSIGNKEY()->String{
        if let path = Bundle.main.path(forResource: "Info", ofType: "plist"),
           let config = NSDictionary(contentsOfFile: path) as? [String: Any] {
           let value = config["PSW_SIGN_KEY"]
            return value as! String
        }
        return ""
    }    
    
}
