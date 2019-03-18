//
//  GameFinishedState.swift
//  XO-game
//
//  Created by Evgeny Kireev on 16/03/2019.
//  Copyright © 2019 plasmon. All rights reserved.
//

import Foundation

class GameFinishedState: GameState {
    
    let isCompleted: Bool = false
    
    let winner: Player?
    weak var gameViewInput: GameViewInput?
    
    init(winner: Player?, gameViewInput: GameViewInput) {
        self.winner = winner
        self.gameViewInput = gameViewInput
    }
    
    func begin() {
        Log(.gameFinished(winner: self.winner))
        self.gameViewInput?.firstPlayerTurnLabel.isHidden = true
        self.gameViewInput?.secondPlayerTurnLabel.isHidden = true
        self.gameViewInput?.winnerLabel.isHidden = false
        if let winner = winner {
            switch winner {
            case .first:
                self.gameViewInput?.winnerLabel.text = "First player win"
            case .second:
                self.gameViewInput?.winnerLabel.text = "Second player win"
            }
        } else {
            self.gameViewInput?.winnerLabel.text = "No winner"
        }
    }
    
    func addMark(at position: GameboardPosition?) { }
}
