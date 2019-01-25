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

class SearchViewController: UIViewController, UITableViewDataSource, UITableViewDelegate  {
    
    @IBOutlet var tableView: UITableView!
    var ref: DatabaseReference!
    let user = Auth.auth().currentUser
    let dateformatter = DateFormatter()
    var posts = [[String]]()
    var selectedpost = [String]()
    let refreshControl = UIRefreshControl()
    var firstTime: Bool = true
//    var numberOfCells: Int {
//        return snapshot.childrenCount
//    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.rowHeight = 99
        tableView.delegate = self
        tableView.dataSource = self
        ref = Database.database().reference()
        dateformatter.dateFormat = "yyyy-MM-dd"
        if posts.count == 0 {
            ref.child("data").observe(.value, with: { (snapshot) in
                for itemsnapshot in snapshot.children {
                    let place = Post(snapshot: itemsnapshot as! DataSnapshot)?.place as! String
                    let date = Post(snapshot: itemsnapshot as! DataSnapshot)?.date as! String
                    let startTime = Post(snapshot: itemsnapshot as! DataSnapshot)?.startTime as! String
                    let endTime = Post(snapshot: itemsnapshot as! DataSnapshot)?.endTime as! String
                    let member = Post(snapshot: itemsnapshot as! DataSnapshot)?.member as! String
                    let level = Post(snapshot: itemsnapshot as! DataSnapshot)?.level as! String
                    let comment = Post(snapshot: itemsnapshot as! DataSnapshot)?.comment as! String
                    self.posts.append([place,date,startTime,endTime,member,level,comment])
                    print(self.posts)
                    self.tableView.reloadData()
                }
            } )
        }
        tableView.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(SearchViewController.refresh(sender:)), for: .valueChanged)

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if !firstTime {
            posts.removeAll()
            
            ref.child("data").observe(.value, with: { (snapshot) in
                for itemsnapshot in snapshot.children {
                    let place = Post(snapshot: itemsnapshot as! DataSnapshot)?.place as! String
                    let date = Post(snapshot: itemsnapshot as! DataSnapshot)?.date as! String
                    let startTime = Post(snapshot: itemsnapshot as! DataSnapshot)?.startTime as! String
                    let endTime = Post(snapshot: itemsnapshot as! DataSnapshot)?.endTime as! String
                    let member = Post(snapshot: itemsnapshot as! DataSnapshot)?.member as! String
                    let level = Post(snapshot: itemsnapshot as! DataSnapshot)?.level as! String
                    let comment = Post(snapshot: itemsnapshot as! DataSnapshot)?.comment as! String
                    self.posts.append([place,date,startTime,endTime,member,level,comment])
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
//        var returnvalue: Int! = 0
//        if self.posts.count == 0 {
//
//        } else {
//            returnvalue = self.posts.count
//        }
//        return returnvalue
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
    
    @objc func refresh(sender: UIRefreshControl) {
        posts.removeAll()
        ref.child("data").observe(.value, with: { (snapshot) in
            for itemsnapshot in snapshot.children {
                let place = Post(snapshot: itemsnapshot as! DataSnapshot)?.place as! String
                let date = Post(snapshot: itemsnapshot as! DataSnapshot)?.date as! String
                let startTime = Post(snapshot: itemsnapshot as! DataSnapshot)?.startTime as! String
                let endTime = Post(snapshot: itemsnapshot as! DataSnapshot)?.endTime as! String
                let member = Post(snapshot: itemsnapshot as! DataSnapshot)?.member as! String
                let level = Post(snapshot: itemsnapshot as! DataSnapshot)?.level as! String
                let comment = Post(snapshot: itemsnapshot as! DataSnapshot)?.comment as! String
                self.posts.append([place,date,startTime,endTime,member,level,comment])
            }
        } )
        tableView.reloadData()
        refreshControl.endRefreshing()
    }
}
