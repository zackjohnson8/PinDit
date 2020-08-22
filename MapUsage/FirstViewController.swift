//
//  FirstViewController.swift
//  MapUsage
//
//  Created by Zachary Johnson on 6/8/20.
//  Copyright © 2020 Zachary Johnson. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class FirstViewController: UIViewController, MKMapViewDelegate {
    
    @IBOutlet weak var mapView: CustomMap!
    @IBOutlet weak var expansionButton: CustomExpandingButton!
    @IBOutlet weak var cameraButton: CustomButton!
    @IBOutlet weak var pinButton: CustomButton!
    @IBOutlet weak var centerButton: CustomButton!
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var pinPopupWindow: PinPopupWindow!
    @IBOutlet weak var descriptionPopupWindowTextView: UITextView!
    @IBOutlet weak var titlePopupWindowTextView: UITextField!
    @IBOutlet weak var acceptPopupWindowBtn: UIButton!
    @IBOutlet weak var cancelPopupWindowBtn: UIButton!
    
    var pinButtonPressed = true
    
    let bottomAnchorConstant: CGFloat = 9
    let leftAnchorConstant: CGFloat = 11
    let regionInMeters: Double = 1000
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        mapView.delegate = self
        mapView.checkLocationServices()
        setupButtons()
        setupPopupWindow()
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target:self, action: #selector(UIInputViewController.dismissKeyboard))
        
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }

    func setupPopupWindow()
    {
        
        pinPopupWindow.translatesAutoresizingMaskIntoConstraints = false
        pinPopupWindow.isHidden = pinButtonPressed
        
        self.view.addSubview(pinPopupWindow)
        
        let windowHeight = view.frame.height
        let windowWidth = view.frame.width
        
        // Main PopupWindow UIView
        pinPopupWindow.widthAnchor.constraint(equalTo: self.view.widthAnchor, constant: -(windowWidth * 0.3)).isActive = true
        pinPopupWindow.heightAnchor.constraint(equalTo: self.view.heightAnchor, constant: -(windowHeight * 0.6)).isActive = true
        pinPopupWindow.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        pinPopupWindow.centerYAnchor.constraint(equalTo: self.view.centerYAnchor, constant: -(windowHeight * 0.1)).isActive = true
        pinPopupWindow.layer.cornerRadius = 10
        pinPopupWindow.layer.masksToBounds = true
        
        // Title Label 0
        let titleLabel = GetUIViewOfTag(pinPopupWindow.subviews, 0)
        titleLabel?.translatesAutoresizingMaskIntoConstraints = false
        titleLabel?.leftAnchor.constraint(equalTo: pinPopupWindow.leftAnchor, constant: 20).isActive = true
        titleLabel?.topAnchor.constraint(equalTo: pinPopupWindow.topAnchor, constant: 10).isActive = true
        titleLabel?.widthAnchor.constraint(equalToConstant: 36).isActive = true
                    
        
        // Text Field 1
        let titleTextField: UITextField = GetUIViewOfTag(pinPopupWindow.subviews, 1) as! UITextField
        titleTextField.translatesAutoresizingMaskIntoConstraints = false
        titleTextField.topAnchor.constraint(equalTo: titleLabel!.centerYAnchor, constant: 0).isActive = true
        titleTextField.leftAnchor.constraint(equalTo: pinPopupWindow.leftAnchor, constant: 10).isActive = true
        titleTextField.widthAnchor.constraint(equalTo: pinPopupWindow.widthAnchor, constant: -20).isActive = true
        titleTextField.heightAnchor.constraint(equalToConstant: 30).isActive = true
        titleTextField.layer.cornerRadius = 6
        titleTextField.layer.masksToBounds = true
        titleTextField.layer.borderColor = UIColor.systemGray4.cgColor
        titleTextField.layer.borderWidth = 0.8
        
        
        // Description Label 2
        let discLabel = GetUIViewOfTag(pinPopupWindow.subviews, 2)
        discLabel?.translatesAutoresizingMaskIntoConstraints = false
        discLabel?.topAnchor.constraint(equalTo: titleTextField.bottomAnchor, constant: 15).isActive = true
        discLabel?.leftAnchor.constraint(equalTo: pinPopupWindow.leftAnchor, constant: 20).isActive = true
        discLabel?.widthAnchor.constraint(equalToConstant: 82).isActive = true
        
        
        // Description Text View Multiline 3
        let descTextView = GetUIViewOfTag(pinPopupWindow.subviews, 3) as! UITextView
        descTextView.translatesAutoresizingMaskIntoConstraints = false
        descTextView.topAnchor.constraint(equalTo: discLabel!.centerYAnchor, constant: 0).isActive = true
        descTextView.leftAnchor.constraint(equalTo: pinPopupWindow.leftAnchor, constant: 10).isActive = true
        descTextView.widthAnchor.constraint(equalTo: pinPopupWindow.widthAnchor, constant: -20).isActive = true
        descTextView.heightAnchor.constraint(equalTo: self.view.heightAnchor, constant: -(windowHeight * 0.8)).isActive = true
        descTextView.layer.cornerRadius = 6
        descTextView.layer.masksToBounds = true
        descTextView.layer.borderWidth = 0.8
        descTextView.layer.borderColor = UIColor.systemGray4.cgColor
        
                            
        // Left Button Accept Button 4
        let acceptButton = GetUIViewOfTag(pinPopupWindow.subviews, 4) as! UIButton
        acceptButton.translatesAutoresizingMaskIntoConstraints = false
        acceptButton.bottomAnchor.constraint(equalTo: pinPopupWindow.bottomAnchor, constant: 1).isActive = true
        acceptButton.leftAnchor.constraint(equalTo: pinPopupWindow.leftAnchor, constant: -1).isActive = true
        acceptButton.widthAnchor.constraint(equalTo: pinPopupWindow.widthAnchor, multiplier: 0.51).isActive = true
        acceptButton.heightAnchor.constraint(equalTo: pinPopupWindow.heightAnchor, multiplier: 0.15).isActive = true
        acceptButton.layer.borderWidth = 0.8
        acceptButton.layer.borderColor = UIColor.systemGray4.cgColor
        acceptButton.addTarget(self, action: #selector(acceptButtonPressed(sender:)), for: .touchUpInside)
        

        // Right Button Cancel Button 5
        let cancelButton = GetUIViewOfTag(pinPopupWindow.subviews, 5) as! UIButton
        cancelButton.translatesAutoresizingMaskIntoConstraints = false
        cancelButton.bottomAnchor.constraint(equalTo: pinPopupWindow.bottomAnchor, constant: 1).isActive = true
        cancelButton.rightAnchor.constraint(equalTo: pinPopupWindow.rightAnchor, constant: 1).isActive = true
        cancelButton.widthAnchor.constraint(equalTo: pinPopupWindow.widthAnchor, multiplier: 0.51).isActive = true
        cancelButton.heightAnchor.constraint(equalTo: pinPopupWindow.heightAnchor, multiplier: 0.15).isActive = true
        cancelButton.layer.borderWidth = 0.8
        cancelButton.layer.borderColor = UIColor.systemGray4.cgColor
        cancelButton.addTarget(self, action: #selector(cancelButtonPressed(sender:)), for: .touchUpInside)
        
        
        // Exclamation marks for warning user that title text view is empty
        let warningForTitleField = GetUIViewOfTag(pinPopupWindow.subviews, 6) as! UIImageView
        warningForTitleField.translatesAutoresizingMaskIntoConstraints = false
        warningForTitleField.rightAnchor.constraint(equalTo: titleTextField.rightAnchor, constant: -2).isActive = true
        warningForTitleField.centerYAnchor.constraint(equalTo: titleTextField.centerYAnchor).isActive = true
        warningForTitleField.heightAnchor.constraint(equalTo: titleTextField.heightAnchor, multiplier: 0.8).isActive = true
        warningForTitleField.widthAnchor.constraint(equalTo: titleTextField.heightAnchor, multiplier: 0.8).isActive = true
        warningForTitleField.isHidden = true
                
        
        // Exclamation marks for warning user that description text view is empty
        let warningForDescView = GetUIViewOfTag(pinPopupWindow.subviews, 7) as! UIImageView
        warningForDescView.translatesAutoresizingMaskIntoConstraints = false
        warningForDescView.rightAnchor.constraint(equalTo: descTextView.rightAnchor, constant: -4).isActive = true
        warningForDescView.topAnchor.constraint(equalTo: descTextView.topAnchor, constant: 4).isActive = true
        warningForDescView.heightAnchor.constraint(equalTo: titleTextField.heightAnchor, multiplier: 0.8).isActive = true
        warningForDescView.widthAnchor.constraint(equalTo: titleTextField.heightAnchor, multiplier: 0.8).isActive = true
        warningForDescView.isHidden = true
        
    }
    
    @objc private func acceptButtonPressed(sender: UIButton)
    {
        let titleTextField: UITextField = GetUIViewOfTag(pinPopupWindow.subviews, 1) as! UITextField
        let descTextView: UITextView = GetUIViewOfTag(pinPopupWindow.subviews, 3) as! UITextView
        let warningForTitleField = GetUIViewOfTag(pinPopupWindow.subviews, 6) as! UIImageView
        let warningForDescView = GetUIViewOfTag(pinPopupWindow.subviews, 7) as! UIImageView
        
        if(titleTextField.text == "" && descTextView.text == "")
        {
            print("title text empty")
            // Shake popup window and turn border color red. Might be worth adding a red ! next to text box
            let animation = CABasicAnimation(keyPath: "position")
            animation.duration = 0.07
            animation.repeatCount = 4
            animation.autoreverses = true
            animation.fromValue = NSValue(cgPoint: CGPoint(x: pinPopupWindow.center.x - 10, y: pinPopupWindow.center.y))
            animation.toValue = NSValue(cgPoint: CGPoint(x: pinPopupWindow.center.x + 10, y: pinPopupWindow.center.y))
            titleTextField.layer.borderColor = UIColor.red.cgColor
            descTextView.layer.borderColor = UIColor.red.cgColor
            warningForTitleField.isHidden = false
            warningForDescView.isHidden = false
            
            pinPopupWindow.layer.add(animation, forKey: "position")
            return
            
        }else
        if(titleTextField.text == "")
        {
            print("title text empty")
            // Shake popup window and turn border color red. Might be worth adding a red ! next to text box
            let animation = CABasicAnimation(keyPath: "position")
            animation.duration = 0.07
            animation.repeatCount = 4
            animation.autoreverses = true
            animation.fromValue = NSValue(cgPoint: CGPoint(x: pinPopupWindow.center.x - 10, y: pinPopupWindow.center.y))
            animation.toValue = NSValue(cgPoint: CGPoint(x: pinPopupWindow.center.x + 10, y: pinPopupWindow.center.y))
            titleTextField.layer.borderColor = UIColor.red.cgColor
            descTextView.layer.borderColor = UIColor.systemGray4.cgColor
            warningForTitleField.isHidden = false
            warningForDescView.isHidden = true
            
            pinPopupWindow.layer.add(animation, forKey: "position")
            return
            
        }else
        if(descTextView.text == "")
        {
            print("desc text empty")
            // Shake popup window and turn border color red. Might be worth adding a red ! next to text box
            let animation = CABasicAnimation(keyPath: "position")
            animation.duration = 0.07
            animation.repeatCount = 4
            animation.autoreverses = true
            animation.fromValue = NSValue(cgPoint: CGPoint(x: pinPopupWindow.center.x - 10, y: pinPopupWindow.center.y))
            animation.toValue = NSValue(cgPoint: CGPoint(x: pinPopupWindow.center.x + 10, y: pinPopupWindow.center.y))
            descTextView.layer.borderColor = UIColor.red.cgColor
            titleTextField.layer.borderColor = UIColor.systemGray4.cgColor
            warningForDescView.isHidden = false
            warningForTitleField.isHidden = true
            
            pinPopupWindow.layer.add(animation, forKey: "position")
            return
        }
        
        titleTextField.layer.borderColor = UIColor.systemGray4.cgColor
        descTextView.layer.borderColor = UIColor.systemGray4.cgColor
        warningForTitleField.isHidden = true
        warningForDescView.isHidden = true
        
        // TODO(Zack): Move this over to a new function for accept
        // After the user presses the accept button on the pin screen send information to make a new pin
        //mapView.pinUserLocation(title: ,Description: )
    }
    
    @objc private func cancelButtonPressed(sender: UIButton)
    {
        //TODO(Zack): DO IT!
    }
    
    private func setupButtons()
    {
        addConstraints()
        
        // Run initialize function on all the buttons. This is necessary to specify which button and callback functions
        expansionButton.initialize()
        pinButton.initialize(CustomButton.ButtonType.PINMAP, pinLocation)
        centerButton.initialize(CustomButton.ButtonType.CENTER, centerLocation)
        cameraButton.initialize(CustomButton.ButtonType.CAMERA, takePicture)
        
        // Add buttons to the expansion button. This is for the expansion animation.
        expansionButton.addContainingButton(button: &pinButton)
        expansionButton.addContainingButton(button: &centerButton)
        expansionButton.addContainingButton(button: &cameraButton)
    }
    
    private func addConstraints()
    {
        // Expansion Button
        expansionButton.bottomAnchor.constraint(equalTo: mapView.bottomAnchor, constant: -(view.frame.width / bottomAnchorConstant)).isActive = true
        expansionButton.leftAnchor.constraint(equalTo: mapView.leftAnchor, constant: view.frame.width / leftAnchorConstant).isActive = true
        
        // Pin Button
        pinButton.bottomAnchor.constraint(equalTo: mapView.bottomAnchor, constant: -(view.frame.width / bottomAnchorConstant)).isActive = true
        pinButton.leftAnchor.constraint(equalTo: expansionButton.rightAnchor, constant: view.frame.width / leftAnchorConstant).isActive = true
        
        // Center Button
        centerButton.bottomAnchor.constraint(equalTo: mapView.bottomAnchor, constant: -(view.frame.width / bottomAnchorConstant)).isActive = true
        centerButton.leftAnchor.constraint(equalTo: pinButton.rightAnchor, constant: view.frame.width / leftAnchorConstant).isActive = true
        
        // Camera Button
        cameraButton.bottomAnchor.constraint(equalTo: mapView.bottomAnchor, constant: -(view.frame.width / bottomAnchorConstant)).isActive = true
        cameraButton.leftAnchor.constraint(equalTo: centerButton.rightAnchor, constant: view.frame.width / leftAnchorConstant).isActive = true
    }
    
    
    // Pin Button Action
    public func pinLocation()
    {
        
        // Press the pin button and make the description screen appear
        pinButtonPressed = !pinButtonPressed
        pinPopupWindow.isHidden = pinButtonPressed

    }
    
    // Camera Button Action
    public func takePicture()
    {
        print("takePicture")
    }
    
    // Center Button Action
    public func centerLocation()
    {
        mapView.centerViewOnUserLocation()
    }
    
    private func GetUIViewOfTag(_ UIViewList: [UIView], _ IndexOf: Int) -> UIView?
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

extension FirstViewController: CLLocationManagerDelegate
{
    // Extensions for mapView delegate functions
    func locationManger(_ manager: CLLocationManager, didUpdateLocation location: [CLLocation])
    {
        //
        guard let location = location.last else { return }
        let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        let region = MKCoordinateRegion.init(center: center, latitudinalMeters: regionInMeters, longitudinalMeters: regionInMeters)
        mapView.setRegion(region, animated: true)
    }

    // Extensions for mapView delegate functions
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus)
    {
        mapView.checkLocationAuthorization()
    }
}

