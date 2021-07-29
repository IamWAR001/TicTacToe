//
//  BoardViewModel.swift
//  TicTacToe
//
//  Created by Walter A Ramirez on 7/29/21.
//

import Foundation

class BoardViewModel {
        
    private var gameBoard: [[Piece]] = []
    private var winCompletion: ((String) -> Void)?
    var currentPlayer = PlayerVariant.playerX
    
    init(size: Int) {
        for i in 0..<size {
            var row: [Piece] = []
            for j in 0..<size {
                row.append(Piece(index: Index(row: i, column: j), variant: .none))
            }
            self.gameBoard.append(row)
        }
    }
    
    func bind(completion: @escaping (String) -> Void) {
        self.winCompletion = completion
    }
    
    subscript(index: Index) -> Piece {
        get {
            return gameBoard[index.row][index.column]
        }
    }
    
    
    
    var size: Int {
        return self.gameBoard.count
    }
    
    var isWin: Bool {
        // Check Row win
        for i in 0..<self.gameBoard.count {
            if self.gameBoard[i].filter({ piece in
                return piece.variant == self.currentPlayer
            }).count == self.size {
                return true
            }
        }
        
        // Check Column win
        for i in 0..<self.gameBoard.count {
            if self.gameBoard.map{ $0[i] }.filter ({ piece in
                return piece.variant == self.currentPlayer
            }).count == self.size {
                return true
            }
        }
        
        // Check Diagonal Win 1
        if self.gameBoard.enumerated().map{ $1[$0] }.filter ({ piece in
            return piece.variant == self.currentPlayer
        }).count == self.size {
            return true
        }
        
        // Check Diagonal Win 2
        if self.gameBoard.enumerated().map{ $1.reversed()[$0] }.filter ({ piece in
            return piece.variant == self.currentPlayer
        }).count == self.size {
            return true
        }
        
        return false
    }
    
    var isDraw: Bool {
        return self.gameBoard.allSatisfy { row in
            return !row.contains(where: { piece in
                return piece.variant == .none
            })
        }
    }
    
    func updateGameBoard(with index: Index) {
        self.gameBoard[index.row][index.column] = Piece(index: index, variant: self.currentPlayer)
        if self.isWin {
            winCompletion?("Player \(self.currentPlayer.rawValue) Wins!")
        } else if isDraw {
            winCompletion?("It's a draw!")
        }
        self.currentPlayer = (self.currentPlayer == .playerX) ? .playerO : .playerX
    }
    
    func determineDefenseLogic() -> Index? {
        let opponent = (self.currentPlayer == .playerX) ? PlayerVariant.playerO : PlayerVariant.playerX
        
        // Defend Row
        for i in 0..<self.gameBoard.count {
            if self.gameBoard[i].filter({ piece in
                return piece.variant == opponent
            }).count == (self.size - 1), let empyPiece = self.gameBoard[i].first(where: { piece in
                return piece.variant == .none
            }) {
                return empyPiece.index
            }
        }
        
        // Defend Column
        for i in 0..<self.gameBoard.count {
            let column = self.gameBoard.map{ $0[i] }
            if column.filter({ piece in
                return piece.variant == opponent
            }).count == (self.size - 1), let emptyPiece = column.first(where: { piece in
                return piece.variant == .none
            }) {
                return emptyPiece.index
            }
        }
        
        // Diagonal 1
        let diagonal1 = self.gameBoard.enumerated().map { $1[$0] }
        if diagonal1.filter({ piece in
            return piece.variant == opponent
        }).count == (self.size - 1), let emptyPiece = diagonal1.first(where: { piece in
            piece.variant == .none
        }) {
            return emptyPiece.index
        }
        
        // Diagonal 2
        let diagonal2 = self.gameBoard.enumerated().map{ $1.reversed()[$0] }
        if diagonal2.filter({ piece in
            return piece.variant == opponent
        }).count == (self.size - 1), let emptyPiece = diagonal2.first(where: { piece in
            piece.variant == .none
        }) {
            return emptyPiece.index
        }
        
        return nil
    }
    
    func findRandomAvailableIndex() -> Index? {
        let available = self.gameBoard.flatMap { $0 }.filter { piece in
            return piece.variant == .none
        }
        return available.randomElement()?.index
    }
    
}

