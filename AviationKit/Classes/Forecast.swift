//
//  Forecast.swift
//  AviationKit
//
//  Created by Mike Silvers on 5/9/19.
//

import Foundation

/**
 This struct contains the icing condition information.
 */
public struct Forecast : Codable {
    
    // MARK: variables to define the sky condition
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
    
    var temperature         : [Temperature]?
    var skyCondition        : [SkyCondition]?
    var icingCondition      : [IcingCondition]?
    var turbulenceCondition : [TurbulenceCondition]?

    // MARK: Coding Key enum
    enum CodingKeys: String, CodingKey {
        case vaidFromTime       = "time_from"
        case vaidToTime         = "time_to"
        case timeBecoming       = "time_becoming"
        case probability        = "probability"
        case windDirection      = "wind_dir_degrees"
        case windSpeed          = "wind_speed_kt"
        case windGust           = "wing_gust_kt"
        case windShearDirection = "wind_shear_dir_degrees"
        case windShearSpeed     = "wind_shear_speed_kt"
        case windShearHeightAGL = "wind_shear_hgt_ft_agl"
        case verticalVisibility = "vert_vis_ft"
        case visibility         = "visibility_statute_mi"
        case altimiter          = "altim_in_hg"
        case weatherDescription = "wx_string"
        case changeIndicator    = "change_indicator"
        case notDecoded         = "not_decoded"
    }
}
