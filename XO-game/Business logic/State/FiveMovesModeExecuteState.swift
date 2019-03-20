//
//  FiveMovesModeExecuteState.swift
//  XO-game
//
//  Created by Dinar Ilalov on 19/03/2019.
//  Copyright © 2019 plasmon. All rights reserved.
//

import Foundation

class FiveMovesModeExecuteState: GameState {
    
    var isCompleted: Bool = false
    
    let movesInvoker: MoveInvoker?
    
    init(movesInvoker: MoveInvoker?) {
        self.movesInvoker = movesInvoker
    }
    
    func begin() {
        movesInvoker?.executePlayersMove()
        isCompleted = true
    }
    
    func addMark(at position: GameboardPosition?) {
        
    }
}
