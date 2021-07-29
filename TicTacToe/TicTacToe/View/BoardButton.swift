//
//  BoardButton.swift
//  TicTacToe
//
//  Created by Walter A Ramirez on 7/29/21.
//
import UIKit

class BoardButton: UIButton {
    
    let index: Index
    
    init(index: Index) {
        self.index = index
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

extension BoardButton {
    
    static func createBoardButton(index: Index, variant: PlayerVariant) -> BoardButton {
        let button = BoardButton(index: index)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(nil, for: .normal)
        let image = UIImage(named: variant.rawValue)
        button.setImage(image, for: .normal)
        button.backgroundColor = .white
        return button
    }
    
}
