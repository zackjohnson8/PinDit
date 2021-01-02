//
//  MapViewController.swift
//  PinDit
//
//  Created by Zachary Johnson on 6/8/20.
//  Copyright © 2020 Zachary Johnson. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation
import CoreData

class MapViewController: UIViewController {
    
    @IBOutlet weak var mapView: CustomMap!
    @IBOutlet weak var expansionButton: CustomExpandingButton!
    @IBOutlet weak var pinButton: CustomButton!
    @IBOutlet weak var centerButton: CustomButton!
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var MapPinCreationView: MapPinCreationView!
    
    var pinButtonPressed = true
    
    let bottomAnchorConstant: CGFloat = 9
    let leftAnchorConstant: CGFloat = 11
    let regionInMeters: Double = 1000
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        mapView.initialize()
        mapView.delegate = self
        mapView.showsUserLocation = true
        mapView.checkLocationServices()
        mapView.centerViewOnUserLocation()
        mapView.loadPinData()
        Database.FetchAllPersistantData()
        
        // Setup default MapView and the Pin Popup UIView
        setupMapViewButtons()
        setupPopUpWindowView()
        
        // Create a gesture to allow the user to exit keyboard
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target:self, action: #selector(UIInputViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // In plain english:
        // * Tell the map to update it's annotations. Remove the annotations that were possibly removed in Saved Locations.
        // Steps:
        // Determine if the annotations need updating.
        // Call map to update
        // Update screen if needed
        mapView.updateAnnotiations()
        
    }
    
    private func setupPopUpWindowView()
    {
        // Add the MapPinCreationView as a subview of the UIViewController(self)
        self.view.addSubview(MapPinCreationView)
    }
    
    private func setupMapViewButtons()
    {
        addConstraints()
        
        // Run initialize function on all the buttons. This is necessary to specify which button and callback functions
        expansionButton.initialize()
        pinButton.initialize(CustomButton.ButtonType.PINMAP, pinLocation)
        centerButton.initialize(CustomButton.ButtonType.CENTER, centerLocation)
        
        // Add buttons to the expansion button. This is for the expansion animation.
        expansionButton.addContainingButton(button: &pinButton)
        expansionButton.addContainingButton(button: &centerButton)
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
        
    }
    
}

extension MapViewController
{
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    // Pin Button Action Callback Function
    public func pinLocation()
    {
        // Press the pin button and make the description screen appear
        centerLocation()
        MapPinCreationView.toggleView()
        UIViewPropertyAnimator(duration: 0.2, curve: .linear) {
            self.view.layoutIfNeeded()
        }.startAnimation()
        
    }
    
    // Center Button Action Callback Function
    private func centerLocation()
    {
        mapView.centerViewOnUserLocation()
    }

}

extension MapViewController: MKMapViewDelegate
{
    
    // TODO(zack): Probably need to remove or remake this function later.
    func mapView(_ mapView: MKMapView, didUpdate: MKUserLocation)
    {
        //guard let location = didUpdate.location else { return }
        //mapView.centerCoordinate = location.coordinate
    }
    
    // Add a new custom annotation
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView?
    {
        
        guard annotation is MKPointAnnotation else { return nil }

        let identifier = "Annotation"
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)

        if annotationView == nil {
            annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            annotationView!.canShowCallout = true
            annotationView!.detailCalloutAccessoryView?.heightAnchor.constraint(equalToConstant: 200).isActive = true
            annotationView!.annotation = annotation
        } else {
            annotationView!.annotation = annotation
        }
        annotationView?.isDraggable = true
        
        return annotationView
    }
    
    //Did get selected
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView)
    {

        let selectedLabel:UILabel = UILabel.init(frame: CGRect(x: 0, y: 0, width: 140, height: 38))
        if view.reuseIdentifier == "Annotation"
        {
            selectedLabel.text = "Hello World"
            selectedLabel.textAlignment = .center
            selectedLabel.font = UIFont.init(name: "HelveticaBold", size: 15)
            selectedLabel.backgroundColor = UIColor.lightGray
            selectedLabel.layer.borderColor = UIColor.darkGray.cgColor
            selectedLabel.layer.borderWidth = 2
            selectedLabel.layer.cornerRadius = 5
            selectedLabel.layer.masksToBounds = true

        }
    }
}

