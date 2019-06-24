//
//  CustomControl.swift
//  StarRating
//
//  Created by Enayatullah Naseri on 6/24/19.
//  Copyright © 2019 Enayatullah Naseri. All rights reserved.
//

import UIKit

class CustomControl: UIControl {
    
    var value = 1
    
    
    private let componentDimension: CGFloat = 40.0
    private let componentCount = 6
    private let componentActiveColor = UIColor.black
    private let componentInactiveColor = UIColor.gray

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        setup()
    }
    
    func setup() {
        
        for rate in 1...componentCount {
            let x = CGFloat(rate - 1)*(componentDimension + 8.0)
            let label = UILabel(frame: CGRect(x: x, y: 0.0, width: componentDimension, height: componentDimension))
            
            label.font = UIFont.boldSystemFont(ofSize: 32)
            label.tag = rate
            label.text = "☆"
            label.textAlignment = .center
            
            label.textColor = rate == 1 ? componentActiveColor : componentInactiveColor
        }
    }
    
    override var intrinsicContentSize: CGSize {
        let componentsWidth = CGFloat(componentCount) * componentDimension
        let componentsSpacing = CGFloat(componentCount + 1) * 8.0
        let width = componentsWidth + componentsSpacing
        return CGSize(width: width, height: componentDimension)
    }
    
    override func beginTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        
        
        return true
    }
    
    override func continueTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        
        
        return true
    }
    
    override func endTracking(_ touch: UITouch?, with event: UIEvent?) {
        
    }
    
    override func cancelTracking(with event: UIEvent?) {
        sendActions(for: .touchCancel)
    }
    
    func updateValue(at touch: UITouch) {
        
    }

}
