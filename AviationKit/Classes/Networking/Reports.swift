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
    public func getReport<T>(_ params: T,_ completion: @escaping (_ result: [T]?, Error?)->()) {
        
        switch params {
        case is MetarParams:
            
            // process the METARS
            self.getMetarReport(params as! MetarParams, { (results, error) in
                // pass the completion on....
                completion(results as? [T],error)
            })
            
        default:
            completion(nil, nil)
        }
    }
}
