//
//  GreenTrafficLightState.swift
//  XO-game
//
//  Created by Dinar Ilalov on 20/03/2019.
//  Copyright © 2019 plasmon. All rights reserved.
//

import UIKit

class GreenTrafficLightState: TrafficLightState {
    internal var timer: Timer?
    internal let trafficLightView: TrafficLightView
    internal var repeatCount: Int = 5
    var onEnd: SwitchTrafficLightColor
    
    private let timerLabel: UILabel
    let light: TrafficLightColor = .green
    
    init(trafficLightView: TrafficLightView, onEnd: @escaping SwitchTrafficLightColor) {
        self.trafficLightView = trafficLightView
        self.onEnd = onEnd
        self.trafficLightView.swithColorTo(light)
        
        self.timerLabel = trafficLightView.greenLightTimerLabel
        self.timerLabel.text = "\(repeatCount)"
    }
    
    func start() {
        
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] timer in
            guard let `self` = self else {
                timer.invalidate()
                return
            }
            
            self.repeatCount -= 1
            self.timerLabel.text = "\(self.repeatCount)"

            if self.repeatCount <= 0 {
                self.onEnd()
                timer.invalidate()
            }
        }
    }
    
}
