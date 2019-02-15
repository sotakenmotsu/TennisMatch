//
//  PostViewController.swift
//  TennisMatch
//
//  Created by 剱物蒼太 on 2018/11/16.
//  Copyright © 2018年 剱物蒼太. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

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

        // Do any additional setup after loading the view.
    }
    
    @IBAction func postButton() {
//        count = Int(ref.child("data").observe(.value, with: {(snapshot) in
//            snapshot.childrenCount
//            print(snapshot.childrenCount)
//        }))
        
        let place = post[0]
        let date = post[1]
        let starttime = post[2]
        let endtime = post[3]
        let member = post[4]
        let level = post[5]
        let comment = post[6]
        let postername = post[7]
        let gmail = post[8]
        ref.child("data").observe(.value, with: { (snapshot) in
            for itemsnapshot in snapshot.children {
                let place = Post(snapshot: itemsnapshot as! DataSnapshot)?.place as! String
                self.post.append(place)
                print(self.post)
            }
            self.ref.child("data").child("\(self.post.count + 1)").setValue(["place":place,
                                                                             "date":date,
                                                                             "startTime":starttime,
                                                                             "endTime":endtime,
                                                                             "member":member,
                                                                             "level":level,
                                                                             "comment":comment,
                                                                             "postdate":self.dateformatter.string(from: self.now),
                                                                             "postername":postername,
                                                                             "gmail":gmail])
        })
//        let idnumber = String(self.count + 1)
//        ref.child("data").child("\(self.count + 1)").setValue(["place":place,
//                                                    "date":date,
//                                                    "startTime":starttime,
//                                                    "endTime":endtime,
//                                                    "member":member,
//                                                    "level":level,
//                                                    "comment":comment,
//                                                    "postdate":dateformatter.string(from: now),
//                                                    "postername":postername,
//                                                    "gmail":gmail])
        self.dismiss(animated: true, completion: nil)
        self.showAlert()
    }
    
    func showAlert() {
        let alert = UIAlertController(title: "投稿完了！", message:"", preferredStyle: UIAlertController.Style.alert)
        let ok = UIAlertAction(title: "OK", style: UIAlertAction.Style.default){ (action: UIAlertAction) in
            self.navigationController?.popViewController(animated: true)
        }
        alert.addAction(ok)
        present(alert, animated: true, completion: nil)
    }
}
