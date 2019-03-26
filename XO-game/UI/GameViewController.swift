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

    // MARK: Outlets
    @IBOutlet var gameboardView: GameboardView!
    @IBOutlet var firstPlayerTurnLabel: UILabel!
    @IBOutlet var secondPlayerTurnLabel: UILabel!
    @IBOutlet var winnerLabel: UILabel!
    @IBOutlet var restartButton: UIButton!
    
    // MARK: dependicies
    let gameboard = Gameboard()
    
    private lazy var gameStateFacade: GameStateFacade = {
        return GameStateFacade(gameViewInput: self)
    }()
    
    var gameMode: GameMode!
    var currentPlayer: Player = .first
    var aiPlayer: Player?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        gameStateFacade.switchToFirstState()
        
        gameboardView.onSelectPosition = { [weak self] position in
            self?.gameStateFacade.addMarkAndSwitchToNextState(at: position)
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
        self.gameStateFacade.switchToFirstState()
    }
}

