//
//  AuthID.swift
//  Demos
//
//  Created by 焦国辉 on 2018/12/7.
//  Copyright © 2018 zyxx. All rights reserved.
//

import LocalAuthentication

enum AuthIDState {
    case notSupport, success, fail, userCancel, inputPassword, systemCancel, notSet, lockout, appCancel, contextNil
}

class AuthID {
    static let shared = AuthID()
    
    
    func showAuthID() -> AuthIDState {
        var context = LAContext()
        var error: NSError?
        context.localizedFallbackTitle = "输入密码"
        context.localizedCancelTitle = "输入用户名和密码"
        if context.canEvaluatePolicy(.deviceOwnerAuthentication, error: &error) {
            let reson = "log in to your account"
            context.evaluatePolicy(.deviceOwnerAuthentication, localizedReason: reson) { (success, error) in
                if success {
                    
                } else {
                    
                }
            }
        }
        
        return .success
    }
}
