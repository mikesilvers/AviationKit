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
    @discardableResult
    public func getReport<T>(_ params: T, _ testing: Bool? = false,_ completion: @escaping (_ result: [Any]?, Error?)->()) -> String? {

        switch params {
        case is MetarParams:
            
            var gmc = ReportCore()
                gmc.getReport(params)
            
            // the testing parameter is used for testing purposes - returns the URL and does not run the process
            if let t = testing, t == true {
                
                var url = gmc.baseUrl
                if let urlParms = gmc.urlParams {
                    url.appendQueryItems(urlParms)
                }
                
                if let offsetLimit = gmc.offsetLimit {
                    url.appendQueryItem(key: "offset", value: "\(offsetLimit.offset)")
                    url.appendQueryItem(key: "limit", value: "\(offsetLimit.limit)")
                }
                
                return url.absoluteString
                
            } else {

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
            

        default:
            completion(nil, nil)
        }
        
        return nil
        
    }
}
