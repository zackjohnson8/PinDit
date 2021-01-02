//
//  TitleUILabel.swift
//  PinDit
//
//  Created by Zachary Johnson on 11/26/20.
//  Copyright © 2020 Zachary Johnson. All rights reserved.
//

import Foundation
import UIKit

class TitleUILabel: UILabel
{
    private var selfWidthAnchor:NSLayoutConstraint!
    private var selfHeightAnchor:NSLayoutConstraint!
    private var selfXAnchor:NSLayoutConstraint!
    private var selfYAnchor:NSLayoutConstraint!
    
    private var animator:UIViewPropertyAnimator!
    private var toggled:Bool = false
    
    override func didMoveToWindow()
    {
        if self.window != nil
        {
            translatesAutoresizingMaskIntoConstraints = false
            
            setMainViewAnchors(activeSetting: true, width: 0, height: 0, x: 0, y: 0, yAnchor: self.superview!.topAnchor, xAnchor: self.superview!.leftAnchor)
        }else
        {
            toggled = false
        }
    }
    
    public func toggleView()
    {
        if(!toggled)
        {
            toggled = !toggled
            setMainViewAnchors(activeSetting: true, width: 0.2, height: 0.1, x: 10, y: 10, yAnchor: self.superview!.topAnchor, xAnchor: self.superview!.leftAnchor)
            return
        }
        
        toggled = !toggled
        setMainViewAnchors(activeSetting: true, width: 0, height: 0, x: 0, y: 0, yAnchor: self.superview!.topAnchor, xAnchor: self.superview!.leftAnchor)
    }
    
    private func setMainViewAnchors(activeSetting: Bool, width: CGFloat, height: CGFloat, x: CGFloat, y: CGFloat, yAnchor: NSLayoutYAxisAnchor, xAnchor: NSLayoutXAxisAnchor)
    {
        if selfWidthAnchor != nil {
            selfWidthAnchor.isActive = false
            selfHeightAnchor.isActive = false
            selfYAnchor.isActive = false
            selfXAnchor.isActive = false
        }
        
        if(activeSetting)
        {
            selfWidthAnchor = self.widthAnchor.constraint(equalTo: self.superview!.widthAnchor, multiplier: width)
            selfHeightAnchor = self.heightAnchor.constraint(equalTo: self.superview!.heightAnchor, multiplier: height)
            selfYAnchor = self.topAnchor.constraint(equalTo: yAnchor, constant: y)
            selfXAnchor = self.leftAnchor.constraint(equalTo: xAnchor, constant: x)
            
            selfWidthAnchor.isActive = activeSetting
            selfHeightAnchor.isActive = activeSetting
            selfYAnchor.isActive = activeSetting
            selfXAnchor.isActive = activeSetting
        }else
        {
            selfYAnchor = self.topAnchor.constraint(equalTo: self.superview!.topAnchor, constant: y)
            selfXAnchor = self.leftAnchor.constraint(equalTo: self.superview!.leftAnchor, constant: x)
            selfYAnchor.isActive = true
            selfXAnchor.isActive = true
        }
    }
    
}
