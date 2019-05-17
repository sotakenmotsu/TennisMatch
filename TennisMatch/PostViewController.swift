
import UIKit
import Firebase
import FirebaseDatabase

class PostViewController: UIViewController {

    @IBOutlet var placeView: UILabel!
    @IBOutlet var memberView: UILabel!
    @IBOutlet var levelView: UILabel!
    @IBOutlet var commentView: UITextView!
    @IBOutlet var day1: UILabel!
    @IBOutlet var day2: UILabel!
    @IBOutlet var day3: UILabel!
    var post = [Any]()
    var dates = [String]()
    var ref: DatabaseReference!
    let user = Auth.auth().currentUser
    let now = Date()
    let dateformatter = DateFormatter()
    var count :Int = 0
    let userDefaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        placeView.text = post[0] as! String
        memberView.text = post[1] as! String
        levelView.text = post[2] as! String
        commentView.text = post[3] as! String
        ref = Database.database().reference()
        dateformatter.dateFormat = "yyyy-MM-dd"
        day1.text = dates[0]
        day2.text = dates[1]
        day3.text = dates[2]
        
        ref.child("data").observe(.value, with: {(snapshot) in
            self.count = Int(snapshot.childrenCount) - 1
        })
    }
    
    @IBAction func postButton() {
    
        let place = post[0]
        let member = post[1]
        let level = post[2]
        let comment = post[3]
        let postername = post[4]
        let gmail = post[5]
        let maxmember = post[6]
        let days = dates
        var members = [String]()
        members.append(userDefaults.string(forKey: "uuid")!)
        if userDefaults.object(forKey: "joinedPostNumbers") != nil {
            var joinedPosts = userDefaults.array(forKey: "joinedPostNumbers")
            joinedPosts?.append(self.count + 1)
            userDefaults.removeObject(forKey: "joinedPostNumbers")
            userDefaults.set(joinedPosts, forKey: "joinedPostNumbers")
        } else {
            userDefaults.set(self.count + 1, forKey: "joinedPostNumbers")
        }
        ref.child("data").child("\(self.count + 1)").setValue(["place":place,
                                                    "member":member,
                                                    "level":level,
                                                    "comment":comment,
                                                    "postdate":dateformatter.string(from: now),
                                                    "postername":postername,
                                                    "gmail":gmail,
                                                    "days":days,
                                                    "members":members,
                                                    "maxmember":maxmember])
        self.showAlert()
    }
    
    func showAlert() {
        let alert = UIAlertController(title: "投稿完了！", message:"", preferredStyle: UIAlertController.Style.alert)
        let ok = UIAlertAction(title: "OK", style: UIAlertAction.Style.default){ (action: UIAlertAction) in
            self.navigationController?.popToRootViewController(animated: true)
        }
        alert.addAction(ok)
        present(alert, animated: true, completion: nil)
    }
}
