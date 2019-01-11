//
//  TestLoginViewController.swift
//  TennisMatch
//
//  Created by 剱物蒼太 on 2019/01/11.
//  Copyright © 2019年 剱物蒼太. All rights reserved.
//

import UIKit
import Firebase
import GoogleSignIn

class TestLoginViewController: UIViewController, GIDSignInUIDelegate, GIDSignInDelegate {
    
    @IBOutlet weak var siginButton: GIDSignInButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        GIDSignIn.sharedInstance()?.uiDelegate = self
        GIDSignIn.sharedInstance()?.delegate    = self
//        GIDSignIn.sharedInstance()?.signIn()
    }
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error?) {
        print("here")
        // ...
//        if let error = error {
//            // ...
//            return
//        }
//
//        guard let authentication = user.authentication else { return }
//        let credential = GoogleAuthProvider.credential(withIDToken: authentication.idToken,
//                                                       accessToken: authentication.accessToken)
//        Auth.auth().signInAndRetrieveData(with: credential) { (authResult, error) in
//            if let error = error {
//                return
//            }
//            print("ログイン")
//        }
        if let _error = error {
            print("Error: \(_error.localizedDescription)")
            return
        }
        guard let authentication = user.authentication else { return }
        let credential = GoogleAuthProvider.credential(withIDToken: authentication.idToken, accessToken: authentication.accessToken)
        Auth.auth().signInAndRetrieveData(with: credential) { (authResult, error) in
            if let error = error {
                return
            }
            print("ログイン成功")
            //            self.userDefaults.set(authentication?.idToken, forKey: "idToken")
            //            self.userDefaults.set(authentication?.accessToken, forKey: "accessToken")
            //            self.showAlert()
        }
    
    }
        
        @IBAction func tapGoogleButton(_ sender: Any) {
            GIDSignIn.sharedInstance()?.signIn()
        }
        
}
