//
//  GameViewController.swift
//  XO-game
//
//  Created by Evgeny Kireev on 25/02/2019.
//  Copyright © 2019 plasmon. All rights reserved.
//

import UIKit

protocol GameViewInput: class {
    var firstPlayerTurnLabel: UILabel! { get }
    var secondPlayerTurnLabel: UILabel! { get }
    var winnerLabel: UILabel! { get }
    var restartButton: UIButton! { get }
}

class GameViewController: UIViewController, GameViewInput {

    @IBOutlet var gameboardView: GameboardView!
    @IBOutlet var firstPlayerTurnLabel: UILabel!
    @IBOutlet var secondPlayerTurnLabel: UILabel!
    @IBOutlet var winnerLabel: UILabel!
    @IBOutlet var restartButton: UIButton!
    
    private let gameboard = Gameboard()
    private lazy var referee = Referee(gameboard: self.gameboard)
    
    var currentState: GameState! {
        didSet {
            currentState.begin()
        }
    }
    
    var currentPlayer: Player = .first
    var gameMode: GameMode!
    var aiPlayer: Player?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        switchToFirstState()
        gameboardView.onSelectPosition = { [weak self] position in
            guard let self = self else { return }
            self.currentState.addMark(at: position)
            self.switchToNextState()
        }
    }
    
    @IBAction func restartButtonTapped(_ sender: UIButton) {
        Log(.restartGame)
        gameboard.clear()
        gameboardView.clear()
        self.currentPlayer = .first
        if gameMode == .onePlayer {
            self.aiPlayer = Player.random()
        }
        switchToFirstState()
    }
    
    private func switchToFirstState() {
        if gameMode == .onePlayer && aiPlayer == .first {
            switchToAIInputState(with: .first)
        } else {
            switchToPlayerInputState(with: .first)
        }
    }
    
    private func switchToNextState() {
        guard self.currentState.isCompleted else { return }
        if let winner = referee.determineWinner() {
            switchToFinishedState(with: winner)
        } else if gameboard.areAllPositionsFullfilled() {
            switchToFinishedState(with: nil)
        } else if gameMode == .onePlayer {
            if currentPlayer == aiPlayer {
                currentPlayer = currentPlayer.next
                switchToPlayerInputState(with: currentPlayer)
            } else {
                currentPlayer = currentPlayer.next
                switchToAIInputState(with: currentPlayer)
            }
        } else {
            currentPlayer = currentPlayer.next
            switchToPlayerInputState(with: currentPlayer)
        }
    }
    
    private func switchToPlayerInputState(with player: Player) {
        let prototype = player.markViewPrototype
        prototype.lineColor = player == .first ? .red : .black
        prototype.layoutSubviews()
        currentState = PlayerInputState(player: player,
                                        gameboard: gameboard,
                                        gameboardView: gameboardView,
                                        gameViewInput: self,
                                        markViewPrototype: prototype)
    }
    
    private func switchToAIInputState(with player: Player) {
        let prototype = player.markViewPrototype
        prototype.lineColor = .blue
        prototype.layoutSubviews()
        currentState = ArtificialIntelligenceInputState(player: player,
                                        gameboard: gameboard,
                                        gameboardView: gameboardView,
                                        gameViewInput: self,
                                        markViewPrototype: prototype)
        currentState.addMark(at: nil)
        self.switchToNextState()
    }
    
    private func switchToFinishedState(with winner: Player?) {
        currentState = GameFinishedState(winner: winner,
                                         gameViewInput: self)
    }
}

