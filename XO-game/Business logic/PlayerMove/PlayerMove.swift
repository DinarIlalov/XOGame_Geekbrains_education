//
//  PlayerMove.swift
//  XO-game
//
//  Created by Dinar Ilalov on 18/03/2019.
//  Copyright © 2019 plasmon. All rights reserved.
//

import Foundation

struct PlayerMove: MoveCommand {
    
    let position: GameboardPosition
    let player: Player
    let gameboard: Gameboard
    let gameboardView: GameboardView
    
    func execute() {
        if gameboard.containsAnyPlayer(at: position) == true {
            gameboardView.removeMarkView(at: position)
        }
        
        print("\(player) - \(position)")
        self.gameboard.setPlayer(self.player, at: position)
        self.gameboardView.placeMarkView(player.markViewPrototype.copy(), at: position)
    }
}
