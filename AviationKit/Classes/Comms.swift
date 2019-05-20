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
        static let metar = "https://aviationweather.gov/adds/dataserver_current/httpparam"
        static let taf   = "https://aviationweather.gov/adds/dataserver_current/httpparam"
    }
    
    public init () {}
    
    public func getMETAR(_ centerPoint: CLLocationCoordinate2D,_ radiusInMiles: Int = 10, completion: @escaping (_ metar: [METAR], Error?)->()) {
        
        // refer to: https://www.aviationweather.gov/dataserver/example?datatype=metar
        let gmc = GetMetarCore(radiusInMiles: radiusInMiles,
                               longitude: centerPoint.longitude,
                               latitude: centerPoint.latitude,
                               dataSource: "metars",
                               mostRecent: false,
                               hoursBeforeNow: 3)
        
        ProcessHTTP.shared.makeRequest(gmc,
                                       responseType: METAR.self,
                                       requestBody: EmptyJSON(),
                                       xmlParser: MetarParser(), nil) { (nil, result, response, data, error) in
                                        
                                            if let res = result as? [METAR] {
                                                completion(res, error)
                                            }
                                        }
                        }
    

    public func getTAF(_ centerPoint: CLLocationCoordinate2D,_ radiusInMiles: Int = 10, completion: @escaping (_ metar: [TAF], Error?)->()) {
        
        // refer to: https://www.aviationweather.gov/dataserver/example?datatype=taf
        let gmc = GetTafCore(radiusInMiles: radiusInMiles,
                               longitude: centerPoint.longitude,
                               latitude: centerPoint.latitude,
                               dataSource: "tafs",
                               mostRecent: false,
                               hoursBeforeNow: 3)
        
        ProcessHTTP.shared.makeRequest(gmc,
                                       responseType: TAF.self,
                                       requestBody: EmptyJSON(),
                                       xmlParser: TafParser(), nil) { (nil, result, response, data, error) in
                                        
                                        if let res = result as? [TAF] {
                                            completion(res, error)
                                        }
        }
    }

}
