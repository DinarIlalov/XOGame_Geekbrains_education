//
//  PlayerInputState.swift
//  XO-game
//
//  Created by Evgeny Kireev on 16/03/2019.
//  Copyright © 2019 plasmon. All rights reserved.
//

import Foundation

class PlayerInputState: GameState {
    
    var isCompleted: Bool = false
    
    let player: Player
    weak var gameboard: Gameboard?
    weak var gameboardView: GameboardView?
    weak var gameViewInput: GameViewInput?
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
    
    func addMark(at position: GameboardPosition) {
        guard !self.isCompleted else { return }
        guard gameboard?.containsAnyPlayer(at: position) == false else { return }
        Log(.playerInput(player: self.player, position: position))
        self.gameboard?.setPlayer(self.player, at: position)
        self.gameboardView?.placeMarkView(self.markViewPrototype.copy(), at: position)
        self.isCompleted = true
    }
}
