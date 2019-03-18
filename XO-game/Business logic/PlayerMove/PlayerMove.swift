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
    let gameboard: Gameboard
    let gameboardView: GameboardView
    
    func execute() {
        
    }
}
