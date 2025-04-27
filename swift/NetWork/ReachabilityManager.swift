//
//  ReachabilityManager.swift
//  Dingweibao
//
//  Created by LiQi on 2020/6/10.
//  Copyright © 2020 Qire. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import Alamofire

class ReachabilityManager {
    
    static let shared = ReachabilityManager()
    
    let relay = BehaviorRelay<NetworkReachabilityManager.NetworkReachabilityStatus>(value: NetworkReachabilityManager.default!.status)
    
    init() {
        
        NetworkReachabilityManager.default!.startListening(onQueue: .main, onUpdatePerforming: { status in
            self.relay.accept(status)
        })
        
    }
    
    // 是否使用VPN
    public func isUsingVPN() -> Bool {
        guard let settings = CFNetworkCopySystemProxySettings()?.takeRetainedValue() as? [String: Any],
              let scopes = settings["__SCOPED__"] as? [String: Any] else {
            return false
        }

        for (key, _) in scopes {
            if key.contains("tap") || key.contains("tun") || key.contains("ppp") || key.contains("ipsec") || key.contains("utun") {
                return true
            }
        }
        return false
    }
    
     // 是否使用代理
    public func isUsingProxy() -> Bool {
         guard let proxySettings = CFNetworkCopySystemProxySettings()?.takeRetainedValue() as? [String: Any] else {
             return false
         }

         if let httpProxy = proxySettings["HTTPEnable"] as? Int, httpProxy == 1 {
             return true
         }
         if let httpsProxy = proxySettings["HTTPSEnable"] as? Int, httpsProxy == 1 {
             return true
         }

         return false
     }
    
}
