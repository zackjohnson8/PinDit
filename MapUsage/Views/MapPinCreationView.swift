//
//  MapPinCreationView.swift
//  MapUsage
//
//  Created by Zachary Johnson on 7/6/20.
//  Copyright © 2020 Zachary Johnson. All rights reserved.
//

import UIKit

class MapPinCreationView: UIView{
    
    @IBOutlet weak var upperView: UIView!
    @IBOutlet weak var lowerStackView: UIStackView!
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var descLabel: UILabel!
    @IBOutlet weak var descTextView: UITextView!
    
    private var selfWidthAnchor:NSLayoutConstraint!
    private var selfHeightAnchor:NSLayoutConstraint!
    private var selfXAnchor:NSLayoutConstraint!
    private var selfYAnchor:NSLayoutConstraint!
    private var animator:UIViewPropertyAnimator!
    
    override func didMoveToWindow() {
        if self.window != nil
        {
            translatesAutoresizingMaskIntoConstraints = false
            
            selfWidthAnchor = self.widthAnchor.constraint(equalToConstant: 0)
            selfHeightAnchor = self.heightAnchor.constraint(equalToConstant: 0)
            selfWidthAnchor.isActive = true
            selfHeightAnchor.isActive = true

//            selfXAnchor = self.centerXAnchor.constraint(equalTo: self.window!.leftAnchor)
//            selfYAnchor = self.centerYAnchor.constraint(equalTo: self.window!.bottomAnchor)
            selfXAnchor = self.centerXAnchor.constraint(equalTo: self.window!.centerXAnchor)
            selfYAnchor = self.centerYAnchor.constraint(equalTo: self.window!.centerYAnchor)
            selfXAnchor.isActive = true
            selfYAnchor.isActive = true
            
            self.layoutIfNeeded()
            
                        
        }else
        {
            // If for some reason this view gets removed from the superview
            selfWidthAnchor.isActive = false
            selfHeightAnchor.isActive = false
            selfXAnchor.isActive = false
            selfYAnchor.isActive = false
        }
    }
    
    public func toggleView()
    {
        
        selfWidthAnchor.isActive = false
        selfHeightAnchor.isActive = false
//        selfXAnchor.isActive = false
//        selfYAnchor.isActive = false
        
        selfWidthAnchor = self.widthAnchor.constraint(equalTo: self.window!.widthAnchor, multiplier: 0.6)
        selfHeightAnchor = self.heightAnchor.constraint(equalTo: self.window!.heightAnchor, multiplier: 0.2)
        selfWidthAnchor.isActive = true
        selfHeightAnchor.isActive = true

//        selfXAnchor = self.centerXAnchor.constraint(equalTo: self.window!.centerXAnchor)
//        selfYAnchor = self.centerYAnchor.constraint(equalTo: self.window!.centerYAnchor)
//        selfXAnchor.isActive = true
//        selfYAnchor.isActive = true

    }
    
    public func saveData()
    {
        
    }
    
    private func viewToggleAnimation()
    {
        selfWidthAnchor.constant += 100
        selfHeightAnchor.constant += 100
        selfYAnchor.constant -= 400
    }
    
}
