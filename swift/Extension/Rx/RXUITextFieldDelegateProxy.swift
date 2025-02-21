//
//  RXUITextFieldDelegateProxy.swift
//  VideoChat
//
//  Created by liqi on 2021/2/25.
//

import RxSwift
import RxCocoa
import AuthenticationServices

extension UITextField: HasDelegate {
    public typealias Delegate = UITextFieldDelegate
}

class RXUITextFieldDelegateProxy:
DelegateProxy<UITextField, UITextFieldDelegate>,
DelegateProxyType, UITextFieldDelegate {
    
    weak private(set) var textField: UITextField?
    
    init(textField: UITextField) {
        self.textField = textField
        super.init(parentObject: textField, delegateProxy: RXUITextFieldDelegateProxy.self)
    }
    
    static func registerKnownImplementations() {
        self.register { parent -> RXUITextFieldDelegateProxy in
            RXUITextFieldDelegateProxy(textField: parent)
        }
    }
    
}
@available(iOS 13.0, *)
extension Reactive where Base: UITextField {
    
    var delegate: DelegateProxy<UITextField, UITextFieldDelegate> {
        return RXUITextFieldDelegateProxy.proxy(for: base)
    }
    
    var shouldBeginEditing: Observable<Void> {
        return delegate.methodInvoked(#selector(UITextFieldDelegate.textFieldShouldBeginEditing(_:))).map { parameters in
            return 
        }
    }
    
    
    var didCompleteWithAuthorization: Observable<ASAuthorization> {
        return delegate.methodInvoked(#selector(ASAuthorizationControllerDelegate.authorizationController(controller:didCompleteWithAuthorization:))).map { parameters in
            return parameters[1] as! ASAuthorization
        }
    }
    
    var didCompleteWithError: Observable<Error> {
        return delegate.methodInvoked(#selector(ASAuthorizationControllerDelegate.authorizationController(controller:didCompleteWithError:))).map { parameters in
            return parameters[1] as! Error
        }
    }
    
}
