
import UIKit
import Firebase
import FirebaseDatabase
import FirebaseAuth

class UserNameViewController: UIViewController {
    
    @IBOutlet var usernameTextField: UITextField!
    var ref: DatabaseReference!
    let userDefaults = UserDefaults.standard
    let user = Auth.auth().currentUser
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ref = Database.database().reference()
        if let user = user {
            let userGmail = user.email
            userDefaults.set(userGmail,
                             forKey: "myGmail")
        }
        print(userDefaults.string(forKey: "myGmail")!)
        print(userDefaults.string(forKey: "uuid")!)
        
    }
    
    @IBAction func decideButton() {
        if usernameTextField.text == nil || usernameTextField.text == "" {
            self.showEmptyAlert()
        } else {
            self.showAlert()
        }
    }
    
    func showAlert() {
        let alert = UIAlertController(title: usernameTextField.text,
                                      message: "ユーザーネームはこちらでよろしいですか？",
                                      preferredStyle: UIAlertController.Style.alert)
        let ok = UIAlertAction(title: "OK",
                               style: UIAlertAction.Style.default) {(action: UIAlertAction) in
                                self.userDefaults.set(self.usernameTextField.text!,
                                                      forKey: "username")
                                self.toMainView()
                                let cancel = UIAlertAction(title: "キャンセル",
                                                           style: UIAlertAction.Style.cancel,
                                                           handler: nil)
        }
        alert.addAction(ok)
        present(alert,
                animated: true,
                completion: nil)
    }
    
    func showEmptyAlert() {
        let alert = UIAlertController(title: "ユーザーネームが入力されていません",
                                      message: "",
                                      preferredStyle: UIAlertController.Style.alert)
        let ok = UIAlertAction(title: "OK",
                               style: UIAlertAction.Style.default)
        alert.addAction(ok)
        present(alert,
                animated: true,
                completion: nil)
    }
    
    func toMainView() {
        let display: CGRect = UIScreen.main.bounds
        if display.size.height == CGFloat(568) {
            self.performSegue(withIdentifier: "to5SMainView",
                              sender: nil)
        } else {
            self.performSegue(withIdentifier: "toMainView",
                              sender: nil)
        }
    }
    
}
