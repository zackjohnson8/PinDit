//
//  DescriptionUITextView.swift
//  MapUsage
//
//  Created by Zachary Johnson on 11/26/20.
//  Copyright © 2020 Zachary Johnson. All rights reserved.
//

import Foundation
import UIKit

class DescriptionUITextView: UITextView
{
    private var selfWidthAnchor:NSLayoutConstraint!
    private var selfHeightAnchor:NSLayoutConstraint!
    private var selfXAnchor:NSLayoutConstraint!
    private var selfYAnchor:NSLayoutConstraint!
    
    private var animator:UIViewPropertyAnimator!
    private var toggled:Bool = false
    
    override func didMoveToWindow()
    {
        translatesAutoresizingMaskIntoConstraints = false
        
        layer.borderWidth = 1.0
        layer.borderColor = UIColor(red: 0.8, green: 0.8, blue: 0.8, alpha: 1).cgColor
        layer.cornerRadius = 3.0
        
        setMainViewAnchors(activeSetting: true, width: 0, yAnchor: self.superview!.topAnchor, xAnchor: self.superview!.leftAnchor)
    }
    
    public func toggleView(anchorTo: DescriptionUILabel)
    {
        if(!toggled)
        {
            toggled = !toggled
            setMainViewAnchors(activeSetting: true, width: 0.9, yAnchor: anchorTo.centerYAnchor, xAnchor: anchorTo.leftAnchor)
            return
        }
        
        toggled = !toggled
        setMainViewAnchors(activeSetting: true, width: 0, yAnchor: self.superview!.topAnchor, xAnchor: self.superview!.leftAnchor)
    }
    
    private func setMainViewAnchors(activeSetting: Bool, width: CGFloat, yAnchor: NSLayoutYAxisAnchor, xAnchor: NSLayoutXAxisAnchor)
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
            selfHeightAnchor = self.bottomAnchor.constraint(equalTo: self.superview!.bottomAnchor)
            selfYAnchor = self.topAnchor.constraint(equalTo: yAnchor)
            selfXAnchor = self.leftAnchor.constraint(equalTo: xAnchor)
            
            selfWidthAnchor.isActive = activeSetting
            selfHeightAnchor.isActive = activeSetting
            selfYAnchor.isActive = activeSetting
            selfXAnchor.isActive = activeSetting
        }else
        {
            selfYAnchor = self.topAnchor.constraint(equalTo: self.superview!.topAnchor)
            selfXAnchor = self.leftAnchor.constraint(equalTo: self.superview!.leftAnchor)
            selfYAnchor.isActive = true
            selfXAnchor.isActive = true
        }
    }
}
