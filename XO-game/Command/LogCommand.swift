//
//  LogCommand.swift
//  XO-game
//
//  Created by Evgeny Kireev on 16/03/2019.
//  Copyright © 2019 plasmon. All rights reserved.
//

import Foundation

// MARK: - Command

final class LogCommand {
    
    let action: LogAction
    
    init(action: LogAction) {
        self.action = action
    }
    
    var logMessage: String {
        switch self.action {
        case .playerInput(let player, let position):
            return "playerInput \(player), \(position)"
        case .gameFinished(let winner):
            if let winner = winner {
                return "\(winner) win"
            } else {
                return "game finished with no winner"
            }
        case .restartGame:
            return "restartGame"
        }
    }
    
    func execute() {
        Logger.shared.writeToLog(message: self.logMessage)
    }
}
