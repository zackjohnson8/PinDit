//
//  CustomButton.swift
//  PinDit
//
//  Created by Zachary Johnson on 6/24/20.
//  Copyright © 2020 Zachary Johnson. All rights reserved.
//

import Foundation

import UIKit



class CustomButton: UIButton
{
    public enum ButtonType {
        case COMPASS
        case CAMERA
        case CENTER
        case PINMAP
    }

    var callbackFunc: (()->Void)?
    
    func initialize(_ buttonType: ButtonType, _ callback: @escaping () -> Void){
        setupButton(buttonType, callback)
    }
    
    private func setupButton(_ buttonType: ButtonType, _ callback: @escaping () -> Void){
        switch buttonType {
            case ButtonType.COMPASS:
                setupCompassButton()
                callbackFunc = callback
            case ButtonType.CAMERA:
                setupCameraButton()
                callbackFunc = callback
            case ButtonType.CENTER:
                setupCenterButton()
                callbackFunc = callback
            case ButtonType.PINMAP:
                setupPinMapButton()
                callbackFunc = callback
        }
    }
    
    func setupPinMapButton(){
        self.setImage(UIImage(systemName: "mappin"), for: .normal)
        
        self.layer.cornerRadius = 24
        self.addTarget(self,
                       action: #selector(buttonPressed(sender:)),
                       for: .touchUpInside)
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func setupCenterButton(){
        self.setImage(UIImage(systemName: "location.north.fill"), for: .normal)
        
        self.layer.cornerRadius = 24
        self.addTarget(self,
                       action: #selector(buttonPressed(sender:)),
                       for: .touchUpInside)
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func setupCameraButton(){
        self.setImage(UIImage(systemName: "camera.fill"), for: .normal)
        
        self.layer.cornerRadius = 24
        self.addTarget(self,
                       action: #selector(buttonPressed(sender:)),
                       for: .touchUpInside)
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func setupCompassButton(){
        //TODO
    }
    
    @objc private func buttonPressed(sender: UIButton){
        callbackFunc!()
        UIButton.animate(withDuration: 0.1,
                         animations: { sender.transform = CGAffineTransform(scaleX: 0.75, y: 0.75)},
                         completion: { finish in UIButton.animate(withDuration: 0.1, animations: {sender.transform = CGAffineTransform.identity})
        })
    }
}
