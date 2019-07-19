
import UIKit

class SearchViewControllerTableViewCell: UITableViewCell {
    
    @IBOutlet var placeLabel: UILabel!
    @IBOutlet var startLabel: UILabel!
    @IBOutlet var endLabel: UILabel!
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var favoriteMark: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
