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


class LoginViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    @IBOutlet var passwordTextField2: UITextField!
    @IBOutlet var usernameTextField: UITextField!
    var ref: DatabaseReference!
    let user = Auth.auth().currentUser

    override func viewDidLoad() {
        super.viewDidLoad()
        
        emailTextField.placeholder = "email"
        emailTextField.delegate = self
        passwordTextField.placeholder = "password"
        passwordTextField.delegate = self
        passwordTextField2.placeholder = "password"
        passwordTextField2.delegate = self
        usernameTextField.placeholder = "username"
        usernameTextField.delegate = self
        passwordTextField.isSecureTextEntry = true
        passwordTextField2.isSecureTextEntry = true
        
        ref = Database.database().reference()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func loginButton() {
        if passwordTextField.text == passwordTextField2.text {
            Auth.auth().createUser(withEmail: emailTextField.text!, password: passwordTextField.text!) { (user, error) in
                if error != nil {
                    print("登録できませんでした")
                }
                if error == nil {
                    print("登録完了")
                }
            }
            let username: String! = usernameTextField.text
            ref.child("user").child((user?.uid)!).setValue(["name":username])
            self.showAlert()
        } else {
            self.showPassAlert()
        }
    }
    
    func toSearchView() {
        let toSearchView = storyboard!.instantiateViewController(withIdentifier: "mainView")
        self.present(toSearchView, animated: true, completion: nil)
    }
    
    func toInviteView() {
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        emailTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
        passwordTextField2.resignFirstResponder()
        usernameTextField.resignFirstResponder()
        return true
    }
    
    func showAlert() {
        let alert = UIAlertController(title: "登録しました", message:"", preferredStyle: UIAlertController.Style.alert)
        let ok = UIAlertAction(title: "始める", style: UIAlertAction.Style.default){ (action: UIAlertAction) in
            self.toSearchView()
        }
        alert.addAction(ok)
        present(alert, animated: true, completion: nil)
    }
    
    func showPassAlert() {
        let alert = UIAlertController(title: "passwordが入力できていません", message:"", preferredStyle: UIAlertController.Style.alert)
        let ok = UIAlertAction(title: "OK", style: UIAlertAction.Style.default){ (action: UIAlertAction) in
            print("return")
        }
        alert.addAction(ok)
        present(alert, animated: true, completion: nil)
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
