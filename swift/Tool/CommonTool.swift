//
//  CommonTool.swift
//  Crazy Hero
//
//  Created by 7x on 2023/12/19.
//

import Foundation

class CommonTool {
    
    static func isRTL() -> Bool {
        return ((Bundle.main.preferredLocalizations.first?.hasPrefix("ar")) == true)
    }
    
    static func LogLine<T>(message : T, file : String = #file, lineNumber : Int = #line) {
        
        #if DEBUG
            
            let fileName = (file as NSString).lastPathComponent
            print("[\(fileName):line:\(lineNumber)]- \(message)")
            
        #endif
    }
}
