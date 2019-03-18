//
//  Logger.swift
//  XO-game
//
//  Created by Evgeny Kireev on 16/03/2019.
//  Copyright © 2019 plasmon. All rights reserved.
//

import Foundation

// MARK: - Receiver

final class Logger {
    
    static let shared = Logger()
    
    func writeToLog(message: String) {
        print(message)
    }
}
