//
//  METAR.swift
//  AviationKit
//
//  Created by Mike Silvers on 5/6/19.
//

import Foundation

public struct METAR : Codable {
    
    var rawText              : String?
    var stationId            : String?
    
    var observationTime      : Int?
    
    var latitude             : Double?
    var longitude            : Double?
    
    var temperature          : Double?
    var dewpoint             : Double?
    
    var windDirection        : Int?
    var windSpeed            : Int?
    var windGust             : Int?
    var visibility           : Double?
    var altimiter            : Double?
    
    var noSignal             : Bool = false
    var autoRecord           : Bool = false
    var autoStation          : Bool = false
    var presentWeatherSensor : Bool = false
    
    var skyCondition         : [SkyCondition]?
    
    var metarType            : String?
    var flightCategory       : String?
    
    var elevation            : Double?
    
    enum CodingKeys: String, CodingKey {
        
        case rawText              = "raw_text"
        case stationId            = "station_id"
        case observationTime      = "observation_time"
        case temperature          = "temp_c"
        case dewpoint             = "dewpoint_c"
        case windDirection        = "wind_dir_degrees"
        case windSpeed            = "wind_speed_kt"
        case windGust             = "wind_gust_kt"
        case altimiter            = "altim_in_hg"
        case metarType            = "metar_type"
        case elevation            = "elevation_m"
        case flightCategory       = "flight_category"
        case visibility           = "visibility_statute_mi"
        
        case skyCondition         = "sky_condition"
        case qualityControlFlags  = "quality_control_flags"

        case latitude, longitude
        
    }
    
    enum QualityControlFlagsKeys: String, CodingKey {

        case noSignal             = "no_signal"
        case autoRecord           = "auto"
        case autoStation          = "auto_station"
        case presentWeatherSensor = "present_weather_sensor_off"

    }
    
    public init() {
        
    }
    
    public init(from decoder: Decoder) throws {
        
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        rawText      = try values.decode(String.self, forKey: .rawText)
        stationId    = try values.decode(String.self, forKey: .stationId)
        metarType    = try values.decode(String.self, forKey: .metarType)

        latitude    = try values.decode(Double.self, forKey: .latitude)
        longitude   = try values.decode(Double.self, forKey: .longitude)
        temperature = try values.decode(Double.self, forKey: .temperature)
        dewpoint    = try values.decode(Double.self, forKey: .dewpoint)
        altimiter   = try values.decode(Double.self, forKey: .altimiter)
        elevation   = try values.decode(Double.self, forKey: .elevation)

        windDirection = try values.decode(Int.self, forKey: .windDirection)
        windSpeed     = try values.decode(Int.self, forKey: .windSpeed)
        windGust      = try values.decode(Int.self, forKey: .windGust)

        skyCondition = try values.decode([SkyCondition].self, forKey: .skyCondition)

        let qualityControlFlags = try values.nestedContainer(keyedBy: QualityControlFlagsKeys.self, forKey: .qualityControlFlags)
        
        autoRecord           = try qualityControlFlags.decode(Bool.self, forKey: .autoRecord)
        autoStation          = try qualityControlFlags.decode(Bool.self, forKey: .autoStation)
        presentWeatherSensor = try qualityControlFlags.decode(Bool.self, forKey: .presentWeatherSensor)
        
    }
    
    public func encode(to encoder: Encoder) throws {
        
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(rawText, forKey: .rawText)
        try container.encode(stationId, forKey: .stationId)
        try container.encode(skyCondition, forKey: .skyCondition)
        try container.encode(metarType, forKey: .metarType)
        
        try container.encode(latitude, forKey: .latitude)
        try container.encode(longitude, forKey: .longitude)
        try container.encode(temperature, forKey: .temperature)
        try container.encode(dewpoint, forKey: .dewpoint)
        try container.encode(altimiter, forKey: .altimiter)
        try container.encode(elevation, forKey: .elevation)
        
        try container.encode(windDirection, forKey: .windDirection)
        try container.encode(windSpeed, forKey: .windSpeed)
        try container.encode(windGust, forKey: .windGust)

        var qualityControlFlags = container.nestedContainer(keyedBy: QualityControlFlagsKeys.self, forKey: .qualityControlFlags)
        
        try qualityControlFlags.encode(autoRecord, forKey: .autoRecord)
        try qualityControlFlags.encode(autoStation, forKey: .autoStation)
        try qualityControlFlags.encode(presentWeatherSensor, forKey: .presentWeatherSensor)
        
    }
}
