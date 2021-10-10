// 

import Foundation
import UIKit


struct Theme: Equatable {
    var identifier: String
    var name: String
    var color: UIColor
    var images: [UIImage]
    
    var coverImage: UIImage? {
        return images.first
    }
}


extension Theme: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(self.identifier)
    }

    static func == (lhs: Self, rhs: Self) -> Bool {
        return lhs.identifier == rhs.identifier
    }
}

