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
    }
    
    @objc private func buttonPressed(sender: UIButton)
    {
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
    
    //TODO(zack): create a system to add new buttons to open
}
