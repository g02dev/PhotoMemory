// 

import Foundation
import UIKit


struct ScrolableGrid {
    static func squareItemSize(spacing: CGFloat, columnsCount: Int, frame: CGRect) -> CGSize {
        let width = frame.size.width
        let size = (width - CGFloat(columnsCount - 1) * spacing) / CGFloat(columnsCount)
        let itemSize = CGSize(width: size, height: size)
        return itemSize
    }
    
    static func squareItemSize(spacing: CGFloat, rowsCount: Int, frame: CGRect) -> CGSize {
        let height = frame.size.height
        let size = (height - CGFloat(rowsCount - 1) * spacing) / CGFloat(rowsCount)
        let itemSize = CGSize(width: size, height: size)
        return itemSize
    }
}
