//
//  TrafficLightView.swift
//  XO-game
//
//  Created by Dinar Ilalov on 20/03/2019.
//  Copyright © 2019 plasmon. All rights reserved.
//

import UIKit

class TrafficLightView: XibView {

    @IBOutlet weak var greenLightView: UIView!
    @IBOutlet weak var yellowLightView: UIView!
    @IBOutlet weak var redLightView: UIView!
    
    @IBOutlet weak var greenLightTimerLabel: UILabel!
    @IBOutlet weak var yellowLightTimerLabel: UILabel!
    @IBOutlet weak var redLightTimerLabel: UILabel!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        setupViews()
    }
    
    private func setupViews() {
        
        greenLightView.layer.cornerRadius = greenLightView.frame.width/2
        greenLightView.layer.borderWidth = 2
        greenLightView.layer.borderColor = UIColor.green.cgColor
        
        yellowLightView.layer.cornerRadius = yellowLightView.frame.width/2
        yellowLightView.layer.borderWidth = 2
        yellowLightView.layer.borderColor = UIColor.yellow.cgColor
        
        redLightView.layer.cornerRadius = redLightView.frame.width/2
        redLightView.layer.borderWidth = 2
        redLightView.layer.borderColor = UIColor.red.cgColor
        
    }
    
    func swithColorTo(_ trafficLightColor: TrafficLightColor) {
        
        switch trafficLightColor {
        case .green:
            turnOn(.green)
            turnOff(.yellow)
            turnOff(.red)
        case .yellow:
            turnOff(.green)
            turnOn(.yellow)
            turnOff(.red)
        case .red:
            turnOff(.green)
            turnOff(.yellow)
            turnOn(.red)
        }
        
    }
    
    private func turnOn(_ trafficLightColor: TrafficLightColor) {
        
        switch trafficLightColor {
        case .green:
            greenLightView.backgroundColor = .green
            greenLightTimerLabel.isHidden = false
        case .yellow:
            yellowLightView.backgroundColor = .yellow
            yellowLightTimerLabel.isHidden = false
        case .red:
            redLightView.backgroundColor = .red
            redLightTimerLabel.isHidden = false
        }
    }
    
    private func turnOff(_ trafficLightColor: TrafficLightColor) {
        
        switch trafficLightColor {
        case .green:
            greenLightView.backgroundColor = .clear
            greenLightTimerLabel.isHidden = true
        case .yellow:
            yellowLightView.backgroundColor = .clear
            yellowLightTimerLabel.isHidden = true
        case .red:
            redLightView.backgroundColor = .clear
            redLightTimerLabel.isHidden = true
        }
    }
    
}

enum TrafficLightColor {
    case green, yellow, red
}
