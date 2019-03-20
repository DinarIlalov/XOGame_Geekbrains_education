//
//  PlayerInputState.swift
//  XO-game
//
//  Created by Evgeny Kireev on 16/03/2019.
//  Copyright © 2019 plasmon. All rights reserved.
//

import Foundation

class PlayerInputStateFiveMoves: GameState {
    
    var isCompleted: Bool = false
    
    let player: Player
    weak var gameboard: Gameboard?
    weak var gameboardView: GameboardView?
    weak var gameViewInput: GameViewInput?
    weak var movesInvoker: MoveInvoker?
    let markViewPrototype: MarkView
    
    init(player: Player, gameboard: Gameboard, gameboardView: GameboardView, gameViewInput: GameViewInput, markViewPrototype: MarkView) {
        self.player = player
        self.gameboard = gameboard
        self.gameboardView = gameboardView
        self.gameViewInput = gameViewInput
        self.markViewPrototype = markViewPrototype
    }
    
    func begin() {
        switch self.player {
        case .first:
            self.gameViewInput?.firstPlayerTurnLabel.isHidden = false
            self.gameViewInput?.secondPlayerTurnLabel.isHidden = true
        case .second:
            self.gameViewInput?.firstPlayerTurnLabel.isHidden = true
            self.gameViewInput?.secondPlayerTurnLabel.isHidden = false
        }
        self.gameViewInput?.winnerLabel.isHidden = true
    }
    
    func addMark(at position: GameboardPosition?) {
        guard !self.isCompleted, let position = position else { return }
        guard gameboard?.containsAnyPlayer(at: position) == false else { return }
        
        movesInvoker?.addMove(for: player, at: position)
        self.gameboardView?.placeMarkView(self.markViewPrototype.copy(), at: position)
        
        let playerMadeAllMoves = movesInvoker?.isMovesMade(by: player) == true
        
        if playerMadeAllMoves {
            gameboardView?.clear()
        }
        self.isCompleted = playerMadeAllMoves
    }
}
