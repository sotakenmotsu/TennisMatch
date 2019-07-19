
import UIKit
import Foundation
import Firebase
import FirebaseDatabase

class Post {
    var ref: DatabaseReference!
    var place: String!
    var date: String!
    var startTime: String!
    var endTime: String!
    var member: String!
    var level: String!
    var comment: String!
    var gmail: String!
    var postnumber: String!
    
    init? (snapshot: DataSnapshot) {
        ref = snapshot.ref
        guard let dict = snapshot.value as? [String:Any] else { return nil }
        guard let place = dict["place"] as? String else { return nil }
        guard let date = dict["date"] as? String else { return nil }
        guard let startTime = dict["startTime"] as? String else { return nil }
        guard let endTime = dict["endTime"] as? String else { return nil }
        guard let member = dict["member"] as? String else { return nil }
        guard let level = dict["level"] as? String else { return nil }
        guard let comment = dict["comment"] as? String else { return nil }
        guard let gmail = dict["gmail"] as? String else { return nil }
        guard let postnumber = dict["postnumber"] as? String else { return nil }
        self.place = place
        self.date = date
        self.startTime = startTime
        self.endTime = endTime
        self.member = member
        self.level = level
        self.comment = comment
        self.gmail = gmail
        self.postnumber = postnumber
    }
    
}

