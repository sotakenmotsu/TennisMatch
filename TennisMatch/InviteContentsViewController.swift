//
//  InviteContentsViewController.swift
//  TennisMatch
//
//  Created by 剱物蒼太 on 2018/11/16.
//  Copyright © 2018年 剱物蒼太. All rights reserved.
//

import UIKit

class InviteContentsViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITextViewDelegate, UITextFieldDelegate {
    
    @IBOutlet var placeTextField: UITextField!
    @IBOutlet var memberTextField: UITextField!
    var memberPickerView: UIPickerView = UIPickerView()
    var member: Int = 0
    @IBOutlet var levelTextField: UITextField!
    var levelPickerView: UIPickerView = UIPickerView()
    var level: Int = 0
    @IBOutlet var commentView: UITextView!
    let userDefaults = UserDefaults.standard

    override func viewDidLoad() {
        super.viewDidLoad()
        
        placeTextField.delegate = self
        memberPickerView.delegate = self
        memberPickerView.dataSource = self
        memberPickerView.showsSelectionIndicator = true
        levelPickerView.delegate = self
        levelPickerView.dataSource = self
        levelPickerView.showsSelectionIndicator = true
        let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 35))
        let normaldoneItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(InviteContentsViewController.normaldone))
        let cancelItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(InviteContentsViewController.cancel))
        toolbar.setItems([cancelItem, normaldoneItem], animated: true)
        self.memberTextField.inputView = memberPickerView
        self.memberTextField.inputAccessoryView = toolbar
        self.levelTextField.inputView = levelPickerView
        self.levelTextField.inputAccessoryView = toolbar
        commentView.delegate = self
    
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        placeTextField.text = ""
        memberTextField.text = ""
        levelTextField.text = ""
        commentView.text = ""
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if (text == "\n") {
            commentView.resignFirstResponder()
            return false
        }
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        placeTextField.resignFirstResponder()
        return true
    }
    
    @objc func cancel() {
        self.levelTextField.text = ""
        self.levelTextField.endEditing(true)
        self.memberTextField.text = ""
        self.memberTextField.endEditing(true)
    }
    
    @objc func normaldone() {
        self.levelTextField.endEditing(true)
        self.memberTextField.endEditing(true)
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == levelPickerView {
            return 5
        } else {
            return 30
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == levelPickerView {
            return "Lv.\(row)"
        } else {
            return "\(row)人"
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == levelPickerView {
            self.levelTextField.text = "Lv.\(row)"
            self.level = row
        }else if pickerView == memberPickerView {
            self.memberTextField.text = "\(row)人"
            self.member = row
        }
    }
    
    func showalert() {
        let alert: UIAlertController = UIAlertController(title: "未記入の場所があります", message: "入力してください", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default))
        self.present(alert, animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toCalendarViewController" {
            let PostVC: CalendarViewController = segue.destination as! CalendarViewController
            PostVC.post = sender as! [String]
        }
    }
    
    @IBAction func postButton(_ sender: UIButton) {
        if placeTextField.text == "" || placeTextField.text == nil {
            self.showalert()
        }else if memberTextField.text == "" || memberTextField.text == nil {
            self.showalert()
        }else if levelTextField.text == "" || levelTextField.text == nil {
            self.showalert()
        }else if commentView.text == "" || commentView.text == nil {
            self.showalert()
        }else{
            var post = [String]()
            post.append(placeTextField.text!)
            post.append(memberTextField.text!)
            post.append(levelTextField.text!)
            post.append(commentView.text!)
            post.append(userDefaults.string(forKey: "username")!)
            post.append(userDefaults.string(forKey: "myGmail")!)
            self.performSegue(withIdentifier: "toCalendarViewController", sender: post)
        }
    }
}
