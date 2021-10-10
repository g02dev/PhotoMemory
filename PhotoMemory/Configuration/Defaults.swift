// 

import Foundation


struct Defaults {
    static var difficulty: Difficulty {
        set {
            UserDefaults.standard.set(newValue.rawValue + 1, forKey: Constants.Settings.difficultyKey)
        }
        get {
            let defaultValue = UserDefaults.standard.integer(forKey: Constants.Settings.difficultyKey)
            if defaultValue == 0 {
                return Constants.Settings.difficulty
            } else {
                return Difficulty.init(rawValue: defaultValue - 1) ?? Constants.Settings.difficulty
            }
        }
    }
    
    static var theme: Theme = Constants.Settings.theme
    
    static var dataController: DataController = DataController(modelName: "PhotoMemory")
}
