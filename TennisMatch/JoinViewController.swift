//
//  JoinViewController.swift
//  TennisMatch
//
//  Created by 剱物蒼太 on 2018/11/16.
//  Copyright © 2018年 剱物蒼太. All rights reserved.
//

import UIKit

class JoinViewController: UIViewController {
    
    @IBOutlet var placeLabel: UILabel!
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var starttimeLabel: UILabel!
    @IBOutlet var endtimeLabel: UILabel!
    @IBOutlet var memberLabel: UILabel!
    @IBOutlet var levelLabel: UILabel!
    @IBOutlet var commentLabel: UILabel!
    @IBOutlet var gmailLabel: UILabel!
    var post = [String]()
    let userDefaults = UserDefaults.standard
    var postnumber: Int!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(post)
        placeLabel.text = post[0]
        dateLabel.text = post[1]
        starttimeLabel.text = post[2]
        endtimeLabel.text = post[3]
        memberLabel.text = post[4]
        levelLabel.text = post[5]
        commentLabel.text = post[6]
        gmailLabel.text = post[7]


        // Do any additional setup after loading the view.
    }
    

    @IBAction func favorite() {
        if userDefaults.object(forKey: "favorite") == nil {
            let favorite: [Int] = [postnumber]
            userDefaults.set(favorite, forKey: "favorite")
            userDefaults.synchronize()
        } else {
            var favorite: [Int] = userDefaults.array(forKey: "favorite") as! [Int]
            favorite.append(postnumber)
            userDefaults.removeObject(forKey: "favorite")
            userDefaults.set(favorite, forKey: "favorite")
            userDefaults.synchronize()
        }
    }
}
