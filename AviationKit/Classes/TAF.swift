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
    public var rawText   : String?
    public var stationId : String?
    public var remarks   : String?

    public var latitude  : Double?
    public var longitude : Double?

    public var elevation : Double?

    public var issueTime    : Int?
    public var bulletinTime : Int?
    public var fromTime     : Int?
    public var toTime       : Int?
    
    public var forecast : [Forecast]?

}
