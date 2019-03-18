//
//  StateSwitcher.swift
//  XO-game
//
//  Created by Dinar Ilalov on 18/03/2019.
//  Copyright © 2019 plasmon. All rights reserved.
//

import Foundation

final class GameStateFacade {
    
    var currentState: GameState! {
        didSet {
            currentState.begin()
        }
    }
    
    init(gameMode: GameMode) {
        
        
    }
    
    func addMark(at position: GameboardPosition) {
        currentState.addMark(at: position)
    }
 
    func switchToNextState() {
        
    }
    
    func isCurrentStateCompleted() -> Bool {
        return self.currentState.isCompleted
    }
    
}
