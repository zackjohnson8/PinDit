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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        mapView.checkLocationServices()
        setupButtons()
        setupPopupWindow()
    }

    func setupPopupWindow() {
        var subviews = pinPopupWindow.subviews
        
        for subview in subviews {
            switch subview.tag {
                case 0:
                    break
                case 1:
                    break
                case 2:
                    break
                case 3:
                    break
                case 4:
                    break
                case 5:
                    break
                default:
                    print("Popup window couldn't find that tag " + String(subview.tag))
            }
        }
        
    }
    
    func setupButtons() {
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
    
    func addConstraints()
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
}

extension FirstViewController: CLLocationManagerDelegate
{
    // Extensions for mapView delegate functions
    func locationManger(_ manager: CLLocationManager, didUpdateLocation location: [CLLocation]) {
        //
        guard let location = location.last else { return }
        let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        let region = MKCoordinateRegion.init(center: center, latitudinalMeters: regionInMeters, longitudinalMeters: regionInMeters)
        mapView.setRegion(region, animated: true)
    }

    // Extensions for mapView delegate functions
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        mapView.checkLocationAuthorization()
    }
}

