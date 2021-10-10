// 

import Foundation


enum Difficulty: Int, CaseIterable {
    case easy = 0
    case medium
    case hard
    
    var text: String {
        switch self {
        case .easy: return "Easy"
        case .medium: return "Medium"
        case .hard: return "Hard"
        }
    }
    
    var numberOfPairs: Int {
        switch self {
        case .easy: return 4
        case .medium: return 8
        case .hard: return 16
        }
    }
}
