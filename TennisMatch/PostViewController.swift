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
        let place = post[0]
        let date = post[1]
        let starttime = post[2]
        let endtime = post[3]
        let member = post[4]
        let level = post[5]
        let comment = post[6]
        let randomid = String(arc4random_uniform(1000))
        ref.child("data").child(randomid).setValue(["place":place,
                                                    "date":date,
                                                    "startTime":starttime,
                                                    "endTime":endtime,
                                                    "member":member,
                                                    "level":level,
                                                    "comment":comment,
                                                    "postdate":dateformatter.string(from: now)])
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func backButton() {
        self.dismiss(animated: true, completion: nil)
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
