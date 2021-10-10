// 

import UIKit

class ThemeTableViewCell: UITableViewCell {
    @IBOutlet weak var cardImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var detailLabel: UILabel!
    
    var theme: Theme! {
        didSet {
            let numberOfImages = theme.images.count
            
            titleLabel.text = theme.name
            detailLabel.text = "\(String(numberOfImages)) / \(Constants.Game.minImagesCount) images"
            detailLabel.textColor = .gray
            cardImageView.image = theme.coverImage
            cardImageView.layer.borderColor = theme.color.cgColor
        }
    }
    
    var isSelectedTheme: Bool! {
        didSet {
            accessoryType = isSelectedTheme ? .checkmark : .none
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        cardImageView.layer.borderWidth = Constants.UI.playCardBorderWidth
        cardImageView.layer.cornerRadius = Constants.UI.playCardCornerRadius
    }
}
