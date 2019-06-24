//
//  ViewController.swift
//  StarRating
//
//  Created by Enayatullah Naseri on 6/24/19.
//  Copyright © 2019 Enayatullah Naseri. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func updateRating(_ ratingControl: CustomControl) {
        
        if ratingControl.value == 1 {
            title = "User Rating: \(ratingControl) stars"
        } else {
            title = "User Rating: \(ratingControl) stars"
        }
    }
    
}

