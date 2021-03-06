//
//  GridRow.swift
//  GridView
//
//  Created by Rob Lokhorst on 2017-09-06.
//  Copyright © 2017 Rob Lokhorst. All rights reserved.
//

import Foundation

open class GridRow {

  let outerLayoutGuide = UILayoutGuide()
  let innerLayoutGuide = UILayoutGuide()
  var merged: [Range<Int>] = []

  init(gridView: GridView) {
    self.gridView = gridView
  }

  open weak var gridView: GridView?

  open var numberOfCells: Int {
    return gridView?.numberOfColumns ?? 0
  }

  open func cell(at index: Int) -> GridCell? { // Note: NSGridRow returns a non-optional GridCell
    guard let gridView = gridView, let rowIndex = gridView.index(of: self) else {
      print("Assertion failure in GridRow.cell(at:). This row has been deleted, and cannot be used.")
      return nil
    }

    return gridView.cell(atColumnIndex: index, rowIndex: rowIndex)
  }

  open var yPlacement: GridRowYPlacement = .inherited { didSet { gridView?.updateGrid() } }

  //open var rowAlignment: GridRowAlignment

  open var height: CGFloat? { didSet { gridView?.updateGrid() } } // Note: NSGridRow uses a non-optional CGFloat.leastNormalMagnitude as default

  open var topPadding: CGFloat = 0 { didSet { gridView?.updateGrid() } }

  open var bottomPadding: CGFloat = 0 { didSet { gridView?.updateGrid() } }

  open var isHidden: Bool = false { didSet { gridView?.updateGrid() } }

  open func mergeCells(in range: Range<Int>) {
    merged.append(range)

    gridView?.updateGrid()
  }
}
