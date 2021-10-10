// 

import UIKit

class PreviewTableViewCell: UITableViewCell {

    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var pairsLabel: UILabel!
    
    var difficulty: Difficulty! {
        didSet {
            pairsLabel.text = "\(difficulty.numberOfPairs) pairs"
        }
    }
    
    var themeColor: UIColor! {
        didSet {
            photoImageView.layer.borderWidth = Constants.UI.playCardBorderWidth
            photoImageView.layer.borderColor = themeColor.cgColor
        }
    }
    
    var photoImage: UIImage? {
        didSet {
            photoImageView.image = photoImage
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        photoImageView.layer.cornerRadius = Constants.UI.playCardCornerRadius
        isUserInteractionEnabled = false
    }
}
