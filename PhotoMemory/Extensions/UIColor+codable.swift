// 

import Foundation
import UIKit


extension UIColor {
     class func color(data: Data) -> Self? {
          return try? NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data) as? Self
     }

     func encode() -> Data? {
          return try? NSKeyedArchiver.archivedData(withRootObject: self, requiringSecureCoding: false)
     }
}
