//
//  GetBusinesses.swift
//  WeedmapsChallenge
//
//  Created by Mike Silvers on 5/13/19.
//  Copyright © 2019 Weedmaps, LLC. All rights reserved.
//

import Foundation

/**
 Used to retrieve METAR's from a Aviation Weather API call.
 
 There are four supported parameters for this API call.  These API parameters are:
 * latitude: the search starting latitude
 * longitude: the search starting longitude
 * term: the search term
 * radius: the radius (in meters) to expand the search from the starting latitude and longitude.
 
 There are other accepted Aviation Weather API parameters, but these are the four this process is using.
 */
struct GetMetarCore : NetworkingCodableProtocol {
    
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
            self.urlParams?["latitude"] = "\(latitude)"
        }
    }
    var longitude : Double {
        didSet {
            self.urlParams?["longitude"] = "\(longitude)"
        }
    }
    var radiusInMiles : Int {
        didSet {
            self.urlParams?["radialDistance"] = "\(radiusInMiles)"
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

    // MARK: - Initializers
    /**
     Initializes the object with the required parameters
     
     - Parameter searchTerm: The term used during the API search
     - Parameter longitude: The longitude for the starting point of the search
     - Parameter latitude: The latitude for the starting point of the search
     - Parameter radius: The distance (in meters) from the search point to include
     
     - Returns: A new business search request
     
    */
    init(radiusInMiles: Int=5, longitude: Double=0.0, latitude: Double=0.0, dataSource: String="metars",mostRecent: Bool = true, hoursBeforeNow: Int = 3) {

        // initially set to the defaults
        self.radiusInMiles  = 5
        self.longitude      = 0.0
        self.latitude       = 0.0
        self.dataSource     = "metars"
        self.mostRecent     = true
        self.hoursBeforeNow = 3

        // after the object is initialized, perform the true initialization
        // this makes it so the "didSet" actually fire so the terms are saved in the parameter dictionary.  The parameter dictionary is used during requests.
        defer {
            self.radiusInMiles  = radiusInMiles
            self.longitude      = longitude
            self.latitude       = latitude
            self.dataSource     = dataSource
            self.mostRecent     = mostRecent
            self.hoursBeforeNow = hoursBeforeNow
        }
    }
    
}
