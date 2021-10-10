// 

import UIKit

class SearchImageCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    
    var isLoaded: Bool {
        return imageView.image != nil
    }
    
    var url: URL! {
        didSet {
            imageView.image = nil
            
            let dataUrl: URL = url
            UnsplashClient().loadImage(dataUrl) { [weak self] result in
                guard let self = self, self.url == dataUrl else { return }
                
                if case let .success(image) = result  {
                    self.imageView.image = image
                }
            }
        }
    }
    
    func select(with color: UIColor) {
        layer.borderWidth = Constants.UI.playCardBorderWidth
        layer.borderColor = color.cgColor
    }
    
    func deselect() {
        layer.borderWidth = 0
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        layer.cornerRadius = Constants.UI.playCardCornerRadius
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        layer.borderWidth = 0
    }
}
