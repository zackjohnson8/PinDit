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
    var myAnnotations = [MKPointAnnotation]()
    
    func initialize()
    {
        delegate = self
    }

    
    func mapView(_ mapView: MKMapView, didUpdate: MKUserLocation)
    {
        guard let location = didUpdate.location else { return }
        myCenter = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
    }
    
    public func pinUserLocation(title: String, description: String)
    {
        // Add a list of annotations that then can be checked
        
        
        if let coor = self.userLocation.location?.coordinate
        {
            self.setCenter(coor, animated: true)
            
//            if(checkAnnotationProxToCurrentAnnotations(0.000070, 0.000055, coor))
//            {
//                print("Cannot add a new pin/annotation that close to another")
//                return
//            }
            
            let myLocation = MKPointAnnotation()
            myLocation.title = "My Location"
            myLocation.coordinate = coor
            self.addAnnotation(myLocation)
            myAnnotations.append(myLocation)
            //self.showAnnotations(myAnnotations, animated: false)
            
            print(myAnnotations.count)
        }
    }
    
    // Check if the passed in CLLocationCoordinate2D is within close proximity to other annotation/pins
    //    Lat 364,000 feet per degree = 364,000 / 18200 = 20
    //    Long 288,200 feet per degree = 288200 / 14410 = 20
    //    Which if we flip the division we end up with 0.05 for each value
    // TODO REMOVE?
    func checkAnnotationProxToCurrentAnnotations(_ acceptableLongitudeDist: Double, _ acceptableLatitudeDist: Double,_ currentLocation: CLLocationCoordinate2D) -> Bool
    {
        let lowerLimitLat = currentLocation.latitude - acceptableLatitudeDist
        let lowerLimitLong = currentLocation.longitude - acceptableLongitudeDist
        let upperLimitLat = currentLocation.latitude + acceptableLatitudeDist
        let upperLimitLong = currentLocation.longitude + acceptableLongitudeDist
        var coordHold:CLLocationCoordinate2D
        
        for annotation in myAnnotations {
            coordHold = annotation.coordinate
            if((coordHold.latitude < upperLimitLat && coordHold.latitude > lowerLimitLat)
                && (coordHold.longitude < upperLimitLong && coordHold.longitude > lowerLimitLong))
            {
                return true
            }
        }
        
        return false
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
