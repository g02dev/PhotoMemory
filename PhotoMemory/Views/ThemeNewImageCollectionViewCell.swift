// 

import UIKit

class ThemeNewImageCollectionViewCell: UICollectionViewCell {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        layer.cornerRadius = Constants.UI.playCardCornerRadius
    }
}
