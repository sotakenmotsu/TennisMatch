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
//    @IBOutlet var dateView: UILabel!
//    @IBOutlet var starttimeView: UILabel!
//    @IBOutlet var endtimeView: UILabel!
    @IBOutlet var memberView: UILabel!
    @IBOutlet var levelView: UILabel!
    @IBOutlet var commentView: UITextView!
    @IBOutlet var day1: UILabel!
    @IBOutlet var day2: UILabel!
    @IBOutlet var day3: UILabel!
    var post = [String]()
    var dates = [String]()
    var ref: DatabaseReference!
    let user = Auth.auth().currentUser
    let now = Date()
    let dateformatter = DateFormatter()
    var count :Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        placeView.text = post[0]
//        dateView.text = post[1]
//        starttimeView.text = post[2]
//        endtimeView.text = post[3]
        memberView.text = post[1]
        levelView.text = post[2]
        commentView.text = post[3]
        ref = Database.database().reference()
        dateformatter.dateFormat = "yyyy-MM-dd"
        day1.text = dates[0]
        day2.text = dates[1]
        day3.text = dates[2]
        // Do any additional setup after loading the view.
        
        ref.child("data").observe(.value, with: {(snapshot) in
            self.count = Int(snapshot.childrenCount)
            print(self.count)
        })
    }
    
    @IBAction func postButton() {
    
        let place = post[0]
//        let date = post[1]
//        let starttime = post[2]
//        let endtime = post[3]
        let member = post[1]
        let level = post[2]
        let comment = post[3]
        let postername = post[4]
        let gmail = post[5]
        let days = dates
        let members: [String] = []
//        ref.child("data").observe(.value, with: { (snapshot) in
//            for itemsnapshot in snapshot.children {
//                let place = Post(snapshot: itemsnapshot as! DataSnapshot)?.place as! String
//                self.post.append(place)
//                print(self.post)
//            }
//        })
        ref.child("data").child("\(self.count + 1)").setValue(["place":place,
//                                                    "date":date,
//                                                    "startTime":starttime,
//                                                    "endTime":endtime,
                                                    "member":member,
                                                    "level":level,
                                                    "comment":comment,
                                                    "postdate":dateformatter.string(from: now),
                                                    "postername":postername,
                                                    "gmail":gmail,
                                                    "days":days,
                                                    "members":members])
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
