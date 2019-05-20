//
//  Ext.mvc.locationDelegate.swift
//  AviationKit_Example
//
//  Created by Mike Silvers on 5/20/19.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import MapKit
import Foundation
import CoreLocation

extension MainViewController: CLLocationManagerDelegate {
    
    func locationManagerDidResumeLocationUpdates(_ manager: CLLocationManager) {
        manager.requestLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            manager.startUpdatingLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let location = locations.last! as CLLocation
        
        if lastLocation.latitude == 0.0, lastLocation.longitude == 0.0 {
            
            lastLocation = location.coordinate
            
            // if this is the first one, set to the center
            if initialLocation.latitude == 0.0, initialLocation.longitude == 0.0 {
                
                initialLocation = location.coordinate
                
                let region = getRegion((Double(milesRadius) * 2.0), location.coordinate)
                
                //set region on the map
                mapView.setRegion(region, animated: true)
                
            }

        } else if (lastLocation.latitude != location.coordinate.latitude) || (lastLocation.longitude != location.coordinate.longitude) {
            lastLocation = location.coordinate
        }

    }
    
    func getRegion(_ miles: Double,_ centerCoordinate: CLLocationCoordinate2D) -> MKCoordinateRegion {
        return MKCoordinateRegion(center: centerCoordinate,
            latitudinalMeters: milesToMeters(miles),
            longitudinalMeters: milesToMeters(miles)
        )
    }
    
    func milesToMeters(_ miles: Double) -> Double {
        return 1609.344 * miles
    }
    
}
