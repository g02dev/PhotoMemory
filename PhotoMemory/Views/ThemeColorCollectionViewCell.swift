// 

import UIKit

class ThemeColorCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var colorView: UIView!
    @IBOutlet weak var selectedImage: UIImageView!
    
    var color: UIColor! {
        didSet {
            colorView.backgroundColor = color
        }
    }
    
    var isSelectedColor: Bool! {
        didSet {
            selectedImage.isHidden = !isSelectedColor
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        layer.cornerRadius = Constants.UI.colorCornerRadius
    }

}
