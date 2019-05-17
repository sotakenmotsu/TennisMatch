//
//  MyTournamentsViewController.swift
//  TennisMatch
//
//  Created by 剱物蒼太 on 2019/03/24.
//  Copyright © 2019年 剱物蒼太. All rights reserved.
//

import UIKit
import Firebase
import SVProgressHUD

class MyTournamentsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var tableview: UITableView!
    var ref: DatabaseReference!
    var posts = [Post]()
    var myTournamentPosts = [Post]()
    var mytournaments = [Int]()
    var firstTime: Bool = true
    let userDefaults = UserDefaults.standard

    override func viewDidLoad() {
        super.viewDidLoad()
        
        SVProgressHUD.show()
        self.tableview.rowHeight = 99
        self.tableview.dataSource = self
        self.tableview.delegate = self
        if userDefaults.object(forKey: "joinedPostNumbers") != nil {
            mytournaments = userDefaults.array(forKey: "joinedPostNumbers") as! [Int]
        }
        ref = Database.database().reference()
        ref.child("data").observe(.value, with: { (snapshot) in
            for itemsnapshot in snapshot.children {
                let post = Post(snapshot: itemsnapshot as! DataSnapshot) as! Post
                self.posts.append(post)
            }
            self.tableview.reloadData()
            SVProgressHUD.dismiss()
        } )
        for i in 0...mytournaments.count {
            myTournamentPosts.append(posts[mytournaments[i]])
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if !firstTime {
            posts.removeAll()
            
            ref.child("data").observe(.value, with: { (snapshot) in
                for itemsnapshot in snapshot.children {
                    let post = Post(snapshot: itemsnapshot as! DataSnapshot)
                    self.posts.append(post!)
                }
            } )
            
            self.tableview.reloadData()
            
        }
        firstTime = false
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myTournamentPosts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableview.dequeueReusableCell(withIdentifier: "mytournamentCell", for: indexPath) as! CustomTableViewCell
        if self.mytournaments.count == 0 {
            
        } else {
            cell.placeLabel.text = self.myTournamentPosts[indexPath.row].place
            cell.memberLabel.text = self.myTournamentPosts[indexPath.row].member
        }
        return cell
    }

}
