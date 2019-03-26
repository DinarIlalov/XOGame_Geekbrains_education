//
//  StateSwitcher.swift
//  XO-game
//
//  Created by Dinar Ilalov on 18/03/2019.
//  Copyright © 2019 plasmon. All rights reserved.
//

import Foundation

final class GameStateFacade {
    
    var currentState: GameState! {
        didSet {
            currentState.begin()
        }
    }
    weak var gameViewInput: GameViewController?
    private lazy var referee: Referee? = {
        if let gameboard = gameViewInput?.gameboard {
            return Referee(gameboard: gameboard)
        }
        return nil
    }()
    
    var movesInvoker: MoveInvoker?
    
    init(gameViewInput: GameViewController) {
        self.gameViewInput = gameViewInput
        
        if gameViewInput.gameMode == .fiveInTurn {
            movesInvoker = MoveInvoker(moveMode: .fiveInTurn, gameboard: gameViewInput.gameboard, gameboardView: gameViewInput.gameboardView)
        }
    }
    
    func addMarkAndSwitchToNextState(at position: GameboardPosition) {
        addMark(at: position)
        switchToNextState()
    }
    
    func switchToFirstState() {
        if gameViewInput?.gameMode == .onePlayer && gameViewInput?.aiPlayer == .first {
            switchToAIInputState(with: .first)
        } else if gameViewInput?.gameMode == .fiveInTurn {
            swithToPlayerFiveMovesState(with: .first)
        } else {
            switchToPlayerInputState(with: .first)
        }
    }
    
    private func addMark(at position: GameboardPosition?) {
        currentState.addMark(at: position)
    }
    
    private func switchToNextState() {
        guard isCurrentStateCompleted() == true,
            let gameViewInput = self.gameViewInput,
            let gameMode = gameViewInput.gameMode else { return }
        
        // winner determine
        if type(of: currentState) == FiveMovesModeExecuteState.self {
            switchToFinishedState(with: referee?.determineWinner())
            return
        } else if let winner = referee?.determineWinner() {
            switchToFinishedState(with: winner)
            return
        } else if gameViewInput.gameboard.areAllPositionsFullfilled() == true {
            switchToFinishedState(with: nil)
            return
        }
        
        switch gameMode {
        case .fiveInTurn:
            if movesInvoker?.isAllMovesMade() == true {
                switchToFiveMovesModeEcecuteState()
            } else {
                swithToPlayerFiveMovesState(with: .second)
            }
        case .twoPlayers:
            gameViewInput.currentPlayer = gameViewInput.currentPlayer.next
            switchToPlayerInputState(with: gameViewInput.currentPlayer)
        case .onePlayer:
            if gameViewInput.currentPlayer == gameViewInput.aiPlayer {
                gameViewInput.currentPlayer = gameViewInput.currentPlayer.next
                switchToPlayerInputState(with: gameViewInput.currentPlayer)
            } else {
                gameViewInput.currentPlayer = gameViewInput.currentPlayer.next
                switchToAIInputState(with: gameViewInput.currentPlayer)
            }
        }
    }
    
    private func switchToPlayerInputState(with player: Player) {
        let prototype = player.markViewPrototype
        prototype.lineColor = player == .first ? .red : .black
        prototype.layoutSubviews()
        if let gameViewInput = gameViewInput {
            currentState = PlayerInputState(player: player,
                                        gameboard: gameViewInput.gameboard,
                                        gameboardView: gameViewInput.gameboardView,
                                        gameViewInput: gameViewInput,
                                        markViewPrototype: prototype)
        }
    }
    
    private func switchToAIInputState(with player: Player) {
        let prototype = player.markViewPrototype
        prototype.lineColor = .blue
        prototype.layoutSubviews()
        if let gameViewInput = gameViewInput {
            currentState = ArtificialIntelligenceInputState(player: player,
                                                        gameboard: gameViewInput.gameboard,
                                                        gameboardView: gameViewInput.gameboardView,
                                                        gameViewInput: gameViewInput,
                                                        markViewPrototype: prototype)
        }
        addMark(at: nil)
        self.switchToNextState()
    }
    
    private func swithToPlayerFiveMovesState(with player: Player) {
        if let gameViewInput = gameViewInput {
            currentState = PlayerInputStateFiveMoves(player: player,
                                            gameboard: gameViewInput.gameboard,
                                            gameboardView: gameViewInput.gameboardView,
                                            gameViewInput: gameViewInput,
                                            markViewPrototype: player.markViewPrototype)
            (currentState as? PlayerInputStateFiveMoves)?.movesInvoker = movesInvoker
        }
    }
    
    private func switchToFiveMovesModeEcecuteState() {
        currentState = FiveMovesModeExecuteState(movesInvoker: movesInvoker)
        self.switchToNextState()
    }
    
    private func switchToFinishedState(with winner: Player?) {
        if let gameViewInput = gameViewInput {
            currentState = GameFinishedState(winner: winner,
                                         gameViewInput: gameViewInput)
        }
    }
    
    private func isCurrentStateCompleted() -> Bool {
        return self.currentState.isCompleted
    }
    
}
