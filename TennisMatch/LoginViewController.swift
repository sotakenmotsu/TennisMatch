//
//  LoginViewController.swift
//  TennisMatch
//
//  Created by 剱物蒼太 on 2018/11/16.
//  Copyright © 2018年 剱物蒼太. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase
import GoogleSignIn


class SignInViewController: UIViewController, UITextFieldDelegate, GIDSignInUIDelegate, GIDSignInDelegate {
    
    let user = Auth.auth().currentUser
    let userDefaults = UserDefaults.standard

    override func viewDidLoad() {
        super.viewDidLoad()
        
        GIDSignIn.sharedInstance()?.uiDelegate = self
        GIDSignIn.sharedInstance()?.delegate = self

    }
    
    @IBAction func tapGoogleSignIn(_ sender: Any) {
        GIDSignIn.sharedInstance()?.signIn()
    }
    
    func toUserNameView() {
        let toUserNameView = storyboard!.instantiateViewController(withIdentifier: "usernameview")
        self.present(toUserNameView, animated: true, completion: nil)
    }
    
    func showAlert() {
        let alert = UIAlertController(title: "登録完了", message:"", preferredStyle: UIAlertController.Style.alert)
        let ok = UIAlertAction(title: "OK", style: UIAlertAction.Style.default){ (action: UIAlertAction) in
            self.toUserNameView()
        }
        alert.addAction(ok)
        present(alert, animated: true, completion: nil)
    }
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        if let _error = error {
            print("Error: \(_error.localizedDescription)")
            return
        }
        let authentication = user.authentication
        let credential = GoogleAuthProvider.credential(withIDToken: (authentication?.idToken)!, accessToken: (authentication?.accessToken)!)
        Auth.auth().signInAndRetrieveData(with: credential) { (authResult, error) in
            print("ログイン成功")
            self.userDefaults.set(authentication?.idToken, forKey: "idToken")
            self.userDefaults.set(authentication?.accessToken, forKey: "accessToken")
            self.showAlert()
        }
    }
    
    func sign(_ signIn: GIDSignIn!, didDesconnectWith user: GIDGoogleUser!, withError error: Error!) {
        print("Sign off successfully")
    }
}
