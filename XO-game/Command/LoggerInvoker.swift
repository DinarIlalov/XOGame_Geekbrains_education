//
//  LoggerInvoker.swift
//  XO-game
//
//  Created by Evgeny Kireev on 16/03/2019.
//  Copyright © 2019 plasmon. All rights reserved.
//

import Foundation

// MARK: - Invoker

final class LoggerInvoker {
    
    static let shared = LoggerInvoker()
    
    private var commands: [LogCommand] = []
    private let batchSize = 10
    
    func addCommand(_ logCommand: LogCommand) {
        commands.append(logCommand)
        executeCommandsIfNeeded()
    }
    
    private func executeCommandsIfNeeded() {
        guard commands.count >= self.batchSize else {
            return
        }
        commands.forEach { $0.execute() }
        commands = []
    }
}
