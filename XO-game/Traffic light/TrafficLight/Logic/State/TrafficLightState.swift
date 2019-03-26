//
//  TrafficLightState.swift
//  XO-game
//
//  Created by Dinar Ilalov on 20/03/2019.
//  Copyright © 2019 plasmon. All rights reserved.
//

import UIKit

typealias SwitchTrafficLightColor = () -> Void

protocol TrafficLightState {
    
    var timer: Timer? { get }
    var repeatCount: Int { get }
    var trafficLightView: TrafficLightView { get }
    var light: TrafficLightColor { get }
    
    var onEnd: SwitchTrafficLightColor { get set }
    
    func start()
    
}
