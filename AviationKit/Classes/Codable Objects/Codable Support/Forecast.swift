//
//  Forecast.swift
//  AviationKit
//
//  Created by Mike Silvers on 5/9/19.
//

import Foundation

/**
 This struct contains the forecast information returned by the report request.
 */
public struct Forecast : Codable {
    
    // MARK: - Variables to define the sky condition
    /// The timne the forecase is valid from - the start time ()
    public var validFromTime      : Int?
    /// The time the forecast is valid to - the end time ()
    public var validToTime        : Int?
    
    public var timeBecoming       : Int?
    public var probability        : Int?
    public var windDirection      : Int?
    public var windSpeed          : Int?
    public var windGust           : Int?
    public var windShearDirection : Int?
    public var windShearSpeed     : Int?
    public var windShearHeightAGL : Int?
    public var verticalVisibility : Int?
    
    public var visibility : Double?
    public var altimiter  : Double?
    
    public var weatherDescription : String?
    public var changeIndicator    : String?
    public var notDecoded         : String?
    
    public var temperature         : [Temperature]?
    public var skyCondition        : [SkyCondition]?
    public var icingCondition      : [IcingCondition]?
    public var turbulenceCondition : [TurbulenceCondition]?

    // MARK: - Coding Key enum
    enum CodingKeys: String, CodingKey {
        case validFromTime      = "time_from"
        case validToTime        = "time_to"
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
