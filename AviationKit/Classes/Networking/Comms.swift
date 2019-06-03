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
        static let taf     = "https://aviationweather.gov/adds/dataserver_current/httpparam"
        static let metar   = "https://aviationweather.gov/adds/dataserver_current/httpparam"
    }
    
    //MARK: - initializers
    public init () {}
    
    //MARK: - Get Functions
    /**
     Retrieves the METAR reports.
     
     Retrieves METAR reports according to a center point and a radius in miles.
     
     - Parameter centerPoint: The latitude and longitude for the search center point.
     - Parameter radiusInMiles: The radius from the centerpoint for the search
     - Parameter completion (metar): The array of METAR's returned by the completion block.
     - Parameter completion (Error): The optional error object in the completion object.
     
    */
    
    @available(*, deprecated, message: "Use Reports.getReports(struct) with the MetarParams structure for the report.")
    public func getMETAR(_ centerPoint: CLLocationCoordinate2D,
                         _ radiusInMiles: Int = 10,
                         completion: @escaping (_ metar: [METAR], Error?)->()) {
        
        // refer to: https://www.aviationweather.gov/dataserver/example?datatype=metar
        let gmc = GetMetarCore(radiusInMiles: radiusInMiles,
                               longitude: centerPoint.longitude,
                               latitude: centerPoint.latitude,
                               hoursBeforeNow: 3,
                               mostRecent: false)

        // perform the actual get request using the networking functionality
        ProcessHTTP.shared.makeRequest(gmc,
                                       responseType: METAR.self,
                                       requestBody: EmptyJSON(),
                                       xmlParser: MetarParser(), nil) { (nil, result, response, data, error) in
                                        
                                            if let res = result as? [METAR] {
                                                completion(res, error)
                                            }
                                        }
                        }
    
    /**
     Retrieves the TAF reports.
     
     Retrieves TAF reports according to a center point and a radius in miles.
     
     - Parameter centerPoint: The latitude and longitude for the search center point.
     - Parameter radiusInMiles: The radius from the centerpoint for the search
     - Parameter completion (metar): The array of TAF's returned by the completion block.
     - Parameter completion (Error): The optional error object in the completion object.
     */
    @available(*, deprecated, message: "Use Reports.getReports(struct) with the TafParams structure for the report.")
    public func getTAF(_ centerPoint: CLLocationCoordinate2D,
                       _ radiusInMiles: Int = 10,
                       completion: @escaping (_ metar: [TAF], Error?)->()) {
        
        // refer to: https://www.aviationweather.gov/dataserver/example?datatype=taf
        let gmc = GetTafCore(radiusInMiles: radiusInMiles,
                               longitude: centerPoint.longitude,
                               latitude: centerPoint.latitude,
                               hoursBeforeNow: 3,
                               mostRecent: false)
        
        // perform the actual get request using the networking functionality
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
