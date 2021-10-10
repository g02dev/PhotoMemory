// 

import UIKit

class GameCardCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    
    var image: UIImage! {
        didSet {
            imageView.image = image
        }
    }
    
    var isFaceUp: Bool! {
        didSet {
            imageView.isHidden = !isFaceUp
        }
    }
    
    var isMatched: Bool! {
        didSet {
            if isMatched {
                contentView.backgroundColor = UIColor.lightGray
            } else {
                contentView.backgroundColor = themeColor
            }
        }
        
    }
    
    var themeColor: UIColor {
        return Defaults.theme.color
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        layer.cornerRadius = Constants.UI.playCardCornerRadius
    }
    
}
