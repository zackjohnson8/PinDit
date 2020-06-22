//
//  CustomCenterLocationButton.swift
//  MapUsage
//
//  Created by Zachary Johnson on 6/21/20.
//  Copyright © 2020 Zachary Johnson. All rights reserved.
//

import UIKit

class CustomCenterLocationButton: UIButton
{
    
    func initialize()
    {
        setupButton()
    }
    
    private func setupButton()
    {
        self.setImage(UIImage(systemName: "location.north.fill"), for: .normal)
        
        self.layer.cornerRadius = 24
        self.addTarget(self,
                       action: #selector(buttonPressed(sender:)),
                       for: .touchUpInside)
        self.isHidden = true
    }
    
    @objc private func buttonPressed(sender: UIButton)
    {
        UIButton.animate(withDuration: 0.1,
                         animations: { sender.transform = CGAffineTransform(scaleX: 0.75, y: 0.75)},
                         completion: { finish in UIButton.animate(withDuration: 0.1, animations: {sender.transform = CGAffineTransform.identity})
        })
    }
}
