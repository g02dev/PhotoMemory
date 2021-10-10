// 

import Foundation


enum UnsplashError: LocalizedError {
    case clientError(message: String)
    case serverError(message: String)
    case imageLoadError(message: String)
    case unknownError
    
    var localizedDescription: String {
        switch self {
        case let .clientError(message),
             let .serverError(message),
             let .imageLoadError(message):
            return message
        case .unknownError:
            return "Unknown error"
        }
    }
}
