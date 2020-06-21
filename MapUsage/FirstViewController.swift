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
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var pinButton: UIButton!
    @IBOutlet weak var expansionButton: UIButton!
    @IBOutlet weak var friendButton: UIButton!
    @IBOutlet weak var searchButton: UIButton!
    
    let locationManager = CLLocationManager()
    let regionInMeters: Double = 1000
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        checkLocationServices()
        setupButtons()
        //createLayout()
    }
    
    func setupButtons() {
        // PinButton
        pinButton.setImage(UIImage(systemName: "mappin"), for: .normal)
        pinButton.layer.cornerRadius = 24
        pinButton.addTarget(self, action: #selector(pinButtonPressed(sender:)), for: .touchUpInside)
        pinButton.isHidden = true
        
        // ExpansionButton
        expansionButton.setImage(UIImage(systemName: "plus"), for: .normal)
        expansionButton.layer.cornerRadius = 24
        expansionButton.addTarget(self, action: #selector(pinButtonPressed(sender:)), for: .touchUpInside)
        
        // FriendButton
        friendButton.setImage(UIImage(systemName: "person.2.fill"), for: .normal)
        friendButton.layer.cornerRadius = 24
        friendButton.addTarget(self, action: #selector(pinButtonPressed(sender:)), for: .touchUpInside)
        friendButton.isHidden = true
        
        // SearchButton
        searchButton.setImage(UIImage(systemName: "magnifyingglass"), for: .normal)
        searchButton.layer.cornerRadius = 24
        searchButton.addTarget(self, action: #selector(pinButtonPressed(sender:)), for: .touchUpInside)
        searchButton.isHidden = true
        
    }
    
    // Create an animation so that multiple buttons can show up
    // 3 buttons to test with
    
    
    @objc private func pinButtonPressed(sender: UIButton)
    {
        UIButton.animate(withDuration: 0.1,
                         animations: { sender.transform = CGAffineTransform(scaleX: 0.75, y: 0.75)},
                         completion: { finish in UIButton.animate(withDuration: 0.1, animations: {sender.transform = CGAffineTransform.identity})
        })
        
        if sender == expansionButton {
            
            UIButton.animate(withDuration: 3.0, animations: { sender.transform  = CGAffineTransform.init(rotationAngle: CGFloat(360))})
            //UIButton.animate(withDuration: 0.5, animations: { sender.transform.rotated(by: CGFloat(Double.pi/2)) })
            
            pinButton.isHidden = !pinButton.isHidden
            friendButton.isHidden = !friendButton.isHidden
            searchButton.isHidden = !searchButton.isHidden
            
            //UIButton.animate(withDuration: 0.5, animations: { self.pinButton.transform.rotated(by: CGFloat(Double.pi/2)) })
        }
        
        
    }
    
    func setupLocationManager() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
    }
    
    func centerViewOnUserLocation() {
        if let location = locationManager.location?.coordinate {
            let region = MKCoordinateRegion.init(center: location, latitudinalMeters: regionInMeters, longitudinalMeters: regionInMeters)
            mapView.setRegion(region, animated: true)
        }
    }
    
    func checkLocationServices() {
        if CLLocationManager.locationServicesEnabled(){
            // Setup our location manager
            setupLocationManager()
            checkLocationAuthorization()
        } else {
            // Show alert letting the user know they have to turn this on.
            print("Location wasn't given")
        }
    }
    
    func checkLocationAuthorization() {
        switch CLLocationManager.authorizationStatus(){
        case .authorizedWhenInUse:
            mapView.showsUserLocation = true
            centerViewOnUserLocation()
            locationManager.startUpdatingLocation()
            break
        case .denied:
            // Show alert instructing them how to turn on permissions
            break
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
            break
        case .restricted:
            // Cannot be put on (show alert to let them know)
            break
        case .authorizedAlways:
            // Probably won't do
            break
        @unknown default:
            fatalError()
        }
    }
    
}


extension FirstViewController: CLLocationManagerDelegate {
    
    func locationManger(_ manager: CLLocationManager, didUpdateLocation location: [CLLocation]) {
        guard let location = location.last else { return }
        let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        let region = MKCoordinateRegion.init(center: center, latitudinalMeters: regionInMeters, longitudinalMeters: regionInMeters)
        mapView.setRegion(region, animated: true)
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        checkLocationAuthorization()
    }
    
}
