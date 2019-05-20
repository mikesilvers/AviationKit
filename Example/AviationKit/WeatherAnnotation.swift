//
//  WeatherAnnotation.swift
//  AviationKit_Example
//
//  Created by Mike Silvers on 5/20/19.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class WeatherAnnotation: NSObject, MKAnnotation {

    @objc dynamic var coordinate: CLLocationCoordinate2D
    
    var title: String?
    
    var subtitle: String?
    
    override init() {
        
        self.title      = ""
        self.subtitle   = ""
        self.coordinate = CLLocationCoordinate2D(latitude: 0.0, longitude: 0.0)
        
        super.init()

    }
    
}
