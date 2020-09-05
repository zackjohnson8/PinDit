//
//  PinPopupWindow.swift
//  MapUsage
//
//  Created by Zachary Johnson on 7/6/20.
//  Copyright © 2020 Zachary Johnson. All rights reserved.
//

import UIKit

class PinPopupWindow: UIView {
    
    public func initalize(superView: UIViewController, screenWidth: CGFloat, screenHeight: CGFloat)
    {
        
        self.translatesAutoresizingMaskIntoConstraints = false
        let windowHeight = screenHeight
        let windowWidth = screenWidth

        // Main PopupWindow UIView
        self.widthAnchor.constraint(equalTo: superView.view.widthAnchor, constant: -(windowWidth * 0.3)).isActive = true
        self.heightAnchor.constraint(equalTo: superView.view.heightAnchor, constant: -(windowHeight * 0.6)).isActive = true
        self.centerXAnchor.constraint(equalTo: superView.view.centerXAnchor).isActive = true
        self.centerYAnchor.constraint(equalTo: superView.view.centerYAnchor, constant: -(windowHeight * 0.1)).isActive = true
        self.layer.cornerRadius = 10
        self.layer.masksToBounds = true

        // Title Label 0
        let titleLabel = GetUIViewOfTag(self.subviews, 0)
        titleLabel?.translatesAutoresizingMaskIntoConstraints = false
        titleLabel?.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 20).isActive = true
        titleLabel?.topAnchor.constraint(equalTo: self.topAnchor, constant: 10).isActive = true
        titleLabel?.widthAnchor.constraint(equalToConstant: 36).isActive = true


        // Text Field 1
        let titleTextField: UITextField = GetUIViewOfTag(self.subviews, 1) as! UITextField
        titleTextField.translatesAutoresizingMaskIntoConstraints = false
        titleTextField.topAnchor.constraint(equalTo: titleLabel!.centerYAnchor, constant: 0).isActive = true
        titleTextField.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10).isActive = true
        titleTextField.widthAnchor.constraint(equalTo: self.widthAnchor, constant: -20).isActive = true
        titleTextField.heightAnchor.constraint(equalToConstant: 30).isActive = true
        titleTextField.layer.cornerRadius = 6
        titleTextField.layer.masksToBounds = true
        titleTextField.layer.borderColor = UIColor.systemGray4.cgColor
        titleTextField.layer.borderWidth = 0.8


        // Description Label 2
        let discLabel = GetUIViewOfTag(self.subviews, 2)
        discLabel?.translatesAutoresizingMaskIntoConstraints = false
        discLabel?.topAnchor.constraint(equalTo: titleTextField.bottomAnchor, constant: 15).isActive = true
        discLabel?.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 20).isActive = true
        discLabel?.widthAnchor.constraint(equalToConstant: 82).isActive = true


        // Description Text View Multiline 3
        let descTextView = GetUIViewOfTag(self.subviews, 3) as! UITextView
        descTextView.translatesAutoresizingMaskIntoConstraints = false
        descTextView.topAnchor.constraint(equalTo: discLabel!.centerYAnchor, constant: 0).isActive = true
        descTextView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10).isActive = true
        descTextView.widthAnchor.constraint(equalTo: self.widthAnchor, constant: -20).isActive = true
        descTextView.heightAnchor.constraint(equalTo: superView.view.heightAnchor, constant: -(windowHeight * 0.8)).isActive = true
        descTextView.layer.cornerRadius = 6
        descTextView.layer.masksToBounds = true
        descTextView.layer.borderWidth = 0.8
        descTextView.layer.borderColor = UIColor.systemGray4.cgColor


        // Left Button Accept Button 4
        let acceptButton = GetUIViewOfTag(self.subviews, 4) as! UIButton
        acceptButton.translatesAutoresizingMaskIntoConstraints = false
        acceptButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 1).isActive = true
        acceptButton.leftAnchor.constraint(equalTo: self.leftAnchor, constant: -1).isActive = true
        acceptButton.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.51).isActive = true
        acceptButton.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.15).isActive = true
        acceptButton.layer.borderWidth = 0.8
        acceptButton.layer.borderColor = UIColor.systemGray4.cgColor
        //acceptButton.addTarget(self, action: #selector(acceptButtonPressed(sender:)), for: .touchUpInside)


        // Right Button Cancel Button 5
        let cancelButton = GetUIViewOfTag(self.subviews, 5) as! UIButton
        //cancelButton.addTarget(self, action: #selector(cancelButtonPressed(sender:)), for: .touchUpInside)
        cancelButton.translatesAutoresizingMaskIntoConstraints = false
        cancelButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 1).isActive = true
        cancelButton.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 1).isActive = true
        cancelButton.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.51).isActive = true
        cancelButton.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.15).isActive = true
        cancelButton.layer.borderWidth = 0.8
        cancelButton.layer.borderColor = UIColor.systemGray4.cgColor
        


        // Exclamation marks for warning user that title text view is empty
        let warningForTitleField = GetUIViewOfTag(self.subviews, 6) as! UIImageView
        warningForTitleField.translatesAutoresizingMaskIntoConstraints = false
        warningForTitleField.rightAnchor.constraint(equalTo: titleTextField.rightAnchor, constant: -2).isActive = true
        warningForTitleField.centerYAnchor.constraint(equalTo: titleTextField.centerYAnchor).isActive = true
        warningForTitleField.heightAnchor.constraint(equalTo: titleTextField.heightAnchor, multiplier: 0.8).isActive = true
        warningForTitleField.widthAnchor.constraint(equalTo: titleTextField.heightAnchor, multiplier: 0.8).isActive = true
        warningForTitleField.isHidden = true


        // Exclamation marks for warning user that description text view is empty
        let warningForDescView = GetUIViewOfTag(self.subviews, 7) as! UIImageView
        warningForDescView.translatesAutoresizingMaskIntoConstraints = false
        warningForDescView.rightAnchor.constraint(equalTo: descTextView.rightAnchor, constant: -4).isActive = true
        warningForDescView.topAnchor.constraint(equalTo: descTextView.topAnchor, constant: 4).isActive = true
        warningForDescView.heightAnchor.constraint(equalTo: titleTextField.heightAnchor, multiplier: 0.8).isActive = true
        warningForDescView.widthAnchor.constraint(equalTo: titleTextField.heightAnchor, multiplier: 0.8).isActive = true
        warningForDescView.isHidden = true
        
    }
    
    public func GetUIViewOfTag(_ UIViewList: [UIView], _ IndexOf: Int) -> UIView?
    {
        for ListItem in UIViewList
        {
            if ListItem.tag == IndexOf
            {
                return ListItem
            }
        }
        return nil
    }
    
}
