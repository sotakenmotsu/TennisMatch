
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
    @IBOutlet var favoriteButton: UIButton!
    var isFaved: Bool!
    var favoriteArray: [Int] = []
    
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
        favoriteArray = userDefaults.array(forKey: "favorite") as! [Int]
        if !isFaved {
            favoriteButton.setTitle("お気に入り", for: .normal)
            favoriteButton.setTitleColor(UIColor.white, for: .normal)
        } else {
            favoriteButton.setTitle("お気に入り解除", for: .normal)
            favoriteButton.setTitleColor(UIColor.white, for: .normal)
        }
    }
    
    @IBAction func favoButton() {
        if !isFaved {
            self.favorite()
        } else {
            self.deletefavorite()
        }
    }
    
    func favorite() {
        if userDefaults.object(forKey: "favorite") == nil {
            let favorite: [Int] = [postnumber]
            userDefaults.set(favorite,
                             forKey: "favorite")
            userDefaults.synchronize()
        } else {
            var favorite: [Int] = userDefaults.array(forKey: "favorite") as! [Int]
            favorite.append(postnumber)
            userDefaults.removeObject(forKey: "favorite")
            userDefaults.set(favorite,
                             forKey: "favorite")
            userDefaults.synchronize()
        }
        isFaved = true
        favoriteButton.setTitle("お気に入り解除",
                                for: .normal)
        favoriteButton.setTitleColor(UIColor.white,
                                     for: .normal)
    }
    
    func deletefavorite() {
        let favorite: [Int] = userDefaults.array(forKey: "favorite") as! [Int]
        var newfavorite: [Int] = []
        for i in favorite {
            if i != postnumber {
                newfavorite.append(i)
            }
        }
        userDefaults.removeObject(forKey: "favorite")
        userDefaults.set(newfavorite,
                         forKey: "favorite")
        userDefaults.synchronize()
        isFaved = false
        favoriteButton.setTitle("お気に入り",
                                for: .normal)
        favoriteButton.setTitleColor(UIColor.white,
                                     for: .normal)
    }
    
}
