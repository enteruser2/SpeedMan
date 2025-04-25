//
//  UserManager.swift
//  WallPaper
//
//  Created by LiQi on 2020/4/15.
//  Copyright © 2020 Qire. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift


enum UserLoginType {
    case phone(mobile: String, code: String)
    case aliAu(token: String)
    case wechat(openId: String, nickName: String, avatar: String, sex: Int)
    case apple(openId: String, nickName: String)
}

enum LoginStatus: Int {
    case notLogin
    case login
    case change
    case loginOut
    
}


enum LanguageType:String {
    
    /// 英语
    case Language_en="en"
    /// 印度尼西亚
    case Language_in="in"
    /// 葡萄牙
    case Language_pt="pt"
    /// 菲律宾
    case Language_fil="fil"
    /// 土耳其
    case Language_tr="tr"
    /// 泰国
    case Language_th="th"
    /// 中国
    case Language_zh="zh"
    /// 越南
    case Language_vi="vi"
    /// 埃及
    case Language_ar="ar"
    /// 印度
    case Language_hi="hi"
    /// 马来西亚
    case Language_ms="ms"
    /// 乌尔都语
    case Language_ur="ur"
    
}

@objc
@objcMembers class UserManager: NSObject {
    
    static let shared = UserManager()
    let login = BehaviorRelay<(UserModel?, LoginStatus)>(value: (nil, .notLogin))
    
    //    let login1 = PublishRelay<(UserModel?, LoginStatus)>()
    
    let userInfoEvent = PublishRelay<UserModel>()
    
    var translateModel: TranslateModel?
    var display_fb = 0
    var isGameRestart = false
    var isChangeLanguage = false
    var cocos_InteractID = -1 //  cocos 互动任务广告ID
    
    private let loading = ActivityIndicator()
    private let error = ErrorTracker()
    private let onView = Application.shared.window
    var isLogin: Bool {
        let s = login.value
        return s.1 != .loginOut && s.1 != .notLogin
    }
    
    var user: UserModel? {
        return login.value.0
    }
    
    
    override init() {
        super.init()
    
        
        setupBinding()
        
    }
    
    private func setupBinding() {
        
        if let view = onView {
            error.asObservable().map { (error) -> NetError? in
                CommonTool.LogLine(message:error)
                if let e = error as? NetError {
                    return e
                }
                return NetError.error(code: -1111, msg: error.localizedDescription)
            }.filterNil().bind(to: view.rx.toastError).disposed(by: rx.disposeBag)
            
            loading.asObservable().bind(to: view.rx.mbHudLoaing).disposed(by: rx.disposeBag)
        }
        
    }
    

    
    func loginUser() -> Single<UserModel?> {
        
        return Single<UserModel?>.create { single in
            
            let user = NetManager.requestObj(.userInfo, type: UserModel.self).asObservable()
            user.subscribe(onNext: { newuser in
                UserManager.shared.login.accept((newuser, .login))
                single(.success(newuser))
            },onError: {error in
                single(.failure(error))
            }).disposed(by: self.rx.disposeBag)
            
            return Disposables.create()
        }
    }
    
    func translateRequest() -> Single<TranslateModel?> {
        return Single<TranslateModel?>.create { single in
            
            let translate = NetManager.requestObj(.translate, type: TranslateModel.self)
            translate.asObservable().trackError(self.error).subscribe(onNext: { translateModel in
                guard let translatemodel = translateModel else {
                    single(.failure(NetError.error(code: -1000, msg: "error")))
                    return
                }
                
                single(.success(translatemodel))
                
            }, onError: { error in
                single(.failure(error))
            }).disposed(by: self.rx.disposeBag)
            
            return Disposables.create()
        }
    }
    
    
    // MARK: - Login
    func deviceLogin() -> Single<DeviceLoginModel?> {
        
        //        return Single.create { single in
        //
        //            let translate = NetManager.requestObj(.translate, type: TranslateModel.self).asObservable()
        //            let deviceLogin = NetManager.requestObj(.deviceLogin, type: DeviceLoginModel.self).asObservable()
        //
        //            let zip = Observable.zip(translate, deviceLogin)
        //            zip.subscribe(onNext: { (translate, deviceLogin) in
        //                guard let deviceLogin = deviceLogin else {
        //                    single(.failure(NetError.error(code: -1000, msg: "error")))
        //                    return
        //                }
        //                self.translateModel = translate
        //                UserdefaultManager.shared.userToken = deviceLogin.token
        //                self.display_fb = deviceLogin.display_fb
        //                single(.success(deviceLogin))
        //            }, onError: { error in
        //                single(.failure(error))
        //            }).disposed(by: self.rx.disposeBag)
        //
        //                return Disposables.create()
        //            }
        
        return Single<DeviceLoginModel?>.create { single in
            let login = NetManager.requestObj(.deviceLogin, type: DeviceLoginModel.self)
            login.asObservable().trackError(self.error).subscribe(onNext: { deviceLogin in
                guard let deviceLogin = deviceLogin else {
                    single(.failure(NetError.error(code: -1000, msg: "error")))
                    return
                }
                
                UserdefaultManager.shared.userToken = deviceLogin.token
                self.display_fb = deviceLogin.display_fb
                single(.success(deviceLogin))
                
            }, onError: { error in
                single(.failure(error))
            }).disposed(by: self.rx.disposeBag)
            
            return Disposables.create()
        }
        
    }
    
    
    // MARK: - Login
    func oauthLoginUser(loginModel: LoginModel) -> Single<DeviceLoginModel?> {
        
        return Single<DeviceLoginModel?>.create { single in
            let login = NetManager.requestObj(.login(loginModel: loginModel), type: DeviceLoginModel.self)
            login.asObservable().trackActivity(self.loading).trackError(self.error).subscribe(onNext: { deviceLogin in
                guard let deviceLogin = deviceLogin else {
                    single(.failure(NetError.error(code: -1000, msg: "error")))
                    return
                }
                
                UserdefaultManager.shared.userToken = deviceLogin.token
                self.display_fb = deviceLogin.display_fb
                single(.success(deviceLogin))
                
            }, onError: { error in
                single(.failure(error))
            }).disposed(by: self.rx.disposeBag)
            
            return Disposables.create()
        }
    }
}

