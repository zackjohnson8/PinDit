//
//  WarningUIImageView.swift
//  MapUsage
//
//  Created by Zachary Johnson on 11/26/20.
//  Copyright © 2020 Zachary Johnson. All rights reserved.
//

import Foundation
import UIKit

class WarningUIImageView: UIImageView{
    
    private var selfWidthAnchor:NSLayoutConstraint!
    private var selfHeightAnchor:NSLayoutConstraint!
    private var selfXAnchor:NSLayoutConstraint!
    private var selfYAnchor:NSLayoutConstraint!
    
    private var animator:UIViewPropertyAnimator!
    
    override func didMoveToWindow()
    {
        translatesAutoresizingMaskIntoConstraints = false
        
        setMainViewAnchors(activeSetting: true, yAnchor: self.superview!.topAnchor, xAnchor: self.superview!.rightAnchor)
    }
    
    func toggleView(anchorTo: UITextField, toggle: Bool)
    {
        if(toggle)
        {
            setMainViewAnchors(activeSetting: true, yAnchor: anchorTo.topAnchor, xAnchor: anchorTo.rightAnchor)
            return
        }
        
        setMainViewAnchors(activeSetting: true, yAnchor: self.superview!.topAnchor, xAnchor: self.superview!.rightAnchor)
    }
    
    private func setMainViewAnchors(activeSetting: Bool, yAnchor: NSLayoutYAxisAnchor, xAnchor: NSLayoutXAxisAnchor)
    {
        if selfWidthAnchor != nil {
            selfWidthAnchor.isActive = false
            selfHeightAnchor.isActive = false
            selfYAnchor.isActive = false
            selfXAnchor.isActive = false
        }
        
        if(activeSetting)
        {
            selfWidthAnchor = self.widthAnchor.constraint(equalTo: self.superview!.heightAnchor)
            selfHeightAnchor = self.heightAnchor.constraint(equalTo: self.superview!.heightAnchor)
            selfYAnchor = self.topAnchor.constraint(equalTo: yAnchor)
            selfXAnchor = self.rightAnchor.constraint(equalTo: xAnchor)
            
            selfWidthAnchor.isActive = activeSetting
            selfHeightAnchor.isActive = activeSetting
            selfYAnchor.isActive = activeSetting
            selfXAnchor.isActive = activeSetting
        }else
        {
            selfYAnchor = self.topAnchor.constraint(equalTo: self.superview!.topAnchor)
            selfXAnchor = self.rightAnchor.constraint(equalTo: self.superview!.leftAnchor)
            selfYAnchor.isActive = true
            selfXAnchor.isActive = true
        }
    }
}
