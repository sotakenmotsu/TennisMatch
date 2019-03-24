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
    var posts = [Post]()
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
                    let post = Post(snapshot: itemsnapshot as! DataSnapshot) as! Post
                    self.posts.append(post)
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
                    let post = Post(snapshot: itemsnapshot as! DataSnapshot)
                    self.posts.append(post!)
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
            cell.placeLabel.text = self.posts[indexPath.row].place
            cell.memberLabel.text = self.posts[indexPath.row].member
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "toJoinViewController", sender: (posts[indexPath.row],indexPath.row))
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toJoinViewController" {
            let JoinVC: JoinViewController = segue.destination as! JoinViewController
            let selectedSender = sender as! (Post,Int)
            JoinVC.post = selectedSender.0
            JoinVC.childNumber = selectedSender.1
        }
    }
    
    @IBAction func clickRefreshButton() {
        SVProgressHUD.show()
        posts.removeAll()
        ref.child("data").observe(.value, with: { (snapshot) in
            for itemsnapshot in snapshot.children {
                let post = Post(snapshot: itemsnapshot as! DataSnapshot)
                self.posts.append(post!)
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
