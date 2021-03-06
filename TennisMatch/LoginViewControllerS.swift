
import UIKit
import Firebase
import FirebaseDatabase
import GoogleSignIn
import FirebaseAuth

class LoginViewControllerS: UIViewController, UITextFieldDelegate, GIDSignInUIDelegate, GIDSignInDelegate {
    
    //    var myUser: User!
    
    let userDefaults = UserDefaults.standard
    var ref: DatabaseReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        GIDSignIn.sharedInstance()?.uiDelegate = self
        GIDSignIn.sharedInstance()?.delegate = self
        
    }
    
    @IBAction func tapGoogleSignIn(_ sender: Any) {
//        GIDSignIn.sharedInstance()?.signIn()
    }
    
    func toUserNameView() {
        self.performSegue(withIdentifier: "toUserNameView",
                          sender: nil)
    }
    
    func showAlert() {
        let alert = UIAlertController(title: "登録完了",
                                      message:"",
                                      preferredStyle: UIAlertController.Style.alert)
        let ok = UIAlertAction(title: "OK",
                               style: UIAlertAction.Style.default) {(action: UIAlertAction) in
                                let uuid = UUID().uuidString
                                print(uuid)
                                self.userDefaults.set(uuid,
                                                      forKey: "uuid")
                                self.toUserNameView()
        }
        alert.addAction(ok)
        present(alert,
                animated: true,
                completion: nil)
    }
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        
        if let _error = error {
            print("Error: \(_error.localizedDescription)")
            return
        }
        
        guard let authentication = user.authentication else { return }
        let credential = GoogleAuthProvider.credential(withIDToken: authentication.idToken,
                                                       accessToken: authentication.accessToken)
        Auth.auth().signInAndRetrieveData(with: credential) { (authResult, error) in
            print("ログイン成功")
            self.userDefaults.set(authentication.idToken,
                                  forKey: "idToken")
            self.userDefaults.set(authentication.accessToken,
                                  forKey: "accessToken")
            
            self.showAlert()
        }
    }
    
    func sign(_ signIn: GIDSignIn!, didDesconnectWith user: GIDGoogleUser!, withError error: Error!) {
        print("Sign off successfully")
    }
    
    @IBAction func backloginfromunlogin(segue: UIStoryboardSegue) {
    }
}
