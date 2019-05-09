//
//  TAF.swift
//  AviationKit
//
//  Field Reference:  https://www.aviationweather.gov/dataserver/fields?datatype=taf
//
//  Created by Mike Silvers on 5/6/19.
//

import Foundation

public struct TAF : Codable {
    
    // MARK: variables used for the METAR object
    var rawText   : String?
    var stationId : String?
    var remarks   : String?

    var latitude  : Double?
    var longitude : Double?

    var elevation : Double?

    var issueTime    : Int?
    var bulletinTime : Int?
    var fromTime     : Int?
    var toTime       : Int?
    
    var forecast : [Forecast]?

}
