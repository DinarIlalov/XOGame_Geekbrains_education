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
        
        let playerMove = PlayerMove(position: position, player: player, gameboard: gameboard, gameboardView: gameboardView)
        switch player {
        case .first:
            firstPlayerMoves.append(playerMove)
        case .second:
            secondPlayerMoves.append(playerMove)
        }
    }
    
    func isMovesMade(by player: Player) -> Bool {
        if player == .first {
            return firstPlayerMoves.count >= movesAtTurn
        } else {
            return secondPlayerMoves.count >= movesAtTurn
        }
    }
    
    func isAllMovesMade() -> Bool {
        return firstPlayerMoves.count >= movesAtTurn && secondPlayerMoves.count >= movesAtTurn
    }
    
    func executePlayersMove() {
        guard firstPlayerMoves.count >= movesAtTurn &&
            secondPlayerMoves.count >= movesAtTurn else { return }
        
        for moveStep in (0..<movesAtTurn) {
            // player two
            let firstPlayerMoveCommand = firstPlayerMoves[moveStep]
            firstPlayerMoveCommand.execute()
            // player two
            let secondPlayerMoveCommand = secondPlayerMoves[moveStep]
            secondPlayerMoveCommand.execute()
        }
        firstPlayerMoves = []
        secondPlayerMoves = []
    }
}

enum PlayersMoveMode {
    case oneByOne
    case fiveInTurn
}
