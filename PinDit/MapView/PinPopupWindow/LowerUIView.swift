//
//  LowerUIView.swift
//  PinDit
//
//  Created by Zachary Johnson on 11/26/20.
//  Copyright © 2020 Zachary Johnson. All rights reserved.
//

import Foundation
import UIKit

class LowerUIView: UIView
{
    private var selfWidthAnchor:NSLayoutConstraint!
    private var selfHeightAnchor:NSLayoutConstraint!
    private var selfXAnchor:NSLayoutConstraint!
    private var selfYAnchor:NSLayoutConstraint!
    
    private var animator:UIViewPropertyAnimator!
    private var toggled:Bool = false
    
    @IBOutlet weak var buttonCreate: CreateUIButton!
    @IBOutlet weak var buttonCancel: CancelUIButton!
    
    override func didMoveToWindow()
    {
        if self.window != nil
        {
            translatesAutoresizingMaskIntoConstraints = false
            
            addSubview(buttonCreate)
            addSubview(buttonCancel)
            
            setMainViewAnchors(activeSetting: true, width: 0, height: 0, x: 0, y: 0, yAnchor: self.superview!.bottomAnchor, xAnchor: self.superview!.leftAnchor)
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
            setMainViewAnchors(activeSetting: true, width: 0.9, height: 0.2, x: -2, y: 0, yAnchor: self.superview!.bottomAnchor, xAnchor: self.superview!.centerXAnchor)
            toggleChildren()
            return
        }
        
        toggled = !toggled
        toggleChildren()
        setMainViewAnchors(activeSetting: false, width: 0, height: 0, x: 0, y: 0, yAnchor: self.superview!.bottomAnchor, xAnchor: self.superview!.centerXAnchor)
    }
    
    private func toggleChildren()
    {
        buttonCreate.toggleView()
        buttonCancel.toggleView()
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
            selfYAnchor = self.bottomAnchor.constraint(equalTo: yAnchor, constant: y)
            selfXAnchor = self.centerXAnchor.constraint(equalTo: xAnchor, constant: x)
            
            selfWidthAnchor.isActive = activeSetting
            selfHeightAnchor.isActive = activeSetting
            selfYAnchor.isActive = activeSetting
            selfXAnchor.isActive = activeSetting
        }else
        {
            selfYAnchor = self.centerYAnchor.constraint(equalTo: self.superview!.bottomAnchor, constant: y)
            selfXAnchor = self.centerXAnchor.constraint(equalTo: self.superview!.leftAnchor, constant: x)
            selfYAnchor.isActive = true
            selfXAnchor.isActive = true
        }
    }
}
