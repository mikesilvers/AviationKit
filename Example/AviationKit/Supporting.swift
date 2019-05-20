//
//  Supporting.swift
//  AviationKit_Example
//
//  Created by Mike Silvers on 5/19/19.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import UIKit
import Foundation
import CoreLocation

struct DisplayMessages {
    
    static func requestLocation(_ viewController: UIViewController,_ locationManager: CLLocationManager ,_ title: String = "",_ message: String = "") {
        
        var newTitle = ""
        if title.isEmpty { newTitle = "Requesting Location Access" } else { newTitle = title }

        var newMessage = ""
        if message.isEmpty {
            newMessage = "We need your permission to use your location.\n\nThis will allow us to find weather reports from airports near you.\n\nWhen the Apple prompt displays, please say \"Allow\" when is use.  Thanks!"
        } else { newMessage = message }
        
        let alert = UIAlertController(title: newTitle, message: newMessage, preferredStyle: .alert)

        alert.addAction(UIAlertAction(title: "Yup!", style: .default, handler: { (action) in
            locationManager.requestWhenInUseAuthorization()
        }))

        alert.addAction(UIAlertAction(title: "No :(", style: .cancel, handler: nil))

        DispatchQueue.main.async {
            viewController.present(alert, animated: true, completion: nil)
        }
    }

    static func deniedLocation(_ viewController: UIViewController,_ locationManager: CLLocationManager ,_ title: String = "",_ message:  String = "") {
        
        var newTitle = ""
        if title.isEmpty { newTitle = "Requesting Location Access: Oops" } else { newTitle = title }
        
        var newMessage = ""
        if message.isEmpty {
            newMessage = "We need your permission to use your location.\n\nSomehow you are not permitting location services.\n\nPlease change in your settings.  Because we like you, we will open your settings right away!."
        } else { newMessage = message }
        
        let alert = UIAlertController(title: newTitle, message: newMessage, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Yup!", style: .default, handler: { (action) in

            // directly open the settings for the app so they may change location settings
            if let url = URL(string:UIApplication.openSettingsURLString) {
                if UIApplication.shared.canOpenURL(url) {
                    UIApplication.shared.open(url, options: [:], completionHandler: nil)
                }
            }
        }))
        alert.addAction(UIAlertAction(title: "No :(", style: .cancel, handler: nil))

        DispatchQueue.main.async {
            viewController.present(alert, animated: true, completion: nil)
        }
    }

}
