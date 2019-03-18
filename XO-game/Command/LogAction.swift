//
//  LogAction.swift
//  XO-game
//
//  Created by Evgeny Kireev on 16/03/2019.
//  Copyright © 2019 plasmon. All rights reserved.
//

import Foundation

enum LogAction {
    
    case playerInput(player: Player, position: GameboardPosition)
    
    case gameFinished(winner: Player?)
    
    case restartGame
}

func Log(_ action: LogAction) {
    let command = LogCommand(action: action)
    LoggerInvoker.shared.addCommand(command)
}
