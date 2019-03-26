//
//  MainMenuViewController.swift
//  XO-game
//
//  Created by Dinar Ilalov on 18/03/2019.
//  Copyright © 2019 plasmon. All rights reserved.
//

import UIKit

class MainMenuViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "twoPlayersGameSegue":
            prepareGame(gameMode: .twoPlayers, gameController: segue.destination)
        case "onePlayerGameSegue":
            prepareGame(gameMode: .onePlayer, gameController: segue.destination)
        case "fiveMovesGameSegue":
            prepareGame(gameMode: .fiveInTurn, gameController: segue.destination)
        default:
            break
        }
    }
    
    private func prepareGame(gameMode: GameMode, gameController: UIViewController) {
        guard let gameController = gameController as? GameViewController else { return }
        
        gameController.gameMode = gameMode
        
        if gameMode == .onePlayer {
            gameController.aiPlayer = Player.random()
        }
    }
}
