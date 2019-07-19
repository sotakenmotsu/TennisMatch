
import UIKit
import Firebase
import FirebaseDatabase
import FirebaseAuth

class PostViewController: UIViewController {
    
    @IBOutlet var placeView: UILabel!
    @IBOutlet var dateView: UILabel!
    @IBOutlet var starttimeView: UILabel!
    @IBOutlet var endtimeView: UILabel!
    @IBOutlet var memberView: UILabel!
    @IBOutlet var levelView: UILabel!
    @IBOutlet var commentView: UILabel!
    var post = [String]()
    var ref: DatabaseReference!
    let user = Auth.auth().currentUser
    let now = Date()
    let dateformatter = DateFormatter()
    var count :Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        placeView.text = post[0]
        dateView.text = post[1]
        starttimeView.text = post[2]
        endtimeView.text = post[3]
        memberView.text = post[4]
        levelView.text = post[5]
        commentView.text = post[6]
        ref = Database.database().reference()
        dateformatter.dateFormat = "yyyy-MM-dd"
        ref.child("data").observe(.value, with: {(snapshot) in
            self.count = Int(snapshot.childrenCount)
            print(self.count)
        })
    }
    
    @IBAction func postButton() {
        let place = post[0]
        let date = post[1]
        let starttime = post[2]
        let endtime = post[3]
        let member = post[4]
        let level = post[5]
        let comment = post[6]
        let postername = post[7]
        let gmail = post[8]
        ref.child("data").child("\(self.count + 1)").setValue(["place":place,
                                                               "date":date,
                                                               "startTime":starttime,
                                                               "endTime":endtime,
                                                               "member":member,
                                                               "level":level,
                                                               "comment":comment,
                                                               "postdate":dateformatter.string(from: now),
                                                               "postername":postername,
                                                               "gmail":gmail,
                                                               "postnumber":String(self.count + 1)])
        self.showAlert()
    }
    
    func showAlert() {
        let alert = UIAlertController(title: "投稿完了！",
                                      message:"",
                                      preferredStyle: UIAlertController.Style.alert)
        let ok = UIAlertAction(title: "OK",
                               style: UIAlertAction.Style.default) {(action: UIAlertAction) in
                                self.navigationController!.popViewController(animated: true)
        }
        alert.addAction(ok)
        present(alert,
                animated: true,
                completion: nil)
    }
    
}
