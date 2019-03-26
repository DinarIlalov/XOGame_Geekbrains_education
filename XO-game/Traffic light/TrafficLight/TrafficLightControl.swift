//
//  TrafficLightControl.swift
//  XO-game
//
//  Created by Dinar Ilalov on 20/03/2019.
//  Copyright © 2019 plasmon. All rights reserved.
//

import Foundation

class TrafficLightControl {
    
    let trafficLightView: TrafficLightView
    private let switchOrder: [Int] = [1,2,3,2]
    
    var currentState: TrafficLightState? {
        willSet {
            previousLightColor = currentState?.light ?? .yellow
        }
        didSet {
            currentState?.start()
        }
    }
    private var previousLightColor: TrafficLightColor = .yellow
    
    private lazy var onStateEnd: SwitchTrafficLightColor = { [weak self] in
        self?.startNext()
    }
    
    init(trafficLightView: TrafficLightView) {
        self.trafficLightView = trafficLightView
    }
    
    func start() {
        
        startNext()
    }
    
    func startNext() {
        if currentState?.light == .green {
            currentState = YellowTrafficLightState(trafficLightView: trafficLightView, onEnd: onStateEnd)
        } else if currentState?.light == .yellow {
            if previousLightColor == .red {
                currentState = GreenTrafficLightState(trafficLightView: trafficLightView, onEnd: onStateEnd)
            } else {
                currentState = RedTrafficLightState(trafficLightView: trafficLightView, onEnd: onStateEnd)
            }
        } else if currentState?.light == .red {
            currentState = YellowTrafficLightState(trafficLightView: trafficLightView, onEnd: onStateEnd)
        } else {
            currentState = GreenTrafficLightState(trafficLightView: trafficLightView, onEnd: onStateEnd)
        }
    }
}
