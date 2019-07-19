
import UIKit

class InviteContentsViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITextViewDelegate, UITextFieldDelegate {
    
    @IBOutlet var placeTextField: UITextField!
    @IBOutlet var dateTextField: UITextField!
    var datePicker: UIDatePicker = UIDatePicker()
    @IBOutlet var memberTextField: UITextField!
    var memberPickerView: UIPickerView = UIPickerView()
    var member: Int = 0
    @IBOutlet var levelTextField: UITextField!
    var levelPickerView: UIPickerView = UIPickerView()
    var level: Int = 0
    @IBOutlet var commentView: UITextView!
    @IBOutlet var startTimeTextField: UITextField!
    var startPickerView: UIPickerView = UIPickerView()
    var start: Int = 0
    @IBOutlet var endTimeTextField: UITextField!
    var endPickerView: UIPickerView = UIPickerView()
    var end: Int = 0
    let dateformatter = DateFormatter()
    let userDefaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        datePicker.datePickerMode = UIDatePicker.Mode.dateAndTime
        datePicker.timeZone = NSTimeZone.local
        datePicker.locale = Locale.current
        dateTextField.inputView = datePicker
        let datetoolbar = UIToolbar(frame: CGRect(x: 0,
                                                  y: 0,
                                                  width: view.frame.size.width,
                                                  height: 35))
        let specialItem = UIBarButtonItem(barButtonSystemItem: .flexibleSpace,
                                          target: self,
                                          action: nil)
        let doneItem = UIBarButtonItem(barButtonSystemItem: .done,
                                       target: self,
                                       action: #selector(InviteContentsViewController.done))
        datetoolbar.setItems([specialItem,
                              doneItem],
                             animated: true)
        placeTextField.delegate = self
        dateTextField.inputView = datePicker
        memberPickerView.delegate = self
        memberPickerView.dataSource = self
        memberPickerView.showsSelectionIndicator = true
        levelPickerView.delegate = self
        levelPickerView.dataSource = self
        levelPickerView.showsSelectionIndicator = true
        startPickerView.delegate = self
        startPickerView.dataSource = self
        startPickerView.showsSelectionIndicator = true
        endPickerView.delegate = self
        endPickerView.dataSource = self
        endPickerView.showsSelectionIndicator = true
        let toolbar = UIToolbar(frame: CGRect(x: 0,
                                              y: 0,
                                              width: view.frame.size.width,
                                              height: 35))
        let normaldoneItem = UIBarButtonItem(barButtonSystemItem: .done,
                                             target: self,
                                             action: #selector(InviteContentsViewController.normaldone))
        let cancelItem = UIBarButtonItem(barButtonSystemItem: .cancel,
                                         target: self,
                                         action: #selector(InviteContentsViewController.cancel))
        toolbar.setItems([cancelItem,
                          doneItem],
                         animated: true)
        self.dateTextField.inputAccessoryView = toolbar
        self.memberTextField.inputView = memberPickerView
        self.memberTextField.inputAccessoryView = toolbar
        self.levelTextField.inputView = levelPickerView
        self.levelTextField.inputAccessoryView = toolbar
        self.startTimeTextField.inputView = startPickerView
        self.startTimeTextField.inputAccessoryView = toolbar
        self.endTimeTextField.inputView = endPickerView
        self.endTimeTextField.inputAccessoryView = toolbar
        commentView.delegate = self
        dateformatter.dateFormat = "yyyy-MM-dd"
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        placeTextField.text = ""
        dateTextField.text = ""
        memberTextField.text = ""
        levelTextField.text = ""
        commentView.text = ""
        startTimeTextField.text = ""
        endTimeTextField.text = ""
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
    
    @objc func done() {
        dateTextField.endEditing(true)
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy年MM月dd日"
        dateTextField.text = "\(formatter.string(from: datePicker.date))"
        self.view.endEditing(true)
    }
    
    @objc func cancel() {
        self.levelTextField.text = ""
        self.levelTextField.endEditing(true)
        self.memberTextField.text = ""
        self.memberTextField.endEditing(true)
        self.startTimeTextField.text = ""
        self.startTimeTextField.endEditing(true)
        self.endTimeTextField.text = ""
        self.endTimeTextField.endEditing(true)
    }
    
    @objc func normaldone() {
        self.levelTextField.endEditing(true)
        self.memberTextField.endEditing(true)
        self.startTimeTextField.endEditing(true)
        self.endTimeTextField.endEditing(true)
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == levelPickerView {
            return 5
        } else if pickerView == memberPickerView {
            return 30
        } else if pickerView == startPickerView {
            return 12
        } else {
            return 12
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == levelPickerView {
            return "Lv.\(row)"
        } else if pickerView == memberPickerView {
            return "\(row)人"
        } else if pickerView == startPickerView {
            return "\(row+8)時"
        } else {
            return "\(row+8)時"
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == levelPickerView {
            self.levelTextField.text = "Lv.\(row)"
            self.level = row
        } else if pickerView == memberPickerView {
            self.memberTextField.text = "\(row)人"
            self.member = row
        } else if pickerView == startPickerView {
            self.startTimeTextField.text = "\(row+8)時"
            self.start = row
        } else {
            self.endTimeTextField.text = "\(row+8)時"
            self.end = row
        }
    }
    
    func showalert() {
        let alert: UIAlertController = UIAlertController(title: "未記入の場所があります",
                                                         message: "入力してください",
                                                         preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK",
                                      style: UIAlertAction.Style.default))
        self.present(alert,
                     animated: true,
                     completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toPostViewController" {
            let PostVC: PostViewController = segue.destination as! PostViewController
            PostVC.post = sender as! [String]
        }
    }
    
    @IBAction func postButton(_ sender: UIButton) {
        if placeTextField.text == "" || placeTextField.text == nil {
            self.showalert()
        }else if dateTextField.text == "" || dateTextField.text == nil {
            self.showalert()
        }else if startTimeTextField.text == "" || startTimeTextField.text == nil {
            self.showalert()
        }else if endTimeTextField.text == "" || endTimeTextField.text == nil {
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
            post.append(dateTextField.text!)
            post.append(startTimeTextField.text!)
            post.append(endTimeTextField.text!)
            post.append(memberTextField.text!)
            post.append(levelTextField.text!)
            post.append(commentView.text!)
            post.append(userDefaults.string(forKey: "username")!)
            post.append(userDefaults.string(forKey: "myGmail")!)
            self.performSegue(withIdentifier: "toPostViewController",
                              sender: post)
        }
    }
}
