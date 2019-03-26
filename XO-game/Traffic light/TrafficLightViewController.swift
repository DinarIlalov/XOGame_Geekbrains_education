//
//  TrafficLightViewController.swift
//  XO-game
//
//  Created by Dinar Ilalov on 20/03/2019.
//  Copyright © 2019 plasmon. All rights reserved.
//

import UIKit

class TrafficLightViewController: UIViewController {

    @IBOutlet weak var trafficLightView: TrafficLightView!
    
    private lazy var trafficLightControl: TrafficLightControl = TrafficLightControl(trafficLightView: trafficLightView)
    
    override func viewDidLoad() {
        super.viewDidLoad()

        trafficLightControl.start()
        
    }
    
    @IBAction func backButtonDidTap(_ sender: UIBarButtonItem) {
        navigationController?.dismiss(animated: true, completion: nil)
    }

}
