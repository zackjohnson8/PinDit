//
//  CustomMap.swift
//  MapUsage
//
//  Created by Zachary Johnson on 6/21/20.
//  Copyright © 2020 Zachary Johnson. All rights reserved.
//

import MapKit
import UIKit
import CoreLocation
import CoreData

class CustomMap: MKMapView, CLLocationManagerDelegate {
    
    let locationManager = CLLocationManager()
    let regionInMeters: Double = 1000
    public var myCenter: CLLocationCoordinate2D? = nil
    var myAnnotations = [PinLocation]()
    
    public func initialize()
    {
        locationManager.delegate = self
    }
    
    override func didMoveToWindow() {
        centerViewOnUserLocation()
    }
    
    // This function is primarily called for PersistanceService to write pins back to the screen
    public func pinUserLocationWithoutSavingToPersistance(_ pinLocation_m: PinLocation)
    {
        let pointAnnotation = MKPointAnnotation()
        pointAnnotation.title = pinLocation_m.title
        pointAnnotation.subtitle = pinLocation_m.subtitle
        pointAnnotation.coordinate.latitude = pinLocation_m.latitude
        pointAnnotation.coordinate.longitude = pinLocation_m.longitude
        self.addAnnotation(pointAnnotation)
    }
    
    public func loadPinData()
    {
        let fetchRequest: NSFetchRequest<PinLocation> = PinLocation.fetchRequest()
        do {
            let pinLocation = try PersistanceService.context.fetch(fetchRequest)
            for pin in pinLocation
            {
                //print(pinLocation.count)
                self.pinUserLocationWithoutSavingToPersistance(pin)
            }
        } catch {
            print("Failed to load pin data")
        }
    }
    
    // The main pinUserLocation call that also saves the user location too
    public func pinUserLocationWithSavingToPersistance(title: String, description: String)
    {
        // Add a list of annotations that then can be checked
        if let coor = self.userLocation.location?.coordinate
        {
            self.setCenter(coor, animated: true)
            
            // Place annotation on screen
            let myLocation = MKPointAnnotation()
            myLocation.title = title
            myLocation.subtitle = description
            myLocation.coordinate = coor
            self.addAnnotation(myLocation)
            
            // Save the newly created annotation into the database
            let pinLocation = PinLocation(context: PersistanceService.context)
            pinLocation.title = title
            pinLocation.subtitle = description
            pinLocation.latitude = coor.latitude
            pinLocation.longitude = coor.longitude
            Database.SetPinData(pinLocation)
            
        }
    }
        
    // MAP
    public func centerViewOnUserLocation() {
        if let location = locationManager.location?.coordinate {
            let region = MKCoordinateRegion.init(center: location, latitudinalMeters: regionInMeters, longitudinalMeters: regionInMeters)
            self.setRegion(region, animated: true)
        }
    }
    
    
    // MAP
    func checkLocationServices() {
        if CLLocationManager.locationServicesEnabled(){
            // Setup our location manager
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            checkLocationAuthorization()
        } else {
            // Show alert letting the user know they have to turn this on.
            print("Location wasn't given")
        }
    }
    
    // MAP
    func checkLocationAuthorization() {
        switch CLLocationManager.authorizationStatus(){
        case .authorizedWhenInUse:
            self.showsUserLocation = true
            locationManager.startUpdatingLocation()
            break
        case .denied:
            // Show alert instructing them how to turn on permissions
            locationManager.requestWhenInUseAuthorization()
            break
        case .notDetermined:
            self.showsUserLocation = true
            locationManager.requestWhenInUseAuthorization()
            break
        case .restricted:
            break
        case .authorizedAlways:
            self.showsUserLocation = true
            locationManager.startUpdatingLocation()
            break
        @unknown default:
            fatalError()
        }
    }

}

extension CustomMap
{
    // Extensions for mapView delegate functions
    func locationManger(_ manager: CLLocationManager, didUpdateLocation location: [CLLocation])
    {
        guard let location = location.last else { return }
        let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        let region = MKCoordinateRegion.init(center: center, latitudinalMeters: regionInMeters, longitudinalMeters: regionInMeters)
        setRegion(region, animated: true)
    }

    // Extensions for mapView delegate functions
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus)
    {
        checkLocationAuthorization()
        centerViewOnUserLocation()
    }
}
