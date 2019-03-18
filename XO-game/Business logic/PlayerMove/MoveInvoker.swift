//
//  MoveInvoker.swift
//  XO-game
//
//  Created by Dinar Ilalov on 18/03/2019.
//  Copyright © 2019 plasmon. All rights reserved.
//

import Foundation

final class MoveInvoker {
    
    private let movesAtTurn: Int = 5
    
    private(set) var firstPlayerMoves: [PlayerMove] = []
    private(set) var secondPlayerMoves: [PlayerMove] = []
    
    private let moveMode: PlayersMoveMode
    
    private let gameboard: Gameboard
    private let gameboardView: GameboardView
    
    init(moveMode: PlayersMoveMode, gameboard: Gameboard, gameboardView: GameboardView) {
        self.moveMode = moveMode
        self.gameboard = gameboard
        self.gameboardView = gameboardView
    }
    
    func addMove(for player: Player, at position: GameboardPosition) {
        switch player {
        case .first:
            firstPlayerMoves.append(PlayerMove(position: position, gameboard: gameboard, gameboardView: gameboardView))
        case .second:
            secondPlayerMoves.append(PlayerMove(position: position, gameboard: gameboard, gameboardView: gameboardView))
        }
    }
    
    func executePlayersMove() -> Bool {
        guard firstPlayerMoves.count >= 5 &&
            secondPlayerMoves.count >= 5 else { return false }
        
        for moveStep in (0..<movesAtTurn) {
            // player two
            let firstPlayerMoveCommand = firstPlayerMoves[moveStep]
            firstPlayerMoveCommand.execute()
            // player two
            let secondPlayerMoveCommand = secondPlayerMoves[moveStep]
            secondPlayerMoveCommand.execute()
        }
        
        return true
    }
}

enum PlayersMoveMode {
    case oneByOne
    case fiveInTurn
}
