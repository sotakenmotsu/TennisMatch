//
//  SearchViewController.swift
//  TennisMatch
//
//  Created by 剱物蒼太 on 2018/11/16.
//  Copyright © 2018年 剱物蒼太. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import SVProgressHUD

class SearchViewController: UIViewController, UITableViewDataSource, UITableViewDelegate  {
    
    @IBOutlet var tableView: UITableView!
    var ref: DatabaseReference!
    let user = Auth.auth().currentUser
    let dateformatter = DateFormatter()
    var posts = [[String]]()
    var selectedpost = [String]()
    var firstTime: Bool = true
    var loginButtonBool: Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()
        
        SVProgressHUD.show()
        self.tableView.rowHeight = 99
        tableView.delegate = self
        tableView.dataSource = self
        ref = Database.database().reference()
        dateformatter.dateFormat = "yyyy-MM-dd"
        if posts.count == 0 {
            ref.child("data").observe(.value, with: { (snapshot) in
                for itemsnapshot in snapshot.children {
                    let place = Post(snapshot: itemsnapshot as! DataSnapshot)?.place as! String
//                    let date = Post(snapshot: itemsnapshot as! DataSnapshot)?.date as! String
//                    let startTime = Post(snapshot: itemsnapshot as! DataSnapshot)?.startTime as! String
//                    let endTime = Post(snapshot: itemsnapshot as! DataSnapshot)?.endTime as! String
                    let member = Post(snapshot: itemsnapshot as! DataSnapshot)?.member as! String
                    let level = Post(snapshot: itemsnapshot as! DataSnapshot)?.level as! String
                    let comment = Post(snapshot: itemsnapshot as! DataSnapshot)?.comment as! String
                    let gmail = Post(snapshot: itemsnapshot as! DataSnapshot)?.gmail as! String
                    let dates = Post(snapshot: itemsnapshot as! DataSnapshot)?.dates as! [String]
                    let members = Post(snapshot: itemsnapshot as! DataSnapshot)?.members as! [String]
                    self.posts.append([place,member,level,comment,gmail,dates,members])
                    print(self.posts)
                }
                self.tableView.reloadData()
                SVProgressHUD.dismiss()
            } )
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if !firstTime {
            posts.removeAll()
            
            ref.child("data").observe(.value, with: { (snapshot) in
                for itemsnapshot in snapshot.children {
                    let place = Post(snapshot: itemsnapshot as! DataSnapshot)?.place as! String
//                    let date = Post(snapshot: itemsnapshot as! DataSnapshot)?.date as! String
//                    let startTime = Post(snapshot: itemsnapshot as! DataSnapshot)?.startTime as! String
//                    let endTime = Post(snapshot: itemsnapshot as! DataSnapshot)?.endTime as! String
                    let member = Post(snapshot: itemsnapshot as! DataSnapshot)?.member as! String
                    let level = Post(snapshot: itemsnapshot as! DataSnapshot)?.level as! String
                    let comment = Post(snapshot: itemsnapshot as! DataSnapshot)?.comment as! String
                    let gmail = Post(snapshot: itemsnapshot as! DataSnapshot)?.gmail as! String
                    let dates = Post(snapshot: itemsnapshot as! DataSnapshot)?.dates as! [String]
                    let members = Post(snapshot: itemsnapshot as! DataSnapshot)?.members as! [String]
                    self.posts.append([place,member,level,comment,gmail,dates,members])
                    print(self.posts)
                }
            } )
            
            self.tableView.reloadData()
            
        }
        firstTime = false
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "searchViewCell", for: indexPath) as! SearchViewControllerTableViewCell
        if self.posts.count == 0 {
            
        } else {
            cell.placeLabel.text = self.posts[indexPath.row][0]
            cell.startLabel.text = self.posts[indexPath.row][2]
            cell.endLabel.text = self.posts[indexPath.row][3]
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "toJoinViewController", sender: posts[indexPath.row])
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toJoinViewController" {
            let JoinVC: JoinViewController = segue.destination as! JoinViewController
            JoinVC.post = sender as! [String]
        }
    }
    
    @IBAction func clickRefreshButton() {
        SVProgressHUD.show()
        posts.removeAll()
        ref.child("data").observe(.value, with: { (snapshot) in
            for itemsnapshot in snapshot.children {
                let place = Post(snapshot: itemsnapshot as! DataSnapshot)?.place as! String
//                let date = Post(snapshot: itemsnapshot as! DataSnapshot)?.date as! String
//                let startTime = Post(snapshot: itemsnapshot as! DataSnapshot)?.startTime as! String
//                let endTime = Post(snapshot: itemsnapshot as! DataSnapshot)?.endTime as! String
                let member = Post(snapshot: itemsnapshot as! DataSnapshot)?.member as! String
                let level = Post(snapshot: itemsnapshot as! DataSnapshot)?.level as! String
                let comment = Post(snapshot: itemsnapshot as! DataSnapshot)?.comment as! String
                let gmail = Post(snapshot: itemsnapshot as! DataSnapshot)?.gmail as! String
                let dates = Post(snapshot: itemsnapshot as! DataSnapshot)?.dates as! [String]
                let members = Post(snapshot: itemsnapshot as! DataSnapshot)?.members as! [String]
                self.posts.append([place,member,level,comment,gmail,dates,members])
               
            }
            self.tableView.reloadData()
            SVProgressHUD.dismiss()
        } )
    }
    
    @IBAction func backToLoginView() {
        let storyboard: UIStoryboard = UIStoryboard(name: "Login", bundle: nil)
        let next: UIViewController = storyboard.instantiateInitialViewController() as! UIViewController
        present(next, animated: true, completion: nil)
    }
}
