//
//  SigninViewController.swift
//  TennisMatch
//
//  Created by 剱物蒼太 on 2018/11/16.
//  Copyright © 2018年 剱物蒼太. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import GoogleSignIn

class SigninViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet var signinEmailTextField: UITextField!
    @IBOutlet var signinPasswordTextField: UITextField!


    override func viewDidLoad() {
        super.viewDidLoad()

        signinEmailTextField.placeholder = "email"
        signinPasswordTextField.placeholder = "password"
        signinPasswordTextField.isSecureTextEntry = true
        signinEmailTextField.delegate = self
        signinPasswordTextField.delegate = self
        
        // Do any additional setup after loading the view.
    }
    
    func signin() {
        Auth.auth().signIn(withEmail: signinEmailTextField.text!, password: signinPasswordTextField.text!) { (user, error) in
            if error != nil {
                print("ログインできませんでした")
            } else if error == nil {
                print("ログインしました")
                self.showAlert()
            }
        }
    }
    
    @IBAction func signinButton() {
        self.signin()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        signinEmailTextField.resignFirstResponder()
        signinPasswordTextField.resignFirstResponder()
        return true
    }
    
    func showAlert() {
        let alert = UIAlertController(title: "ログインしました", message:"", preferredStyle: UIAlertController.Style.alert)
        let ok = UIAlertAction(title: "始める", style: UIAlertAction.Style.default){ (action: UIAlertAction) in
            self.toSearchView()
        }
        alert.addAction(ok)
        present(alert, animated: true, completion: nil)
    }
    
    func toSearchView() {
        let toSearchView = storyboard!.instantiateViewController(withIdentifier: "mainView")
        self.present(toSearchView, animated: true, completion: nil)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
