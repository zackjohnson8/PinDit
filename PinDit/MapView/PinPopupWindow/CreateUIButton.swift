//
//  CreateUIButton.swift
//  PinDit
//
//  Created by Zachary Johnson on 11/27/20.
//  Copyright © 2020 Zachary Johnson. All rights reserved.
//

import Foundation
import UIKit

class CreateUIButton: UIButton
{
    private var selfWidthAnchor:NSLayoutConstraint!
    private var selfHeightAnchor:NSLayoutConstraint!
    private var selfXAnchor:NSLayoutConstraint!
    private var selfYAnchor:NSLayoutConstraint!
    
    private var animator:UIViewPropertyAnimator!
    private var toggled:Bool = false
    
    @IBOutlet weak var descriptionUITextField: DescriptionUITextView!
    @IBOutlet weak var titleUITextView: TitleUITextField!
    @IBOutlet weak var superParentView: MapViewController!
    @IBOutlet weak var mapView: CustomMap!
    
    override func didMoveToWindow()
    {
        if self.window != nil
        {
            translatesAutoresizingMaskIntoConstraints = false
            
            layer.borderWidth = 1.0
            layer.borderColor = UIColor(red: 0.8, green: 0.8, blue: 0.8, alpha: 1).cgColor
            layer.cornerRadius = 3.0
            
            self.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
            
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
            setMainViewAnchors(activeSetting: true, width: 0.4, height: 0.8, x: 0, y: 0, yAnchor: self.superview!.centerYAnchor, xAnchor: self.superview!.leftAnchor)
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
            selfYAnchor = self.centerYAnchor.constraint(equalTo: yAnchor, constant: y)
            selfXAnchor = self.leftAnchor.constraint(equalTo: xAnchor, constant: x)
            
            selfWidthAnchor.isActive = activeSetting
            selfHeightAnchor.isActive = activeSetting
            selfYAnchor.isActive = activeSetting
            selfXAnchor.isActive = activeSetting
        }else
        {
            selfYAnchor = self.centerYAnchor.constraint(equalTo: yAnchor, constant: y)
            selfXAnchor = self.leftAnchor.constraint(equalTo: xAnchor, constant: x)
            selfYAnchor.isActive = true
            selfXAnchor.isActive = true
        }
    }

    @IBAction func buttonTapped(_ sender: UIButton) {
        // Description is no longer necessary
        if titleUITextView.text!.isEmpty
        {
            // Change the boarder to red and display the warning image
            titleUITextView.layer.borderColor = UIColor.systemRed.cgColor
            return
        }
        
        titleUITextView.layer.borderColor = UIColor(red: 0.8, green: 0.8, blue: 0.8, alpha: 1).cgColor
        superParentView.pinLocation()
        
        mapView.pinUserLocationWithSavingToPersistance(title: titleUITextView.text!, description: descriptionUITextField.text)
        
        clearTitleAndDescription()
        
        titleUITextView.resignFirstResponder()
        descriptionUITextField.resignFirstResponder()
        
    }
    
    private func clearTitleAndDescription()
    {
        titleUITextView.text = ""
        descriptionUITextField.text = ""
    }
}
