// 

import Foundation
import UIKit


struct Constants {
    
    struct Alert {
        static let imageSearchFailedTitle = "Search failed"
        static let incompleteThemeTitle = "Incomplete theme"
        static let userThemesLoadFailedTitle = "Failed to load user themes"
    }
    
    struct Game {
        static let minImagesCount: Int = 16
        static let maxImagesCount: Int = 30
    }
    
    struct Settings {
        static let difficulty = Difficulty.easy
        static let theme = DefaultThemes.animals.theme
        
        static let difficultyKey = "preferedDifficultyKey"
    }
    
    struct Segue {
        static let difficultySettings = "DifficultySettingsSegue"
        static let themeSettings = "ThemeSettingsSegue"
        static let theme = "ThemeSegue"
        static let gameOver = "GameOverSegue"
        static let imageSearch = "ImageSearchSegue"
    }
    
    struct ReuseId {
        static let previewCell = "PreviewCell"
        static let settingCell = "SettingCell"
        static let difficultyCell = "DifficultyCell"
        static let themeCell = "ThemeCell"
        static let noCustmomThemesCell = "NoCustomThemesCell"
        static let gameCardCell = "GameCardCell"
        static let themeColorCell = "ThemeColorCell"
        static let themeNewImageCell = "ThemeNewImageCell"
        static let themeImageCell = "ThemeImageCell"
        static let searchImageCell = "SearchImageCell"
    }
    
    struct UI {
        static let buttonCornerRadius: CGFloat = 10.0
        static let colorCornerRadius: CGFloat = 5.0
        static let playCardCornerRadius: CGFloat = 10.0
        static let playCardBorderWidth: CGFloat = 5.0
        
        static let gameGridSpacing: CGFloat = 8.0
        static let imagesGridSpacing: CGFloat = 10.0
        static let colorsGridSpacing: CGFloat = 10.0
        
        static let imagesColumnsCount: Int = 4
    }
    
    struct Test {
        static let testImageUrl = URL(string: "https://images.unsplash.com/photo-1416339306562-f3d12fefd36f?ixlib=rb-0.3.5&q=80&fm=jpg&crop=entropy&cs=tinysrgb&w=400&fit=max&s=263af33585f9d32af39d165b000845eb")!
    }
}
