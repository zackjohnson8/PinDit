//
//  TitleUITextField.swift
//  MapUsage
//
//  Created by Zachary Johnson on 11/26/20.
//  Copyright © 2020 Zachary Johnson. All rights reserved.
//

import Foundation
import UIKit

class TitleUITextField: UITextField
{
    private var selfWidthAnchor:NSLayoutConstraint!
    private var selfHeightAnchor:NSLayoutConstraint!
    private var selfXAnchor:NSLayoutConstraint!
    private var selfYAnchor:NSLayoutConstraint!
    
    private var animator:UIViewPropertyAnimator!
    private var toggled:Bool = false
    
    override func didMoveToWindow()
    {
        
        self.delegate = self
        
        if self.window != nil
        {
            translatesAutoresizingMaskIntoConstraints = false
            
            let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 4, height: 0))
            self.leftView = paddingView
            self.leftViewMode = UITextField.ViewMode.always
            
            layer.borderWidth = 1.0
            layer.borderColor = UIColor(red: 0.8, green: 0.8, blue: 0.8, alpha: 1).cgColor
            layer.cornerRadius = 3.0
            
            setMainViewAnchors(activeSetting: true, width: 0, height: 0, yAnchor: self.superview!.topAnchor, xAnchor: self.superview!.leftAnchor)
        }else
        {
            toggled = false
            reset()
        }
        
    }
    
    
    
    
    public func toggleView(anchorTo: TitleUILabel)
    {
        if(!toggled)
        {
            toggled = !toggled
            setMainViewAnchors(activeSetting: true, width: 0.9, height: 0.2, yAnchor: anchorTo.centerYAnchor, xAnchor: anchorTo.leftAnchor)
            return
        }
        
        toggled = !toggled
        setMainViewAnchors(activeSetting: true, width: 0, height: 0, yAnchor: self.superview!.topAnchor, xAnchor: self.superview!.leftAnchor)
    }
    
    private func setMainViewAnchors(activeSetting: Bool, width: CGFloat, height: CGFloat, yAnchor: NSLayoutYAxisAnchor, xAnchor: NSLayoutXAxisAnchor)
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
    
    public func reset()
    {
        layer.borderColor = UIColor(red: 0.8, green: 0.8, blue: 0.8, alpha: 1).cgColor
        self.text = ""
    }
    
    
    @IBAction func editingDidBegin(_ sender: Any) {
        print("Editing")
    }
    
}

// Keyboard functionality
extension TitleUITextField: UITextFieldDelegate
{
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        // Might want to add the coloring changes if they didn't add anything into title
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
    }
    
}
