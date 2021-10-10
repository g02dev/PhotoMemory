// 

import Foundation
import UIKit


struct CardImageChooser {
        
    private var freeImages: [UIImage]
    
    private var selectedImages: [Card: UIImage]
    
    init(theme: Theme) {
        freeImages = theme.images
        selectedImages = [:]
    }
    
    mutating func image(for card: Card) -> UIImage? {
        if selectedImages[card] == nil && freeImages.count > 0 {
            let index = Int.random(in: freeImages.indices)
            let selectedImage = freeImages[index]
            selectedImages[card] = selectedImage
            freeImages.remove(at: index)
        }
        
        return selectedImages[card]
    }
}
