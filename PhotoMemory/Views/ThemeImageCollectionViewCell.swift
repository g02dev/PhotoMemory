// 

import UIKit

class ThemeImageCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!
    
    var image: UIImage! {
        didSet {
            imageView.image = image
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        layer.cornerRadius =  Constants.UI.playCardCornerRadius
    }
}
