//
//  MetarParser.swift
//  AviationKit
//
//  Created by Mike Silvers on 5/7/19.
//

import Foundation

public class MetarParser : NSObject, XMLParserDelegate {

    public var demoMETAR : String {
        get {
            var st = "<?xml version=\"1.0\" encoding=\"UTF-8\"?>"
            st.append("<response xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:xsi=\"http://www.w3.org/2001/XML-Schema-instance\" version=\"1.2\" ")
            st.append("xsi:noNamespaceSchemaLocation=\"http://aviationweather.gov/adds/schema/metar1_2.xsd\"> ")
            st.append("<request_index>45459668</request_index> ")
            st.append("<data_source name=\"metars\" /> ")
            st.append("<request type=\"retrieve\" /> ")
            st.append("<errors /> ")
            st.append("<warnings /> ")
            st.append("<time_taken_ms>538</time_taken_ms> ")
            st.append("<data num_results=\"5092\"> ")
            st.append("<METAR> ")
            st.append("<raw_text>K0CO 061606Z AUTO 29024G30KT CLR 00/M04 A3025 RMK AO2 PWINO</raw_text> ")
            st.append("<station_id>K0CO</station_id> ")
            st.append("<observation_time>2019-05-06T16:06:00Z</observation_time> ")
            st.append("<latitude>39.8</latitude> ")
            st.append("<longitude>-105.77</longitude> ")
            st.append("<temp_c>0.0</temp_c> ")
            st.append("<dewpoint_c>-4.0</dewpoint_c> ")
            st.append("<wind_dir_degrees>290</wind_dir_degrees> ")
            st.append("<wind_speed_kt>24</wind_speed_kt> ")
            st.append("<wind_gust_kt>30</wind_gust_kt> ")
            st.append("<altim_in_hg>30.250984</altim_in_hg> ")
            st.append("<quality_control_flags> ")
            st.append("<auto>TRUE</auto> ")
            st.append("<auto_station>TRUE</auto_station> ")
            st.append("<present_weather_sensor_off>TRUE</present_weather_sensor_off> ")
            st.append("</quality_control_flags> ")
            st.append("<sky_condition sky_cover=\"CLR\" /> ")
            st.append("<metar_type>METAR</metar_type> ")
            st.append("<elevation_m>3807.0</elevation_m> ")
            st.append("</METAR> ")
            
            st.append("<METAR> ")
            st.append("<raw_text>PAVC 061604Z AUTO 08007KT 10SM BKN022 BKN029 OVC037 04/03 A2941 RMK AO2 RAE03 P0000</raw_text> ")
            st.append("<station_id>PAVC</station_id> ")
            st.append("<observation_time>2019-05-06T16:04:00Z</observation_time> ")
            st.append("<latitude>55.12</latitude> ")
            st.append("<longitude>-162.27</longitude> ")
            st.append("<temp_c>4.0</temp_c> ")
            st.append("<dewpoint_c>3.0</dewpoint_c> ")
            st.append("<wind_dir_degrees>80</wind_dir_degrees> ")
            st.append("<wind_speed_kt>7</wind_speed_kt> ")
            st.append("<visibility_statute_mi>10.0</visibility_statute_mi> ")
            st.append("<altim_in_hg>29.409449</altim_in_hg> ")
            st.append("<quality_control_flags> ")
            st.append("<auto>TRUE</auto> ")
            st.append("<auto_station>TRUE</auto_station> ")
            st.append("</quality_control_flags> ")
            st.append("<sky_condition sky_cover=\"BKN\" cloud_base_ft_agl=\"2200\" /> ")
            st.append("<sky_condition sky_cover=\"BKN\" cloud_base_ft_agl=\"2900\" /> ")
            st.append("<sky_condition sky_cover=\"OVC\" cloud_base_ft_agl=\"3700\" /> ")
            st.append("<flight_category>MVFR</flight_category> ")
            st.append("<precip_in>0.005</precip_in> ")
            st.append("<metar_type>SPECI</metar_type> ")
            st.append("<elevation_m>47.0</elevation_m> ")
            st.append("</METAR> ")

            st.append("<METAR> ")
            st.append("<raw_text>KOTH 061604Z 01010KT 10SM OVC004 09/08 A2999 RMK AO2 PNO $</raw_text> ")
            st.append("<station_id>KOTH</station_id> ")
            st.append("<observation_time>2019-05-06T16:04:00Z</observation_time> ")
            st.append("<latitude>43.42</latitude> ")
            st.append("<longitude>-124.25</longitude> ")
            st.append("<temp_c>9.0</temp_c> ")
            st.append("<dewpoint_c>8.0</dewpoint_c> ")
            st.append("<wind_dir_degrees>10</wind_dir_degrees> ")
            st.append("<wind_speed_kt>10</wind_speed_kt> ")
            st.append("<visibility_statute_mi>10.0</visibility_statute_mi> ")
            st.append("<altim_in_hg>29.991142</altim_in_hg> ")
            st.append("<quality_control_flags> ")
            st.append("<auto_station>TRUE</auto_station> ")
            st.append("<maintenance_indicator_on>TRUE</maintenance_indicator_on> ")
            st.append("</quality_control_flags> ")
            st.append("<sky_condition sky_cover=\"OVC\" cloud_base_ft_agl=\"400\" /> ")
            st.append("<flight_category>LIFR</flight_category> ")
            st.append("<metar_type>SPECI</metar_type> ")
            st.append("<elevation_m>4.0</elevation_m> ")
            st.append("</METAR> ")
            
            st.append("<METAR> ")
            st.append("<raw_text>PAVC 061604Z AUTO 08007KT 10SM BKN022 BKN029 OVC037 04/03 A2941 RMK AO2 RAE03 P0000</raw_text> ")
            st.append("<station_id>PAVC</station_id> ")
            st.append("<observation_time>2019-05-06T16:04:00Z</observation_time> ")
            st.append("<latitude>55.12</latitude> ")
            st.append("<longitude>-162.27</longitude> ")
            st.append("<temp_c>4.0</temp_c> ")
            st.append("<dewpoint_c>3.0</dewpoint_c> ")
            st.append("<wind_dir_degrees>80</wind_dir_degrees> ")
            st.append("<wind_speed_kt>7</wind_speed_kt> ")
            st.append("<visibility_statute_mi>10.0</visibility_statute_mi> ")
            st.append("<altim_in_hg>29.409449</altim_in_hg> ")
            st.append("<quality_control_flags> ")
            st.append("<auto>TRUE</auto> ")
            st.append("<auto_station>TRUE</auto_station> ")
            st.append("</quality_control_flags> ")
            st.append("<sky_condition sky_cover=\"BKN\" cloud_base_ft_agl=\"2200\" /> ")
            st.append("<sky_condition sky_cover=\"BKN\" cloud_base_ft_agl=\"2900\" /> ")
            st.append("<sky_condition sky_cover=\"OVC\" cloud_base_ft_agl=\"3700\" /> ")
            st.append("<flight_category>MVFR</flight_category> ")
            st.append("<precip_in>0.005</precip_in> ")
            st.append("<metar_type>SPECI</metar_type> ")
            st.append("<elevation_m>47.0</elevation_m> ")
            st.append("</METAR> ")

            st.append("</data> ")
            st.append("</response> ")

            return st
        }
    }
    
    private var metars : [METAR] = []
    private var currentMetar  = METAR()
    
    private var parser : XMLParser = XMLParser()
    private var currentElement = ""
    
    private struct current {
        var string       = ""
        var integer      = 0
        var double       = 0.0
        var bool         = false
        var skycondition = SkyCondition()
    }
    
    private var currentValues = current()
    
    private var dateformatter = DateFormatter()
    
    public override init() {
        dateformatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'"
        dateformatter.timeZone = TimeZone(secondsFromGMT: 0)
    }
    
    public func parseDocument(_ data: Data, completion: (_ metar: [METAR])->()) {
        
        parser = XMLParser(data: data)
        parser.delegate = self
        if parser.parse() {
            completion(self.metars)
        } else if let  pe = parser.parserError {
            print("Parse Error: \(pe)")
        }
        
    }
    
    public func parserDidStartDocument(_ parser: XMLParser) {
        print("parserDidStartDocument")
    }
    
    public func parserDidEndDocument(_ parser: XMLParser) {
        print("parserDidEndDocument")
    }
    
    public func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        
        currentElement = ""
        
        switch elementName {
        case "METAR":
            currentMetar = METAR()
            
        case "sky_condition":
            currentElement = elementName
            var sky = SkyCondition()
            
            if let skc = attributeDict["sky_cover"] {
                sky.skyCover = skc
            }
            if let skc = attributeDict["cloud_base_ft_agl"], let skcI = Int(skc) {
                sky.cloudBase = skcI
            }

            currentValues.skycondition = sky

        default:
            currentElement = elementName
        }
        
        
    }
    
    public func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {

        switch elementName {
        case "METAR":
            metars.append(currentMetar)
        case "raw_text":
            currentMetar.rawText = currentValues.string
        case "station_id":
            currentMetar.stationId = currentValues.string
        case "observation_time":
            currentMetar.observationTime = currentValues.integer
        case "latitude":
            currentMetar.latitude = currentValues.double
        case "longitude":
            currentMetar.longitude = currentValues.double
        case "temp_c":
            currentMetar.temperature = currentValues.double
        case "precip_in":
            currentMetar.precipitation = currentValues.double
        case "dewpoint_c":
            currentMetar.dewpoint = currentValues.double
        case "wind_dir_degrees":
            currentMetar.windDirection = currentValues.integer
        case "wind_speed_kt":
            currentMetar.windSpeed = currentValues.integer
        case "wind_gust_kt":
            currentMetar.windGust = currentValues.integer
        case "altim_in_hg":
            currentMetar.altimiter = currentValues.double
        case "auto":
            currentMetar.autoRecord = currentValues.bool
        case "auto_station":
            currentMetar.autoStation = currentValues.bool
        case "lightning_sensor_off":
            currentMetar.lightningSensorOff = currentValues.bool
        case "freezing_rain_sensor_off":
            currentMetar.freezingRainSensorOff = currentValues.bool
        case "present_weather_sensor_off":
            currentMetar.presentWeatherSensorOff = currentValues.bool
        case "maintenance_indicator_on":
            currentMetar.maintenance = currentValues.bool
        case "sea_level_pressure_mb":
            currentMetar.sealevelPressure = currentValues.double
        case "three_hr_pressure_tendency_mb":
            currentMetar.threeHourPressure = currentValues.double
        case "maxT_c":
            currentMetar.sixHourMaxTemp = currentValues.double
        case "minT_c":
            currentMetar.sixHourMinTemp = currentValues.double
        case "maxT24hr_c":
            currentMetar.twentyFourHourTempMax = currentValues.double
        case "minT24hr_c":
            currentMetar.twentyFourHourTempMin = currentValues.double
        case "pcp3hr_in":
            currentMetar.precipitationThreeHour = currentValues.double
        case "pcp6hr_in":
            currentMetar.precipitationSixHour = currentValues.double
        case "pcp24hr_in":
            currentMetar.precipitationTwentyFourHour = currentValues.double
        case "snow_in":
            currentMetar.snow = currentValues.double

        case "sky_condition":
            if currentMetar.skyCondition == nil {
                currentMetar.skyCondition = [currentValues.skycondition]
            } else {
                currentMetar.skyCondition?.append(currentValues.skycondition)
            }

        case "wx_string":
            currentMetar.weatherDescription = currentValues.string
        case "metar_type":
            currentMetar.metarType = currentValues.string
        case "elevation_m":
            currentMetar.elevation = currentValues.double
        case "flight_category":
            currentMetar.flightCategory = currentValues.string
        case "visibility_statute_mi":
            currentMetar.visibility = currentValues.double
        case "vert_vis_ft":
            currentMetar.verticalVisibility = currentValues.integer
        case "no_signal":
            currentMetar.noSignal = currentValues.bool

        default:
            print("Element \(elementName) NOT ended")
        }

        currentElement = ""
        currentValues = current()

    }
    
    public func parser(_ parser: XMLParser, foundCharacters string: String) {
        
        let data = string.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        
        if !data.isEmpty {
            print("parser current element: \(currentElement) foundCharacters: \(data)")
            
            switch currentElement {
                
            case "observation_time":
                if let di = dateformatter.date(from: data) {
                    let dii = di.timeIntervalSince1970
                    currentValues.integer = Int(dii)
                }

            case "vert_vis_ft",
                 "wind_gust_kt",
                 "wind_speed_kt",
                 "wind_dir_degrees":
                currentValues.integer = Int(data) ?? 0
                
            case "temp_c",
                 "maxT_c",
                 "minT_c",
                 "snow_in",
                 "maxT24hr_c",
                 "minT24hr_c",
                 "pcp3hr_in",
                 "pcp6hr_in",
                 "pcp24hr_in",
                 "precip_in",
                 "latitude",
                 "longitude",
                 "dewpoint_c",
                 "altim_in_hg",
                 "elevation_m",
                 "sea_level_pressure_mb",
                 "visibility_statute_mi",
                 "three_hr_pressure_tendency_mb":
                currentValues.double = Double(data) ?? 0.0

            case "auto",
                 "no_signal",
                 "auto_station",
                 "lightning_sensor_off",
                 "freezing_rain_sensor_off",
                 "present_weather_sensor_off",
                 "maintenance_indicator_on":
                currentValues.bool = false
                if data == "TRUE" {
                    currentValues.bool = true
                }

            case "raw_text",
                 "wx_string",
                 "metar_type",
                 "station_id",
                 "flight_category":
                currentValues.string.append(data)

            default:
                print("The element \(currentElement) was NOT found for foundCharacters  The data is: \(data)")
            }
        }
    }
    
    public func parser(_ parser: XMLParser, parseErrorOccurred parseError: Error) {
        print("parse error: \(parseError)")
    }
    
}
