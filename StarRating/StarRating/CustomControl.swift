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
    var zeroValue = 0
    
    var rateLabel: [UILabel] = []
    
    private let componentDimension: CGFloat = 40.0
    private let componentCount = 5
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
            
            addSubview(label)
            rateLabel.append(label)
        }
    }
    
    override var intrinsicContentSize: CGSize {
        let componentsWidth = CGFloat(componentCount) * componentDimension
        let componentsSpacing = CGFloat(componentCount + 1) * 8.0
        let width = componentsWidth + componentsSpacing
        return CGSize(width: width, height: componentDimension)
    }
    
    override func beginTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        
        updateValue(at: touch)
        return true
    }
    
    override func continueTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        let touchPoint = touch.location(in: self)
        if bounds.contains(touchPoint) {
            updateValue(at: touch)
            sendActions(for: .touchDragInside)
            
        } else {
            sendActions(for: .touchDragOutside)
            print("Touch drag outside")
        }
        
        return true
    }
    
    override func endTracking(_ touch: UITouch?, with event: UIEvent?) {
        
        guard let touch = touch else {return}
        let touchPoint = touch.location(in: self)
        
        if bounds.contains(touchPoint) {
            updateValue(at: touch)
            sendActions(for: .touchUpInside)
        } else {
            sendActions(for: .touchUpOutside)
        }
    }
    
    override func cancelTracking(with event: UIEvent?) {
        sendActions(for: .touchCancel)
    }
    
    func updateValue(at touch: UITouch) {
        
        let touchPoint = touch.location(in: self)
        
        for label in rateLabel {
            
            if label.frame.contains(touchPoint) {
                value = label.tag
                
                for index in 1...rateLabel.count {
                    switch index <= value {
                    case true:
                        rateLabel[index - 1].textColor = componentActiveColor
                    case false:
                        rateLabel[index - 1].textColor = componentInactiveColor
                    }
                }
                if value != zeroValue {
                    label.textColor = componentActiveColor
                    performFlare()
                    sendActions(for: .valueChanged)
                }
                zeroValue = value
            }
        }

    }

}

extension UIView {
    // "Flare view" animation sequence
    func performFlare() {
        func flare()   { transform = CGAffineTransform(scaleX: 1.6, y: 1.6) }
        func unflare() { transform = .identity }
        
        UIView.animate(withDuration: 0.3,
                       animations: { flare() },
                       completion: { _ in UIView.animate(withDuration: 0.1) { unflare() }})
    }
}
