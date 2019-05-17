//
//  Comms.swift
//  AviationKit
//
//  Created by Mike Silvers on 5/6/19.
//

import Foundation
import CoreLocation

public struct Comms {
    
    struct url {
        static let metar = "https://aviationweather.gov/adds/dataserver_current/"
        static let taf   = "https://aviationweather.gov/adds/dataserver_current/"
    }
    
    public init () {}
    
    public func getMETAR(_ centerPoint: CLLocationCoordinate2D, radiusInMiles: Int = 10, completion: @escaping (_ metar: [METAR])->()) {
        
        // refer to: https://www.aviationweather.gov/dataserver/example?datatype=metar
        let gmc = GetMetarCore(radiusInMiles: 3,
                               longitude: centerPoint.longitude,
                               latitude: centerPoint.latitude,
                               dataSource: "metar",
                               mostRecent: true,
                               hoursBeforeNow: 3)
        
        ProcessHTTP.shared.makeRequest(gmc,
                                       responseType: METAR.self,
                                       requestBody: EmptyJSON(),
                                       xmlParser: MetarParser(), nil) { (nil, result, response, data, error) in
                                        
                                        if let res = result as? [METAR] {
                                            completion(res)
                                        }
        }
    }
}
