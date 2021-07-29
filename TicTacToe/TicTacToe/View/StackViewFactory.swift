//
//  StackViewFactory.swift
//  TicTacToe
//
//  Created by Walter A Ramirez on 7/29/21.
//

import Foundation

import UIKit

extension UIStackView {
    
    convenience init(axis: NSLayoutConstraint.Axis) {
        self.init(frame: .zero)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.axis = axis
        self.spacing = 3
        self.distribution = .fillEqually
        self.backgroundColor = .black
    }
    
    
}
