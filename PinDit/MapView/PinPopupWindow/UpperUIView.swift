//
//  UpperUIView.swift
//  PinDit
//
//  Created by Zachary Johnson on 11/26/20.
//  Copyright © 2020 Zachary Johnson. All rights reserved.
//

import Foundation
import UIKit

class UpperUIView: UIView
{
    private var selfWidthAnchor:NSLayoutConstraint!
    private var selfHeightAnchor:NSLayoutConstraint!
    private var selfXAnchor:NSLayoutConstraint!
    private var selfYAnchor:NSLayoutConstraint!
    
    private var animator:UIViewPropertyAnimator!
    private var toggled:Bool = false
    
    @IBOutlet weak var titleUITextField: TitleUITextField!
    @IBOutlet weak var descriptionUITextField: DescriptionUITextView!
    
    @IBOutlet weak var titleLabel: TitleUILabel!
    @IBOutlet weak var descriptionLabel: DescriptionUILabel!
    
    override func didMoveToWindow()
    {
        if self.window != nil
        {
            translatesAutoresizingMaskIntoConstraints = false
            
            setMainViewAnchors(activeSetting: true, width: 0, height: 0, x: 0, y: 0, yAnchor: self.superview!.topAnchor, xAnchor: self.superview!.leftAnchor)
            
            self.addSubview(titleUITextField)
            self.addSubview(titleLabel)
            self.addSubview(descriptionUITextField)
            self.addSubview(descriptionLabel)
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
            setMainViewAnchors(activeSetting: true, width: 1.0, height: 0.8, x: 0, y: 0, yAnchor: self.superview!.topAnchor, xAnchor: self.superview!.centerXAnchor)
            toggleChildren()
            return
        }
        
        toggled = !toggled
        toggleChildren()
        setMainViewAnchors(activeSetting: false, width: 0, height: 0, x: 0, y: 0, yAnchor: self.superview!.topAnchor, xAnchor: self.superview!.centerXAnchor)
    }
    
    private func toggleChildren()
    {
        titleLabel.toggleView()
        titleUITextField.toggleView(anchorTo: titleLabel)
        descriptionLabel.toggleView(anchorTo: titleUITextField)
        descriptionUITextField.toggleView(anchorTo: descriptionLabel)
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
            selfXAnchor = self.centerXAnchor.constraint(equalTo: xAnchor, constant: x)
            
            selfWidthAnchor.isActive = activeSetting
            selfHeightAnchor.isActive = activeSetting
            selfYAnchor.isActive = activeSetting
            selfXAnchor.isActive = activeSetting
        }else
        {
            selfYAnchor = self.centerYAnchor.constraint(equalTo: self.superview!.topAnchor, constant: y)
            selfXAnchor = self.centerXAnchor.constraint(equalTo: self.superview!.leftAnchor, constant: x)
            selfYAnchor.isActive = true
            selfXAnchor.isActive = true
        }
    }
}
