// 

import Foundation
import UIKit
import CoreData

extension UserTheme {
    
    public override func awakeFromInsert() {
        super.awakeFromInsert()
        identifier = UUID()
    }
    
    var theme: Theme {
        let color = colorData != nil ? UIColor.color(data: colorData!) : nil
        let themeImages = images?.map{ $0 as! ThemeImage} ?? []
        let images = themeImages.compactMap{ UIImage(data: $0.data!) }
        
        return Theme(
            identifier: identifier!.uuidString,
            name: name ?? "Nameless",
            color: color ?? UIColor.gray,
            images: images
        )
    }
    
    convenience init(context: NSManagedObjectContext, name themeName: String, color: UIColor, images: [UIImage]) {
        self.init(context: context)

        name = themeName
        colorData = color.encode()
        
        for image in images {
            let themeImage = ThemeImage(context: Defaults.dataController.viewContext)
            themeImage.data = image.jpegData(compressionQuality: 1.0)
            themeImage.theme = self
        }
    }
}
