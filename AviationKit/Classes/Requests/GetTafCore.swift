//
//  GetBusinesses.swift
//  AviationKit
//
//  Created by Mike Silvers on 5/13/19.

//

import Foundation

/**
 Used to retrieve TAF's from a Aviation Weather API call.
 
 There are four supported parameters for this API call.  These API parameters are:
 * latitude: the search starting latitude
 * longitude: the search starting longitude
 * term: the search term
 * radius: the radius (in meters) to expand the search from the starting latitude and longitude.
 
 There are other accepted Aviation Weather API parameters, but these are the four this process is using.
 */
struct GetTafCore : NetworkingCodableProtocol {
    
    //MARK: - NetworkingCodableProtocol Values
    var headers: [String : String]? = nil
    var offsetLimit: OffsetLimit? = nil
    var baseUrl: URL = URL(string: Comms.url.metar)!
    var method: HTTPMethod = .get
    var urlParams: [String : String]? = [:]
    
    //MARK: - Request Specific Values:
    // As these are set, they are added to the parameters dictionary
    // for later use.
    var latitude : Double {
        didSet {
            if latitude != 0.0 && self.longitude != 0.0 {
                let param = "\(radiusInMiles);\(self.longitude),\(latitude)"
                self.urlParams?["radialDistance"] = "\(param)"
            }
        }
    }
    var longitude : Double {
        didSet {
            if self.latitude != 0.0 && longitude != 0.0 {
                let param = "\(radiusInMiles);\(longitude),\(self.latitude)"
                self.urlParams?["radialDistance"] = "\(param)"
            }
        }
    }
    var radiusInMiles : Int {
        didSet {
            if self.latitude != 0.0 && self.longitude != 0.0 {
                let param = "\(radiusInMiles);\(self.longitude),\(self.latitude)"
                self.urlParams?["radialDistance"] = "\(param)"
            }
        }
    }

    var dataSource : String {
        didSet {
            self.urlParams?["datasource"] = dataSource
        }
    }

    var mostRecent : Bool {
        didSet {
            self.urlParams?["mostRecent"] = "\(mostRecent)"
        }
    }

    var hoursBeforeNow : Int {
        didSet {
            self.urlParams?["hoursBeforeNow"] = "\(hoursBeforeNow)"
        }
    }
    
    var requestType : String {
        didSet {
            self.urlParams?["requesttype"] = requestType
        }
    }

    var dataFormat : String {
        didSet {
            self.urlParams?["format"] = dataFormat
        }
    }

    // MARK: - Initializers
    /**
     Initializes the object with the required parameters
     
     - Parameter searchTerm: The term used during the API search
     - Parameter longitude: The longitude for the starting point of the search
     - Parameter latitude: The latitude for the starting point of the search
     - Parameter radius: The distance (in meters) from the search point to include
     
     - Returns: A new business search request
     
    */
    init(radiusInMiles: Int=5, longitude: Double=0.0, latitude: Double=0.0, dataSource: String = "metars", requestType: String = "retrieve", dataFormat: String = "xml",mostRecent: Bool = true, hoursBeforeNow: Int = 3) {

        // initially set to the defaults
        self.longitude      = 0.0
        self.latitude       = 0.0
        self.radiusInMiles  = 5
        self.dataSource     = "metars"
        self.mostRecent     = true
        self.hoursBeforeNow = 3
        self.requestType    = "retrieve"
        self.dataFormat     = "xml"

        // after the object is initialized, perform the true initialization
        // this makes it so the "didSet" actually fire so the terms are saved in the parameter dictionary.  The parameter dictionary is used during requests.
        defer {
            self.longitude      = longitude
            self.latitude       = latitude
            self.radiusInMiles  = radiusInMiles
            self.dataSource     = dataSource
            self.mostRecent     = mostRecent
            self.hoursBeforeNow = hoursBeforeNow
            self.requestType    = requestType
            self.dataFormat     = dataFormat
        }
    }
    
}
