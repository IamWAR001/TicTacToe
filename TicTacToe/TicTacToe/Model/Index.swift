//
//  Index.swift
//  TicTacToe
//
//  Created by Walter A Ramirez on 7/29/21.

import Foundation

struct Index: Comparable, Hashable {
    
    static func < (lhs: Index, rhs: Index) -> Bool {
        if lhs.row == rhs.row {
            return lhs.column < rhs.column
        } else {
            return lhs.row < rhs.row
        }
    }
    
    let row: Int
    let column: Int
}
