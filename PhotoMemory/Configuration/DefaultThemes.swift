// 

import Foundation


enum DefaultThemes: CaseIterable {
    case animals
    case fruits
    
    var theme: Theme {
        switch self {
        case .animals:
            return Theme(
                identifier: "animal-theme",
                name: "Animals",
                color: .systemBlue,
                images: [#imageLiteral(resourceName: "fish"), #imageLiteral(resourceName: "cat"), #imageLiteral(resourceName: "snail"), #imageLiteral(resourceName: "dog"), #imageLiteral(resourceName: "giraffe"), #imageLiteral(resourceName: "flamingo"), #imageLiteral(resourceName: "snake"), #imageLiteral(resourceName: "squirrel"), #imageLiteral(resourceName: "panda"), #imageLiteral(resourceName: "bear"), #imageLiteral(resourceName: "fox"), #imageLiteral(resourceName: "hedgehog"), #imageLiteral(resourceName: "pig"), #imageLiteral(resourceName: "zebra"), #imageLiteral(resourceName: "tiger"), #imageLiteral(resourceName: "lion")]
            )
        case .fruits:
            return Theme(
                identifier: "fruit-theme",
                name: "Fruits",
                color: .systemYellow,
                images: [#imageLiteral(resourceName: "lemon"), #imageLiteral(resourceName: "apricot"), #imageLiteral(resourceName: "plum"), #imageLiteral(resourceName: "banana"), #imageLiteral(resourceName: "pear"), #imageLiteral(resourceName: "ananas"), #imageLiteral(resourceName: "apple"), #imageLiteral(resourceName: "papaya"), #imageLiteral(resourceName: "orange"), #imageLiteral(resourceName: "pomergranate"), #imageLiteral(resourceName: "melon"), #imageLiteral(resourceName: "watermelon"), #imageLiteral(resourceName: "kiwi"), #imageLiteral(resourceName: "grapefruit"), #imageLiteral(resourceName: "grape"), #imageLiteral(resourceName: "peach")]
            )
        }
    }
}
