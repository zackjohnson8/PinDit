//
//  CustomExpandingButton.swift
//  MapUsage
//
//  Created by Zachary Johnson on 6/21/20.
//  Copyright © 2020 Zachary Johnson. All rights reserved.
//

import UIKit

class CustomExpandingButton: UIButton
{
    var containedButtons = [CustomButton]()
    
    func initialize()
    {
        setupButton()
    }
    
    private func setupButton()
    {
        self.setImage(UIImage(systemName: "plus"), for: .normal)
        self.layer.cornerRadius = 24
        self.addTarget(self,
                       action: #selector(buttonPressed(sender:)),
                       for: .touchUpInside)
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    @objc private func buttonPressed(sender: UIButton)
    {
        for containtedButton in containedButtons
        {
            containtedButton.isHidden = !containtedButton.isHidden
        }
        
        UIButton.animate(withDuration: 0.15,
                         animations: { sender.transform  = CGAffineTransform.init(rotationAngle: CGFloat(90))},
                         completion: {
                            finish in UIButton.animate(
                                withDuration: 0.15,
                                animations: {
                                    sender.transform = CGAffineTransform.identity
                            })
        })
    }
    
    // Append the containing buttons for animation to a array
    public func addContainingButton(button: inout CustomButton)
    {
        button.isHidden = true
        containedButtons.append(button)
    }
    
}
