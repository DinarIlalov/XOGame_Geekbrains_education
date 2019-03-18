//
//  Gameboard.swift
//  XO-game
//
//  Created by Evgeny Kireev on 27/02/2019.
//  Copyright © 2019 plasmon. All rights reserved.
//

import Foundation

public final class Gameboard {
    
    // MARK: - Properties
    
    private lazy var positions: [[Player?]] = initialPositions()
    
    // MARK: - public
    
    public func setPlayer(_ player: Player, at position: GameboardPosition) {
        positions[position.column][position.row] = player
    }
    
    public func clear() {
        self.positions = initialPositions()
    }
    
    public func contains(player: Player, at positions: [GameboardPosition]) -> Bool {
        for position in positions {
            guard contains(player: player, at: position) else {
                return false
            }
        }
        return true
    }
    
    public func contains(player: Player, at position: GameboardPosition) -> Bool {
        let (column, row) = (position.column, position.row)
        return positions[column][row] == player
    }
    
    public func containsAnyPlayer(at position: GameboardPosition) -> Bool {
        let (column, row) = (position.column, position.row)
        return positions[column][row] != nil
    }
    
    public func areAllPositionsFullfilled() -> Bool {
        return emptyPositions().count == 0
    }
    
    
    public func randomEmptyPosition() -> GameboardPosition? {
        return emptyPositions().randomElement()
    }
    
    // MARK: - Private
    
    private func emptyPositions() -> [GameboardPosition] {
        var emptyPositions: [GameboardPosition] = []
        
        for (column, array) in positions.enumerated() {
            for (row, player) in array.enumerated() {
                if player == nil {
                    emptyPositions.append(GameboardPosition(column: column, row: row))
                }
            }
        }
        return emptyPositions
    }
    
    private func initialPositions() -> [[Player?]] {
        var positions: [[Player?]] = []
        for _ in 0 ..< GameboardSize.columns {
            let rows = Array<Player?>(repeating: nil, count: GameboardSize.rows)
            positions.append(rows)
        }
        return positions
    }
}
