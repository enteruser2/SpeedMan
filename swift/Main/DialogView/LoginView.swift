//
//  LoginView.swift
//  CrazyBird
//
//  Created by 7x on 2024/2/19.
//

import Foundation
import UIKit
import RxSwift

protocol LoginCloseDelegate: AnyObject {
    
    func LoginCloseEvent()
    
}


class LoginView: BaseDialogView {
    private var loading = DisposeBag()
    private var launchViewController : Any? = nil
    var delegate:LoginCloseDelegate?

    fileprivate lazy var googleBtn: UIButton = {
        let googleBtn = UIButton.init(type: .custom)
        googleBtn.setTitle(UserManager.shared.translateModel?.t103, for: .normal)
        googleBtn.setTitleColor(UIColor(hexString:"#000000"), for: .normal)
        googleBtn.setImage(UIImage.init(named: "enroll_google_one_icon"), for: .normal)
        googleBtn.titleLabel?.font = UIFont(style: .ARIALBold, size: 16)
        googleBtn.titleLabel?.textAlignment = .left
        googleBtn.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 25)
        googleBtn.addBorderWithcornerRad(6, lineCollor: UIColor(hexString: "#000000"), lineWidth: 0.6)
        googleBtn.backgroundColor = UIColor(hexString: "#ffffff")
        
        googleBtn.rx.tap.subscribe (onNext:{ _ in
            self.googleLogin()
        }).disposed(by: self.rx.disposeBag)
        
        googleBtn.tag = 1
        googleBtn.addTarget(self, action: #selector(buttonBackGroundHighlighted(sender:)), for: .touchDown)
        googleBtn.addTarget(self, action: #selector(buttonBackGroundHighlighted1(sender:)), for: [.touchUpInside, .touchUpOutside, .touchCancel])
        
        return googleBtn
    }()
    
    fileprivate lazy var facebookBtn: UIButton = {
        let facebookBtn = UIButton.init(type: .custom)
        facebookBtn.setTitle(UserManager.shared.translateModel?.t102, for: .normal)
        facebookBtn.setTitleColor(UIColor(hexString:"#000000"), for: .normal)
        facebookBtn.setImage(UIImage.init(named: "enroll_facebook_one_icon"), for: .normal)
        facebookBtn.titleLabel?.font = UIFont(style: .ARIALBold, size: 16)
        facebookBtn.titleLabel?.textAlignment = .left
        facebookBtn.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 25)
        facebookBtn.addBorderWithcornerRad(6, lineCollor: UIColor(hexString: "#000000"), lineWidth: 0.6)
        facebookBtn.backgroundColor = UIColor(hexString: "#ffffff")
        
        facebookBtn.rx.tap.subscribe (onNext:{ _ in
            self.facebookLogin()
        }).disposed(by: self.rx.disposeBag)
        facebookBtn.tag = 2
        facebookBtn.addTarget(self, action: #selector(buttonBackGroundHighlighted(sender:)), for: .touchDown)
        facebookBtn.addTarget(self, action: #selector(buttonBackGroundHighlighted1(sender:)), for:[.touchUpInside, .touchUpOutside, .touchCancel])
        return facebookBtn
    }()
    
    fileprivate lazy var appleBtn: UIButton = {
        let appleBtn = UIButton.init(type: .custom)
        return appleBtn
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.conentBgView.addSubview(self.googleBtn)
        if(UserManager.shared.display_fb == 0)
        {
            self.conentBgView.addSubview(self.facebookBtn)
        }
        self.conentBgView.addSubview(self.appleBtn)
        setTitleText(text: UserManager.shared.translateModel?.t101)
        
        if(self.getCurrentVC().isKind(of: LaunchViewController.self))
        {
            launchViewController = self.getCurrentVC()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setUI() {
        super.setUI()
        self.conentBgView.snp.makeConstraints { make in
            make.leading.trailing.equalTo(0)
            make.top.equalTo(self.titleBgView.snp.bottom).offset(0)
        }
        

        if(UserManager.shared.display_fb == 0)
        {
            self.googleBtn.snp.makeConstraints { make in
                
                make.leading.equalTo(20.uiX)
                make.trailing.equalTo(-20.uiX)
                make.height.equalTo(40.uiX)
                make.top.equalTo(20.uiX)
            }
            
            
            self.facebookBtn.snp.makeConstraints { make in
                
                make.leading.trailing.equalTo(self.googleBtn)
                make.height.equalTo(self.googleBtn)
                make.top.equalTo(self.googleBtn.snp.bottom).offset(15.uiX)
            }
            
            if #available(iOS 13.0, *) {
                self.appleBtn.snp.makeConstraints { make in
                    make.leading.trailing.equalTo(self.googleBtn)
                    make.height.equalTo(self.googleBtn)
                    make.top.equalTo(self.facebookBtn.snp.bottom).offset(15.uiX)
                    make.bottom.equalTo(-20.uiX)
                }
            }
            else
            {
                self.facebookBtn.snp.makeConstraints { make in
                    make.bottom.equalTo(-20.uiX)
                }
            }
        }
        else
        {
            self.googleBtn.snp.makeConstraints { make in
                
                make.leading.equalTo(20.uiX)
                make.trailing.equalTo(-20.uiX)
                make.height.equalTo(40.uiX)
                make.top.equalTo(20.uiX)
            }
            
            if #available(iOS 13.0, *) {
                self.appleBtn.snp.makeConstraints { make in
                    make.leading.trailing.equalTo(self.googleBtn)
                    make.height.equalTo(self.googleBtn)
                    make.top.equalTo(self.googleBtn.snp.bottom).offset(15.uiX)
                    make.bottom.equalTo(-20.uiX)
                }
            }
            else
            {
                self.googleBtn.snp.makeConstraints { make in
                    make.bottom.equalTo(-20.uiX)
                }
            }
            
        }
        
        self.layoutIfNeeded()
        addAppleBtn()
    }
    
    func addAppleBtn(){
        if #available(iOS 13.0, *) {
            SignWithAppleHelper.signInWithApple(withButtonRect: CGRect(x: 0, y: 0, width: self.appleBtn.width, height: self.appleBtn.height), withSupView: self.appleBtn, with: .signIn, with: .whiteOutline) { authorization, user in
                
                let appleIDCredential:ASAuthorizationAppleIDCredential = authorization.credential as! ASAuthorizationAppleIDCredential;
//                CommonTool.LogLine(message: "oauthLoginUser ： \(appleIDCredential.authorizationCode)")
                let loginModel = LoginModel()
                
                if let string = NSString(data: appleIDCredential.authorizationCode ?? Data(), encoding: NSUTF8StringEncoding) {
//                    CommonTool.LogLine(message: "oauthLoginUser ： \(string)")
                    loginModel.access_token = string as String
                } else {
                    loginModel.access_token = ""
                }

                loginModel.login_type = 3
                loginModel.os_type = 2
                UserManager.shared.oauthLoginUser(loginModel: loginModel).asObservable().subscribe(onNext: { oauthLogin in
                    
                    CommonTool.LogLine(message: "oauthLoginUser ： \(String(describing: oauthLogin))")
                    self.getUserInfo()
                    
                }, onError: {error in
                    CommonTool.LogLine(message: "deviceLogin error： \(String(describing: error))")
                    
                }).disposed(by: self.loading)
//                
            } failure: { error in
                
            }
            
        }
        else
        {
            
        }
    }
    
    func googleLogin(){
        GIDSignIn.sharedInstance.signIn(withPresenting: self.getCurrentVC()) { signInResult, error in
            if let error = error {
                // 处理错误
            } else if let signInResult = signInResult {
                // 用户成功登录
                signInResult.user.refreshTokensIfNeeded { user, error in
                    guard error == nil else { return }
                    guard let user = user else { return }
                    
                    let idToken = user.idToken
                    let loginModel = LoginModel()
                    loginModel.access_token = idToken?.tokenString ?? ""
                    loginModel.login_id = signInResult.user.userID ?? ""
                    loginModel.login_type = 1
                    loginModel.os_type = 2
                    loginModel.nickname = signInResult.user.profile?.name ?? ""
                    loginModel.email = signInResult.user.profile?.email ?? ""
                    loginModel.avatar = signInResult.user.profile?.imageURL(withDimension: 0)?.absoluteString ?? ""
                    
                    self.oauthLoginUser(loginModel: loginModel)
                    
                }
            }
        }
    }
    
    
    func facebookLogin(){
        let loginManager = LoginManager()
        loginManager.logIn(permissions: ["public_profile","email"], from:self.getCurrentVC()) { [self] result, error in
            
            if let error = error {
                // 处理错误
                CommonTool.LogLine(message:"登录失败: \(error.localizedDescription)")
            } else if result?.isCancelled == true {
                // 用户取消登录
                CommonTool.LogLine(message:"登录取消")
            } else {
                // 获取访问令牌
                getUserInfoWithResult(loginResult: result!)
            }
        }
        
    }
    
    func getUserInfoWithResult(loginResult:LoginManagerLoginResult)
    {
    
        let loginModel = LoginModel()
        loginModel.login_id =  ""
        loginModel.login_type = 2
        loginModel.os_type = 2
        loginModel.nickname = ""
        loginModel.email =  ""
        loginModel.avatar =  ""
        loginModel.access_token = loginResult.authenticationToken?.tokenString ?? ""
        
        self.oauthLoginUser(loginModel: loginModel)
    }
    
    func oauthLoginUser(loginModel:LoginModel)
    {
        UserManager.shared.oauthLoginUser(loginModel: loginModel).asObservable().subscribe(onNext: { deviceLogin in
            
            CommonTool.LogLine(message: "oauthLoginUser ： \(String(describing: deviceLogin))")
            self.getUserInfo()
            
        }, onError: {error in
            CommonTool.LogLine(message: "deviceLogin error： \(String(describing: error))")
            
        }).disposed(by: self.loading)
    }
    
    func getUserInfo()
    {
        CommonTool.LogLine(message: "deviceLogin self.getCurrentVC()： \(String(describing: self.getCurrentVC()))")
        
        if(self.launchViewController != nil)
        {
            UserdefaultManager.shared.loginStatus = 0
            (self.launchViewController as! LaunchViewController).getuserModel()
        }
        
        self.removeFromSuperview()
    }
    
    @objc func buttonBackGroundHighlighted(sender:UIButton){
        
        if (sender.tag == 1) {
            self.googleBtn.backgroundColor = UIColor(hexString: "#999999");
        }
        else
        {
            self.facebookBtn.backgroundColor = UIColor(hexString:"#999999");
        }
    }
    
    @objc func buttonBackGroundHighlighted1(sender:UIButton){
        if (sender.tag == 1) {
            self.googleBtn.backgroundColor = UIColor(hexString: "#ffffff");
        }
        else
        {
            self.facebookBtn.backgroundColor = UIColor(hexString:"#ffffff");
        }
    }
    
    override func onCloseView() {
        super.onCloseView()
        self.delegate?.LoginCloseEvent()
    }
}
