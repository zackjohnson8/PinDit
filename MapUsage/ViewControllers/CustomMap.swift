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

class CustomMap: MKMapView, MKMapViewDelegate, CLLocationManagerDelegate {
    
    let locationManager = CLLocationManager()
    let regionInMeters: Double = 1000
    var myCenter: CLLocationCoordinate2D? = nil
    var myAnnotations = [PinLocation]()
    
    func initialize()
    {
        delegate = self
    }

    func mapView(_ mapView: MKMapView, didUpdate: MKUserLocation)
    {
        guard let location = didUpdate.location else { return }
        myCenter = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
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
    func setupLocationManager() {
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
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
            setupLocationManager()
            checkLocationAuthorization()
        } else {
            // Show alert letting the user know they have to turn this on.
            print("Location wasn't given")
        }
    }
    
    
    // MAP
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard annotation is MKPointAnnotation else { return nil }

        let identifier = "Annotation"
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)

        if annotationView == nil {
            annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            annotationView!.canShowCallout = true
        } else {
            annotationView!.annotation = annotation
        }

        return annotationView
    }
    
    // MAP
    func checkLocationAuthorization() {
        switch CLLocationManager.authorizationStatus(){
        case .authorizedWhenInUse:
            self.showsUserLocation = true
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
