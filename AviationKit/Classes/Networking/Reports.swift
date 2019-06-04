//
//  Reports.swift
//  AviationKit
//
//  Created by Mike Silvers on 6/3/19.
//

import Foundation

public struct Reports {
    
    struct url {
        static let reports = "https://aviationweather.gov/adds/dataserver_current/httpparam"
    }
    
    //MARK: - initializers
    public init () {}
    
    //MARK: - Generic Get Functions
    public func getReport<T>(_ params: T,_ completion: @escaping (_ result: [Any]?, Error?)->()) {
        
        switch params {
        case is MetarParams:
            
            var gmc = ReportCore()
                gmc.getReport(params)
            
            // perform the actual get request using the networking functionality
            ProcessHTTP.shared.makeRequest(gmc,
                                           responseType: METAR.self,
                                           requestBody: EmptyJSON(),
                                           xmlParser: MetarParser(), nil) { (nil, result, response, data, error) in
                                            
                                            if let res = result as? [METAR] {
                                                completion(res, error)
                                            }
            }

        default:
            completion(nil, nil)
        }
    }
}
