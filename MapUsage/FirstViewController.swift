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
    }

    func setupPopupWindow()
    {
        
        pinPopupWindow.translatesAutoresizingMaskIntoConstraints = false
        pinPopupWindow.isHidden = false
        
        self.view.addSubview(pinPopupWindow)
        
        let windowHeight = view.frame.height
        let windowWidth = view.frame.width
        
        // Main PopupWindow UIView
        pinPopupWindow.widthAnchor.constraint(equalTo: self.view.widthAnchor, constant: -(windowWidth * 0.3)).isActive = true
        pinPopupWindow.heightAnchor.constraint(equalTo: self.view.heightAnchor, constant: -(windowHeight * 0.6)).isActive = true
        pinPopupWindow.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        pinPopupWindow.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        
        // Title Label 0
        let titleLabel = GetUIViewOfTag(pinPopupWindow.subviews, 0)
        titleLabel?.translatesAutoresizingMaskIntoConstraints = false
        titleLabel?.leftAnchor.constraint(equalTo: pinPopupWindow.leftAnchor, constant: 20).isActive = true
        titleLabel?.topAnchor.constraint(equalTo: pinPopupWindow.topAnchor, constant: 10).isActive = true
        titleLabel?.widthAnchor.constraint(equalToConstant: 36).isActive = true
                    
        // Text Field 1
        let titleTextField = GetUIViewOfTag(pinPopupWindow.subviews, 1)
        titleTextField?.translatesAutoresizingMaskIntoConstraints = false
        titleTextField?.topAnchor.constraint(equalTo: titleLabel!.centerYAnchor, constant: 0).isActive = true
        titleTextField?.leftAnchor.constraint(equalTo: pinPopupWindow.leftAnchor, constant: 10).isActive = true
        titleTextField?.widthAnchor.constraint(equalTo: pinPopupWindow.widthAnchor, constant: -20).isActive = true
        
        // Description Label 2
        let discLabel = GetUIViewOfTag(pinPopupWindow.subviews, 2)
        discLabel?.translatesAutoresizingMaskIntoConstraints = false
        discLabel?.topAnchor.constraint(equalTo: titleTextField!.bottomAnchor, constant: 15).isActive = true
        discLabel?.leftAnchor.constraint(equalTo: pinPopupWindow.leftAnchor, constant: 20).isActive = true
        discLabel?.widthAnchor.constraint(equalToConstant: 82).isActive = true
        
        // Description Text View Multiline 3
        let discTextView = GetUIViewOfTag(pinPopupWindow.subviews, 3)
        discTextView?.translatesAutoresizingMaskIntoConstraints = false
        discTextView?.topAnchor.constraint(equalTo: discLabel!.centerYAnchor, constant: 0).isActive = true
        discTextView?.leftAnchor.constraint(equalTo: pinPopupWindow.leftAnchor, constant: 10).isActive = true
        discTextView?.widthAnchor.constraint(equalTo: pinPopupWindow.widthAnchor, constant: -20).isActive = true
        discTextView?.heightAnchor.constraint(equalToConstant: 200).isActive = true
        discTextView?.layer.cornerRadius = 6
        discTextView?.layer.borderWidth = 0.8
        discTextView?.layer.borderColor = UIColor.systemGray4.cgColor
                            
        // Left Button

        // Right Button
        
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
        mapView.pinUserLocation()
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

