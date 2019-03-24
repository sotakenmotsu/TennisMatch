//
//  Post.swift
//  TennisMatch
//
//  Created by 剱物蒼太 on 2018/11/16.
//  Copyright © 2018年 剱物蒼太. All rights reserved.
//

import UIKit
import Foundation
import Firebase
import FirebaseDatabase

class Post {
    var ref: DatabaseReference!
    var place: String!
//    var date: String!
//    var startTime: String!
//    var endTime: String!
    var member: String!
    var level: String!
    var comment: String!
    var gmail: String!
    var dates = [String]()
    var members = [String]()
    
    init? (snapshot: DataSnapshot) {
        ref = snapshot.ref
        guard let dict = snapshot.value as? [String:Any] else { return nil }
        guard let place = dict["place"] as? String else { return nil }
        guard let member = dict["member"] as? String else { return nil }
        guard let level = dict["level"] as? String else { return nil }
        guard let comment = dict["comment"] as? String else { return nil }
        guard let gmail = dict["gmail"] as? String else { return nil }
        guard let dates = dict["days"] as? [String] else { return nil }
        guard let members = dict["members"] as? [String] else { return nil }
        self.place = place
        self.member = member
        self.level = level
        self.comment = comment
        self.gmail = gmail
        self.dates = dates
        self.members = members
    }
}

