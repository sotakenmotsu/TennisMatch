//
//  JoinViewController.swift
//  TennisMatch
//
//  Created by 剱物蒼太 on 2018/11/16.
//  Copyright © 2018年 剱物蒼太. All rights reserved.
//

import UIKit
import Firebase

class JoinViewController: UIViewController {
    
    @IBOutlet var placeLabel: UILabel!
    @IBOutlet var memberLabel: UILabel!
    @IBOutlet var levelLabel: UILabel!
    @IBOutlet var commentTextView: UITextView!
    @IBOutlet var day1Label: UILabel!
    @IBOutlet var day2Label: UILabel!
    @IBOutlet var day3Label: UILabel!
    var post: Post!
    var childNumber: Int!
    var ref: DatabaseReference!
    var members = [String]()
    let userDefaults = UserDefaults.standard

    override func viewDidLoad() {
        super.viewDidLoad()
        
        ref = Database.database().reference()
        
        placeLabel.text = post.place
        memberLabel.text = post.member
        levelLabel.text = post.level
        commentTextView.text = post.comment
        day1Label.text = post.dates[0]
        day2Label.text = post.dates[1]
        day3Label.text = post.dates[2]
        members = post.members
        members.append(userDefaults.string(forKey: "uuid")!)

    }
    
    @IBAction func joinButton() {
        ref.child("data").child("\(childNumber!)").updateChildValues(["members":members])
        if userDefaults.object(forKey: "joinedPostNumbers") != nil {
            var joinedPosts = userDefaults.array(forKey: "joinedPostNumbers")
            joinedPosts?.append(childNumber!)
            userDefaults.removeObject(forKey: "joinedPostNumbers")
            userDefaults.set(joinedPosts, forKey: "joinedPostNumbers")
        } else {
            userDefaults.set(childNumber!, forKey: "joinedPostNumbers")
            // 自分の名前があるpostのみ取得する。出力
        }
    }
    
}
