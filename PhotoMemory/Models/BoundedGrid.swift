// 

import Foundation
import UIKit


struct BoundedGrid {
    
    var frame: CGRect
    
    var columnsCount: Int = 1
    
    var rowsCount: Int {
        return cellCount / columnsCount + 1
    }
    
    var cellSize: CGSize {
        return CGSize(width: cellWidth, height: cellHeight)
    }
    
    let spacing = CGFloat(Constants.UI.gameGridSpacing)
    
    private var ratio: CGFloat
    
    private var cellCount: Int
    
    private var cellWidth: CGFloat {
        return getCellWidth(for: columnsCount)
    }
    
    private var cellHeight: CGFloat {
        return cellWidth * ratio
    }
    
    private func getCellWidth(for columnsCount: Int) -> CGFloat {
        return (frame.width - spacing * CGFloat(columnsCount - 1)) / CGFloat(columnsCount)
    }
    
    init?(numberOfCells: Int, ratio: CGFloat, frame: CGRect = CGRect.zero) {
        guard numberOfCells > 0 && ratio > 0 else { return nil }
        
        self.cellCount = numberOfCells
        self.ratio = ratio
        self.frame = frame
        recalculate()
    }
    
    mutating func updateFrame(_ frame: CGRect = CGRect.zero) {
        self.frame = frame
        recalculate()
    }
    
    mutating func recalculate() {
        for newColumnsCount in 1...cellCount {
            if isColumnCountFitsFrame(newColumnsCount) {
                columnsCount = newColumnsCount
                break
            }
        }
    }
    
    private func isColumnCountFitsFrame(_ newColumnsCount: Int) -> Bool {
        let newRowsCount = (cellCount + newColumnsCount - 1) / newColumnsCount
        let cellWidth = getCellWidth(for: newColumnsCount)
        let cellHeight = cellWidth * ratio
        let contentHeight = cellHeight * CGFloat(newRowsCount) + spacing * CGFloat(newRowsCount - 1)
        return contentHeight <= frame.height
    }
}
