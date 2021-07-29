//
//  BoardItems.swift
//  TicTacToe
//
//  Created by Walter A Ramirez on 7/29/21.
//

import UIKit

class BoardView: UIView {

    var boardViewModel: BoardViewModel
    var internalStackView: UIStackView?
    var buttonMap: [Index: BoardButton] = [:]
    
    init(boardViewModel: BoardViewModel) {
        self.boardViewModel = boardViewModel
        super.init(frame: .zero)
        self.translatesAutoresizingMaskIntoConstraints = false
        createBoard(size: boardViewModel.size)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func resetBoard(with viewModel: BoardViewModel) {
        self.boardViewModel = viewModel
        self.internalStackView?.removeFromSuperview()
        self.buttonMap.removeAll()
        self.createBoard(size: viewModel.size)
    }
    
    private func createBoard(size: Int) {
        let vStack = UIStackView(axis: .vertical)
        for i in 0..<size {
            let hStack = UIStackView(axis: .horizontal)
            var buttonRow: [BoardButton] = []
            for j in 0..<size {
                let index = Index(row: i, column: j)
                let button = BoardButton.createBoardButton(index: index, variant: .none)
                button.addTarget(self, action: #selector(buttonSelected(sender:)), for: .touchUpInside)
                buttonRow.append(button)
                hStack.addArrangedSubview(button)
                self.buttonMap[index] = button
            }
            vStack.addArrangedSubview(hStack)
        }
        
        self.internalStackView = vStack
        self.addSubview(vStack)
        vStack.bindToSuperView()
    }
    
    @objc
    func buttonSelected(sender: BoardButton) {
        guard self.boardViewModel[sender.index].variant == .none else { return }
        let image = UIImage(named: self.boardViewModel.currentPlayer.rawValue)
        self.boardViewModel.updateGameBoard(with: sender.index)
        sender.setImage(image, for: .normal)
        self.isUserInteractionEnabled = false
        self.determineAIMove()
    }
    
    func determineAIMove() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            if let index = self.boardViewModel.determineDefenseLogic() {
                let image = UIImage(named: self.boardViewModel.currentPlayer.rawValue)
                self.boardViewModel.updateGameBoard(with: index)
                self.buttonMap[index]?.setImage(image, for: .normal)
            } else if let index = self.boardViewModel.findRandomAvailableIndex() {
                let image = UIImage(named: self.boardViewModel.currentPlayer.rawValue)
                self.boardViewModel.updateGameBoard(with: index)
                self.buttonMap[index]?.setImage(image, for: .normal)
            }
            self.isUserInteractionEnabled = true
        }
    }

}

