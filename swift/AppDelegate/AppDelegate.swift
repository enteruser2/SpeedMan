//
//  AppDelegate.swift
//  swift
//
//  Created by 7x on 2023/12/7.
//

import UIKit
import AppLovinSDK
import GoogleMobileAds
import FBAudienceNetwork
import MTGSDK
@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        SDKWrapper.shared().application(application, didFinishLaunchingWithOptions: launchOptions ?? Dictionary())
        Application.shared.application = application
        
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.backgroundColor = .white
        self.window = window
        Application.shared.configureMainInterface(in: window)
    
        self.window?.makeKeyAndVisible()

        FirebaseApp.configure()
        ApplicationDelegate.shared.application(application, didFinishLaunchingWithOptions: launchOptions)
    
//#if DEBUG
//        let loadSuccess = Bundle.init(path: "/Applications/InjectionIII.app/Contents/Resources/iOSInjection.bundle")?.load()
//        print("loadSuccess--"+(loadSuccess?.string ?? ""))
//#endif
        
        GIDSignIn.sharedInstance.restorePreviousSignIn { user, error in
            if error != nil || user == nil {
                // Show the app's signed-out state.
                GIDSignIn.sharedInstance.signOut()
            } else {
                // Show the app's signed-in state.
            }
        }
        
        self.setupPangleSDK()
        self.setupGoogleAdSDK()
        self.setupMaxSDK()
        
        // 常亮
        UIApplication.shared.isIdleTimerDisabled = true
        
        
        return true
    }
    
    func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
        
        let handled = ApplicationDelegate.shared.application(application, open: url, sourceApplication: sourceApplication, annotation: annotation)
        if(handled)
        {
            return handled
        }
        
        return GIDSignIn.sharedInstance.handle(url)
    }
    
    @available(iOS 9.0, *)
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any]) -> Bool {
        
        ApplicationDelegate.shared.application(
            app,
            open: url,
            sourceApplication: options[UIApplication.OpenURLOptionsKey.sourceApplication] as? String,
            annotation: options[UIApplication.OpenURLOptionsKey.annotation]
        )
        
        return GIDSignIn.sharedInstance.handle(url)
    }
    
    
    func setupPangleSDK() {
        
        let config = PAGConfig.share()
        config.appID = "8620098";
        //If you need to display open ads, you should set the app logo image
        config.appLogoImage = UIImage.init(named: "me_about_logoicon")
        //    #if DEBUG
        //        config.debugLog = true
        //    #endif
        PAGSdk.start(with: config) { success, error in
            if(success)
            {
                CommonTool.LogLine(message: "PAGSdk success \(config)")
            }
        }
    }
    
    func setupMaxSDK() {
        let initConfig = ALSdkInitializationConfiguration(sdkKey: "9u6eOigitS0Zten9IkXPybXnEfHQi2HVI2a4JDngKHTeHwDMPFCVksWdZ_3SUITJqrwTPvWmmFhO83uvJBHkaR") { builder in
            builder.mediationProvider = ALMediationProviderMAX
        }
        
        // Initialize the SDK with the configuration
        ALSdk.shared().initialize(with: initConfig) { sdkConfig in
            // Start loading ads
            CommonTool.LogLine(message: "ALSdk success \(sdkConfig)")
        }
    
    }
    
    func setupGoogleAdSDK()
    {
        GADMobileAds.sharedInstance().start(completionHandler:{_ in 
//            CommonTool.LogLine(message: "GADMobileAds success --- \(GADMobileAds.sharedInstance().versionNumber)")
        })
        
        GADMobileAds.sharedInstance().requestConfiguration.testDeviceIdentifiers = ["6c4c589775033eefeda89adc87699473"]

        // 如果您要针对 iOS 14 或更高版本进行构建，Meta Audience Network 会要求您使用以下代码明确设置其“已启用广告跟踪”标志：
        FBAdSettings.setAdvertiserTrackingEnabled(true)
        MTGSDK.sharedInstance().consentStatus = true
        MTGSDK.sharedInstance().doNotTrackStatus = false
    }
    
    
    
    func applicationWillResignActive(_ application: UIApplication) {
        SDKWrapper.shared().applicationWillResignActive(application)
        CocosBridge().applicationWillResignActive(application)

    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        SDKWrapper.shared().applicationDidBecomeActive(application)
        CocosBridge().applicationDidBecomeActive(application)
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        SDKWrapper.shared().applicationDidEnterBackground(application)
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        SDKWrapper.shared().applicationWillEnterForeground(application)
    }

    func applicationWillTerminate(_ application: UIApplication) {
        SDKWrapper.shared().applicationWillTerminate(application)
        CocosBridge().applicationWillTerminate(application)
    }

    func applicationDidReceiveMemoryWarning(_ application: UIApplication) {
        SDKWrapper.shared().applicationDidReceiveMemoryWarning(application)
    }

    

}

