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
    private var propertyAnimator:UIViewPropertyAnimator!
    
    /*
     Notes: When this object is made, I want to animate the screen appearing.
        Task:
            -> Animate the open screen. This will probably require the constraints initalized during appearing.
     */
    
    /*
     Called when this UIView is added or removed from superview
     Default implementation does nothing
    */
    override func didMoveToWindow() {
        if self.window != nil
        {
            translatesAutoresizingMaskIntoConstraints = false
            
            selfWidthAnchor = self.widthAnchor.constraint(equalToConstant: 0)
            selfHeightAnchor = self.heightAnchor.constraint(equalToConstant: 0)
            selfWidthAnchor.isActive = true
            selfHeightAnchor.isActive = true
            
            self.centerYAnchor.constraint(equalTo: self.window!.bottomAnchor).isActive = true
            self.centerXAnchor.constraint(equalTo: self.window!.centerXAnchor).isActive = true
            
            propertyAnimator = UIViewPropertyAnimator.init(duration: 1.0, curve: .linear, animations: viewToggleAnimation)
            
        }else
        {
            // If for some reason this view gets removed from the superview
            selfWidthAnchor.isActive = false
            selfHeightAnchor.isActive = false
        }
    }
    
    public func toggleView()
    {
        
    }
    
    private func viewToggleAnimation()
    {
        selfWidthAnchor.isActive = false
        selfHeightAnchor.isActive = false
        selfWidthAnchor = self.widthAnchor.constraint(equalTo: self.window!.widthAnchor, multiplier: 0.6)
        selfWidthAnchor = self.heightAnchor.constraint(equalTo: self.window!.widthAnchor, multiplier: 0.6)
        selfWidthAnchor.isActive = true
        
    }
    
    private func setAllAnchors(_ anchorSetting: Bool)
    {
        for anchor in self.constraints
        {
            anchor.isActive = false
        }
    }
    
}
