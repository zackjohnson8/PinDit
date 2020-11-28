//
//  MapViewController.swift
//  MapUsage
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
    @IBOutlet weak var cameraButton: CustomButton!
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
        
        mapView.delegate = self
        mapView.checkLocationServices()
        
        // Add previously save persistant data
        let fetchRequest: NSFetchRequest<PinLocation> = PinLocation.fetchRequest()
        
        do {
            let pinLocation = try PersistanceService.context.fetch(fetchRequest)
            for pin in pinLocation
            {
                //print(pinLocation.count)
                mapView.pinUserLocationWithoutSavingToPersistance(pin)
            }
            
        } catch {
            print("Failed to load pin data")
        }
        
        // Setup default MapView and the Pin Popup UIView
        setupMapViewButtons()
        setupPopUpWindowView()
        
        // Create a gesture to allow the user to exit keyboard
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target:self, action: #selector(UIInputViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
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
    
}

extension MapViewController: CLLocationManagerDelegate
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

extension MapViewController: MKMapViewDelegate
{
    
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
            
            
            // Setup the newly created annotation and make sure it shows up using canShowCallout
            annotationView!.annotation = annotation
        } else {
            annotationView!.annotation = annotation
        }
        
        return annotationView
    }
    
    // Did get selected
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

extension MapViewController
{
    // All callback and event functions
    
    // Pin Popup Window Accept Action
    @objc private func acceptButtonPressed(sender: UIButton)
    {
//        let titleTextField: UITextField = MapPinCreationView.GetUIViewOfTag(MapPinCreationView.subviews, 1) as! UITextField
//        let descTextView: UITextView = MapPinCreationView.GetUIViewOfTag(MapPinCreationView.subviews, 3) as! UITextView
//        let warningForTitleField = MapPinCreationView.GetUIViewOfTag(MapPinCreationView.subviews, 6) as! UIImageView
//        let warningForDescView = MapPinCreationView.GetUIViewOfTag(MapPinCreationView.subviews, 7) as! UIImageView
//
//        if(titleTextField.text == "" && descTextView.text == "")
//        {
//            print("title text empty")
//            // Shake popup window and turn border color red. Might be worth adding a red ! next to text box
//            let animation = CABasicAnimation(keyPath: "position")
//            animation.duration = 0.07
//            animation.repeatCount = 4
//            animation.autoreverses = true
//            animation.fromValue = NSValue(cgPoint: CGPoint(x: MapPinCreationView.center.x - 10, y: MapPinCreationView.center.y))
//            animation.toValue = NSValue(cgPoint: CGPoint(x: MapPinCreationView.center.x + 10, y: MapPinCreationView.center.y))
//            titleTextField.layer.borderColor = UIColor.red.cgColor
//            descTextView.layer.borderColor = UIColor.red.cgColor
//            warningForTitleField.isHidden = false
//            warningForDescView.isHidden = false
//
//            MapPinCreationView.layer.add(animation, forKey: "position")
//            return
//
//        }else
//        if(titleTextField.text == "")
//        {
//            print("title text empty")
//            // Shake popup window and turn border color red. Might be worth adding a red ! next to text box
//            let animation = CABasicAnimation(keyPath: "position")
//            animation.duration = 0.07
//            animation.repeatCount = 4
//            animation.autoreverses = true
//            animation.fromValue = NSValue(cgPoint: CGPoint(x: MapPinCreationView.center.x - 10, y: MapPinCreationView.center.y))
//            animation.toValue = NSValue(cgPoint: CGPoint(x: MapPinCreationView.center.x + 10, y: MapPinCreationView.center.y))
//            titleTextField.layer.borderColor = UIColor.red.cgColor
//            descTextView.layer.borderColor = UIColor.systemGray4.cgColor
//            warningForTitleField.isHidden = false
//            warningForDescView.isHidden = true
//
//            MapPinCreationView.layer.add(animation, forKey: "position")
//            return
//
//        }else
//        if(descTextView.text == "")
//        {
//            print("desc text empty")
//            // Shake popup window and turn border color red. Might be worth adding a red ! next to text box
//            let animation = CABasicAnimation(keyPath: "position")
//            animation.duration = 0.07
//            animation.repeatCount = 4
//            animation.autoreverses = true
//            animation.fromValue = NSValue(cgPoint: CGPoint(x: MapPinCreationView.center.x - 10, y: MapPinCreationView.center.y))
//            animation.toValue = NSValue(cgPoint: CGPoint(x: MapPinCreationView.center.x + 10, y: MapPinCreationView.center.y))
//            descTextView.layer.borderColor = UIColor.red.cgColor
//            titleTextField.layer.borderColor = UIColor.systemGray4.cgColor
//            warningForDescView.isHidden = false
//            warningForTitleField.isHidden = true
//
//            MapPinCreationView.layer.add(animation, forKey: "position")
//            return
//        }
//
//        titleTextField.layer.borderColor = UIColor.systemGray4.cgColor
//        descTextView.layer.borderColor = UIColor.systemGray4.cgColor
//        warningForTitleField.isHidden = true
//        warningForDescView.isHidden = true
//        MapPinCreationView.isHidden = true
//        pinButtonPressed = !pinButtonPressed
//
//        // After the user presses the accept button on the pin screen send information to make a new pin
//        mapView.pinUserLocationWithSavingToPersistance(title: titleTextField.text!, description: descTextView.text)
//        titleTextField.text = ""
//        descTextView.text = ""
        
    }
    
    @objc private func cancelButtonPressed(sender: UIButton)
    {
//        let titleTextField: UITextField = MapPinCreationView.GetUIViewOfTag(MapPinCreationView.subviews, 1) as! UITextField
//        let descTextView: UITextView = MapPinCreationView.GetUIViewOfTag(MapPinCreationView.subviews, 3) as! UITextView
//        let warningForTitleField = MapPinCreationView.GetUIViewOfTag(MapPinCreationView.subviews, 6) as! UIImageView
//        let warningForDescView = MapPinCreationView.GetUIViewOfTag(MapPinCreationView.subviews, 7) as! UIImageView
//
//        // Clear all the values and hide the pin window
//        titleTextField.layer.borderColor = UIColor.systemGray4.cgColor
//        descTextView.layer.borderColor = UIColor.systemGray4.cgColor
//        warningForTitleField.isHidden = true
//        warningForDescView.isHidden = true
//        MapPinCreationView.isHidden = true
//        pinButtonPressed = !pinButtonPressed
//        titleTextField.text = ""
//        descTextView.text = ""
//        dismissKeyboard()
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    // Pin Button Action Callback Function
    private func pinLocation()
    {
        // Press the pin button and make the description screen appear
        MapPinCreationView.toggleView()
        UIViewPropertyAnimator(duration: 0.2, curve: .linear) {
            self.view.layoutIfNeeded()
        }.startAnimation()
        
    }
    
    // Camera Button Action Callback Function
    private func takePicture()
    {
        print("takePicture")
    }
    
    // Center Button Action Callback Function
    private func centerLocation()
    {
        mapView.centerViewOnUserLocation()
    }

}

