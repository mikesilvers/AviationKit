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
    
    struct forecast {
        var vaidFromTime       : Int?
        var vaidToTime         : Int?
        var timeBecoming       : Int?
        var probability        : Int?
        var windDirection      : Int?
        var windSpeed          : Int?
        var windGust           : Int?
        var windShearDirection : Int?
        var windShearSpeed     : Int?
        var windShearHeightAGL : Int?
        var verticalVisibility : Int?
        
        var visibility : Double?
        var altimiter  : Double?
        
        var weatherDescription : String?
        var changeIndicator    : String?
        var notDecoded         : String?
        
        var temperatures        : [Temperature]?
        var skyCondition        : [SkyCondition]?
        var icingCondition      : [IcingCondition]?
        var turbulenceCondition : [TurbulenceCondition]?

    }

}
