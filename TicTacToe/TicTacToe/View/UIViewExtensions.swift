//
//  StackViewExtensions.swift
//  TicTacToe
//
//  Created by Walter A Ramirez on 7/29/21.
//

import UIKit

extension UIView {
    
    func bindToSuperView(insets: UIEdgeInsets = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)) {
        guard let superViewSafeArea = self.superview?.safeAreaLayoutGuide else {
            fatalError("Ruh-Roh Raggy, you forgot to add the view to the hierarchy!")
        }
        self.topAnchor.constraint(equalTo: superViewSafeArea.topAnchor, constant: insets.top).isActive = true
        self.leadingAnchor.constraint(equalTo: superViewSafeArea.leadingAnchor, constant: insets.left).isActive = true
        self.trailingAnchor.constraint(equalTo: superViewSafeArea.trailingAnchor, constant: -insets.right).isActive = true
        self.bottomAnchor.constraint(equalTo: superViewSafeArea.bottomAnchor, constant: -insets.bottom).isActive = true
    }
    
}
