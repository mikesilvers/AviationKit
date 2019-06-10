//
//  METAR.swift
//  AviationKit
//
//  Field Reference:  https://www.aviationweather.gov/dataserver/fields?datatype=metar
//
//  Created by Mike Silvers on 5/6/19.
//

import Foundation

/**
 The struct *METAR* represents a METAR object.
 This object is *codable* to allow easy manipulaition with JSON.
 */
public struct METAR : Codable {
    
    // MARK: - Variables used for the METAR object
    
    /// The raw METAR (raw_text)
    public var rawText              : String?
    /// Station identifier; Always a four character alphanumeric( A-Z, 0-9) (station_id)
    public var stationId            : String?
    
    /// Time( in Epoch format) this METAR was observed. (observation_time)
    public var observationTime      : Int?
    
    /// The latitude (in decimal degrees )of the station that reported this METAR (latitude)
    public var latitude             : Double?
    /// The longitude (in decimal degrees )of the station that reported this METAR (longitude)
    public var longitude            : Double?
    
    /// The air temperature (temp_c)
    public var temperature                 : Double?
    /// Minimum air temperature from the past 6 hours (minT_c)
    public var sixHourMinTemp              : Double?
    /// Maximum air temperature from the past 6 hours (maxT_c)
    public var sixHourMaxTemp              : Double?
    /// Maximum air temperature from the past 24 hours (maxT24hr_c)
    public var twentyFourHourTempMax       : Double?
    /// Minimum air temperature from the past 24 hours (minT24hr_c)
    public var twentyFourHourTempMin       : Double?
    /// Dewpoint temperature (dewpoint_c)
    public var dewpoint                    : Double?
    /// Snow depth on the ground (snow_in)
    public var snow                        : Double?
    /// Liquid precipitation since the last regular METAR (precip_in)
    public var precipitation               : Double?
    /// Liquid precipitation from the past 3 hours. 0.0005 in = trace precipitation (pcp3hr_in)
    public var precipitationThreeHour      : Double?
    /// Liquid precipitation from the past 6 hours. 0.0005 in = trace precipitation (pcp6hr_in)
    public var precipitationSixHour        : Double?
    /// Liquid precipitation from the past 24 hours. 0.0005 in = trace precipitation (pcp24hr_in)
    public var precipitationTwentyFourHour : Double?

    /// Direction from which the wind is blowing.  0 degrees=variable wind direction. (wind_dir_degrees)
    public var windDirection        : Int?
    /// Wind speed; 0 degree wdir and 0 wspd = calm winds (wind_speed_kt)
    public var windSpeed            : Int?
    /// Wind gust (wind_gust_kt)
    public var windGust             : Int?
    /// Vertical Visibility (vert_vis_ft)
    public var verticalVisibility   : Int?
    /// Horizontal visibility (visibility_statute_mi)
    public var visibility           : Double?
    /// Altimiter (altim_in_hg)
    public var altimiter            : Double?
    /// The elevation of the station that reported this METAR (elevation_m)
    public var elevation            : Double?
    /// Sea-level pressure (sea_level_pressure_mb)
    public var sealevelPressure     : Double?
    /// Pressure change in the past 3 hours (three_hr_pressure_tendency_mb)
    public var threeHourPressure    : Double?

    /// Corrected (corrected)
    public var correctedRecord         : Bool = false
    /// No signal (no_signal)
    public var noSignal                : Bool = false
    /// Fully automated (auto)
    public var autoRecord              : Bool = false
    /// Indicates that the automated station type is one of the following: A01|A01A|A02|A02A|AOA|AWOS  NOTE: The type of station is not returned. This simply indicates that this station is one of the six stations enumerated above. (auto_station)
    public var autoStation             : Bool = false
    /// Maintenance check indicator - maintenance is needed (maintenance_indicator)
    public var maintenance             : Bool = false
    /// The lightning detection sensor is not operating- thunderstorm information is not available. (lightning_sensor_off)
    public var lightningSensorOff      : Bool = false
    /// The freezing rain sensor is not operating (freezing_rain_sensor_off)
    public var freezingRainSensorOff   : Bool = false
    /// The present weather sensor is not operating (present_weather_sensor_off)
    public var presentWeatherSensorOff : Bool = false

    /// Sky condition object (sky_condition)
    public var skyCondition         : [SkyCondition]?
    
    /// Weather strings to symbols: https://www.aviationweather.gov/docs/metar/wxSymbols_anno2.pdf (wx_string)
    public var weatherDescription   : String?
    /// METAR or SPECI (metar_type)
    public var metarType            : String?
    /// Flight category of this METAR. Values: VFR|MVFR|IFR|LIFR  See http://www.aviationweather.gov/metar/help?page=plot#fltcat (flight_category)
    public var flightCategory       : String?
    
    // MARK: - Coding Key enums to process the codable
    /**
     The CodingKeys to define the overall JSON document
    */
    enum CodingKeys: String, CodingKey {
        
        case rawText                     = "raw_text"
        case stationId                   = "station_id"
        case observationTime             = "observation_time"
        case temperature                 = "temp_c"
        case dewpoint                    = "dewpoint_c"
        case windDirection               = "wind_dir_degrees"
        case windSpeed                   = "wind_speed_kt"
        case windGust                    = "wind_gust_kt"
        case altimiter                   = "altim_in_hg"
        case metarType                   = "metar_type"
        case elevation                   = "elevation_m"
        case flightCategory              = "flight_category"
        case visibility                  = "visibility_statute_mi"
        case precipitation               = "precip_in"
        case verticalVisibility          = "vert_vis_ft"
        
        case sealevelPressure            = "sea_level_pressure_mb"
        case threeHourPressure           = "three_hr_pressure_tendency_mb"
        case sixHourMaxTemp              = "maxT_c"
        case sixHourMinTemp              = "minT_c"
        case twentyFourHourTempMax       = "maxT24hr_c"
        case twentyFourHourTempMin       = "minT24hr_c"
        case precipitationThreeHour      = "pcp3hr_in"
        case precipitationSixHour        = "pcp6hr_in"
        case precipitationTwentyFourHour = "pcp24hr_in"
        case snow                        = "snow_in"
        case weatherDescription          = "wx_string"
        
        case skyCondition        = "sky_condition"
        case qualityControlFlags = "quality_control_flags"

        case latitude, longitude
        
    }
    
    /**
     This enum processes the quality control section of the JSON
    */
    enum QualityControlFlagsKeys: String, CodingKey {

        case correctedRecord         = "corrected"
        case noSignal                = "no_signal"
        case autoRecord              = "auto"
        case autoStation             = "auto_station"
        case maintenance             = "maintenance_indicator_on"
        case lightningSensorOff      = "lightning_sensor_off"
        case freezingRainSensorOff   = "freezing_rain_sensor_off"
        case presentWeatherSensorOff = "present_weather_sensor_off"

    }
    
    // MARK: - Initializers
    public init() { }
    
    public init(from decoder: Decoder) throws {
        
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        rawText            = try values.decode(String.self, forKey: .rawText)
        stationId          = try values.decode(String.self, forKey: .stationId)
        metarType          = try values.decode(String.self, forKey: .metarType)
        weatherDescription = try? values.decode(String.self, forKey: .weatherDescription)

        latitude                    = try values.decode(Double.self, forKey: .latitude)
        longitude                   = try values.decode(Double.self, forKey: .longitude)
        temperature                 = try values.decode(Double.self, forKey: .temperature)
        dewpoint                    = try values.decode(Double.self, forKey: .dewpoint)
        altimiter                   = try values.decode(Double.self, forKey: .altimiter)
        elevation                   = try values.decode(Double.self, forKey: .elevation)
        precipitation               = try? values.decode(Double.self, forKey: .precipitation)
        sealevelPressure            = try? values.decode(Double.self, forKey: .sealevelPressure)
        threeHourPressure           = try? values.decode(Double.self, forKey: .threeHourPressure)
        sixHourMaxTemp              = try? values.decode(Double.self, forKey: .sixHourMaxTemp)
        sixHourMinTemp              = try? values.decode(Double.self, forKey: .sixHourMinTemp)
        twentyFourHourTempMax       = try? values.decode(Double.self, forKey: .twentyFourHourTempMax)
        twentyFourHourTempMin       = try? values.decode(Double.self, forKey: .twentyFourHourTempMin)
        precipitationThreeHour      = try? values.decode(Double.self, forKey: .precipitationThreeHour)
        precipitationSixHour        = try? values.decode(Double.self, forKey: .precipitationSixHour)
        precipitationTwentyFourHour = try? values.decode(Double.self, forKey: .precipitationTwentyFourHour)
        snow                        = try? values.decode(Double.self, forKey: .snow)

        windSpeed          = try values.decode(Int.self, forKey: .windSpeed)
        windGust           = try values.decode(Int.self, forKey: .windGust)
        windDirection      = try values.decode(Int.self, forKey: .windDirection)
        verticalVisibility = try values.decode(Int.self, forKey: .verticalVisibility)

        skyCondition = try values.decode([SkyCondition].self, forKey: .skyCondition)

        let qualityControlFlags = try values.nestedContainer(keyedBy: QualityControlFlagsKeys.self, forKey: .qualityControlFlags)
        
        correctedRecord         = try qualityControlFlags.decode(Bool.self, forKey: .correctedRecord)
        autoRecord              = try qualityControlFlags.decode(Bool.self, forKey: .autoRecord)
        autoStation             = try qualityControlFlags.decode(Bool.self, forKey: .autoStation)
        maintenance             = try qualityControlFlags.decode(Bool.self, forKey: .maintenance)
        lightningSensorOff      = try qualityControlFlags.decode(Bool.self, forKey: .lightningSensorOff)
        freezingRainSensorOff   = try qualityControlFlags.decode(Bool.self, forKey: .freezingRainSensorOff)
        presentWeatherSensorOff = try qualityControlFlags.decode(Bool.self, forKey: .presentWeatherSensorOff)

    }
    
    // MARK: - The encoder
    public func encode(to encoder: Encoder) throws {
        
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(rawText, forKey: .rawText)
        try container.encode(stationId, forKey: .stationId)
        try container.encode(skyCondition, forKey: .skyCondition)
        try container.encode(metarType, forKey: .metarType)
        try container.encode(weatherDescription, forKey: .weatherDescription)
        
        try container.encode(latitude, forKey: .latitude)
        try container.encode(longitude, forKey: .longitude)
        try container.encode(temperature, forKey: .temperature)
        try container.encode(dewpoint, forKey: .dewpoint)
        try container.encode(altimiter, forKey: .altimiter)
        try container.encode(elevation, forKey: .elevation)
        try container.encode(precipitation, forKey: .precipitation)
        
        try container.encode(windSpeed, forKey: .windSpeed)
        try container.encode(windGust, forKey: .windGust)
        try container.encode(windDirection, forKey: .windDirection)
        try container.encode(verticalVisibility, forKey: .verticalVisibility)

        try container.encode(sealevelPressure, forKey: .sealevelPressure)
        try container.encode(threeHourPressure, forKey: .threeHourPressure)
        try container.encode(sixHourMaxTemp, forKey: .sixHourMaxTemp)
        try container.encode(sixHourMinTemp, forKey: .sixHourMinTemp)
        try container.encode(twentyFourHourTempMax, forKey: .twentyFourHourTempMax)
        try container.encode(twentyFourHourTempMin, forKey: .twentyFourHourTempMin)
        try container.encode(precipitationThreeHour, forKey: .precipitationThreeHour)
        try container.encode(precipitationSixHour, forKey: .precipitationSixHour)
        try container.encode(precipitationTwentyFourHour, forKey: .precipitationTwentyFourHour)
        try container.encode(snow, forKey: .snow)

        var qualityControlFlags = container.nestedContainer(keyedBy: QualityControlFlagsKeys.self, forKey: .qualityControlFlags)
        
        try qualityControlFlags.encode(autoRecord, forKey: .autoRecord)
        try qualityControlFlags.encode(autoStation, forKey: .autoStation)
        try qualityControlFlags.encode(maintenance, forKey: .maintenance)
        try qualityControlFlags.encode(correctedRecord, forKey: .correctedRecord)
        try qualityControlFlags.encode(lightningSensorOff, forKey: .lightningSensorOff)
        try qualityControlFlags.encode(freezingRainSensorOff, forKey: .freezingRainSensorOff)
        try qualityControlFlags.encode(presentWeatherSensorOff, forKey: .presentWeatherSensorOff)

    }
}
