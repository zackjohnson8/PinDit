//
//  MapPinCreationView.swift
//  MapUsage
//
//  Created by Zachary Johnson on 7/6/20.
//  Copyright © 2020 Zachary Johnson. All rights reserved.
//

import UIKit

class MapPinCreationView: UIView{
    
    private var selfWidthAnchor:NSLayoutConstraint!
    private var selfHeightAnchor:NSLayoutConstraint!
    private var selfXAnchor:NSLayoutConstraint!
    private var selfYAnchor:NSLayoutConstraint!
    
    @IBOutlet weak var upperUIView: UpperUIView!
    @IBOutlet weak var lowerUIView: LowerUIView!
    
    private var animator:UIViewPropertyAnimator!
    private var toggled:Bool = false
    
    override func didMoveToWindow() {
        
        if self.window != nil
        {
            translatesAutoresizingMaskIntoConstraints = false
            
            layer.borderWidth = 1.0
            layer.borderColor = UIColor(red: 0.8, green: 0.8, blue: 0.8, alpha: 1).cgColor
            layer.cornerRadius = 3.0
            
            setMainViewAnchors(activeSetting: true, width: 0, height: 0, x: 0, y: 0, yAnchor: self.window!.centerYAnchor, xAnchor: self.window!.leftAnchor)
            
            self.addSubview(lowerUIView)
            self.addSubview(upperUIView)
            
            
        }else
        {
            // If for some reason this view gets removed from the superview
            setMainViewAnchors(activeSetting: false, width: 0, height: 0, x: 0, y: 0, yAnchor: self.window!.centerYAnchor, xAnchor: self.window!.leftAnchor)
        }
    }
    
    public func toggleView()
    {
        if(!toggled)
        {
            toggled = !toggled
            setMainViewAnchors(activeSetting: true, width: 0.6, height: 0.3, x: 0, y: 0, yAnchor: self.window!.centerYAnchor, xAnchor: self.window!.centerXAnchor)
            toggleChildren()
            return
        }
        
        toggled = !toggled
        toggleChildren()
        setMainViewAnchors(activeSetting: false, width: 0, height: 0, x: 0, y: 0, yAnchor: self.window!.centerYAnchor, xAnchor: self.window!.leftAnchor)
        
    }
    
    public func saveData()
    {
        
    }
    
    private func toggleChildren()
    {
        upperUIView.toggleView()
        lowerUIView.toggleView()
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
            selfWidthAnchor = self.widthAnchor.constraint(equalTo: self.window!.widthAnchor, multiplier: width)
            selfHeightAnchor = self.heightAnchor.constraint(equalTo: self.window!.heightAnchor, multiplier: height)
            selfYAnchor = self.centerYAnchor.constraint(equalTo: yAnchor, constant: y)
            selfXAnchor = self.centerXAnchor.constraint(equalTo: xAnchor, constant: x)
            
            selfWidthAnchor.isActive = activeSetting
            selfHeightAnchor.isActive = activeSetting
            selfYAnchor.isActive = activeSetting
            selfXAnchor.isActive = activeSetting
        }else
        {
            selfYAnchor = self.centerYAnchor.constraint(equalTo: self.window!.centerYAnchor, constant: y)
            selfXAnchor = self.centerXAnchor.constraint(equalTo: self.window!.leftAnchor, constant: x)
            selfYAnchor.isActive = true
            selfXAnchor.isActive = true
        }
    }
}
