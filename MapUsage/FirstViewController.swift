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
    @IBOutlet weak var pinButton: UIButton!
    //@IBOutlet weak var expansionButton: UIButton!
    @IBOutlet weak var friendButton: UIButton!
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var expansionButton: CustomExpandingButton!
    
    let regionInMeters: Double = 1000
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        mapView.checkLocationServices()
        setupButtons()
        
        // MAP
        let london = MKPointAnnotation()
        london.title = "London"
        london.coordinate = CLLocationCoordinate2D(latitude: 51.507222, longitude: -0.1275)
        mapView.addAnnotation(london)
    }

    
    func setupButtons() {
        
        expansionButton.initialize()
        
        // PinButton
        pinButton.setImage(UIImage(systemName: "mappin"), for: .normal)
        pinButton.layer.cornerRadius = 24
        pinButton.addTarget(self, action: #selector(pinButtonPressed(sender:)), for: .touchUpInside)
        pinButton.isHidden = true
        
        // ExpansionButton
//        expansionButton.setImage(UIImage(systemName: "plus"), for: .normal)
//        expansionButton.layer.cornerRadius = 24
//        expansionButton.addTarget(self, action: #selector(pinButtonPressed(sender:)), for: .touchUpInside)
        
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
    
    
    // BUTTON
    @objc private func pinButtonPressed(sender: UIButton)
    {
        UIButton.animate(withDuration: 0.1,
                         animations: { sender.transform = CGAffineTransform(scaleX: 0.75, y: 0.75)},
                         completion: { finish in UIButton.animate(withDuration: 0.1, animations: {sender.transform = CGAffineTransform.identity})
        })
        
        if sender == expansionButton {
            
            UIButton.animate(withDuration: 0.5, animations: { sender.transform  = CGAffineTransform.init(rotationAngle: CGFloat(720))},
                             completion: { finish in UIButton.animate(withDuration: 0.5, animations: {sender.transform = CGAffineTransform.identity})
            })
            
            pinButton.isHidden = !pinButton.isHidden
            friendButton.isHidden = !friendButton.isHidden
            searchButton.isHidden = !searchButton.isHidden
        }
    }
}


// MAP
extension FirstViewController: CLLocationManagerDelegate {
    
    func locationManger(_ manager: CLLocationManager, didUpdateLocation location: [CLLocation]) {
        guard let location = location.last else { return }
        let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        let region = MKCoordinateRegion.init(center: center, latitudinalMeters: regionInMeters, longitudinalMeters: regionInMeters)
        mapView.setRegion(region, animated: true)
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        mapView.checkLocationAuthorization()
    }
    
}
