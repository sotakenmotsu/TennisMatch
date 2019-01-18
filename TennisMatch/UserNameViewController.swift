
import UIKit
import Firebase

class UserNameViewController: UIViewController {
    
    @IBOutlet var usernameTextField: UITextField!
    var ref: DatabaseReference!
    let userDefaults = UserDefaults.standard

    override func viewDidLoad() {
        super.viewDidLoad()
        
        ref = Database.database().reference()

    }
    
    @IBAction func decideButton() {
        self.showAlert()
    }
    
    func showAlert() {
        let alert = UIAlertController(title: usernameTextField.text, message: "ユーザーネームはこちらでよろしいですか？", preferredStyle: UIAlertController.Style.alert)
        let ok = UIAlertAction(title: "OK", style: UIAlertAction.Style.default){ (action: UIAlertAction) in
            self.ref.child("User").child(self.userDefaults.string(forKey: "idToken")!)
            self.toMainView()
        let cancel = UIAlertAction(title: "キャンセル", style: UIAlertAction.Style.cancel, handler: nil)
        }
        alert.addAction(ok)
        present(alert, animated: true, completion: nil)
    }
    
    func toMainView() {
        self.performSegue(withIdentifier: "toMainView", sender: nil)
    }

}
