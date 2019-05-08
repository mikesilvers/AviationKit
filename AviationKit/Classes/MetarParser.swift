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
        
        print("didStartElement: \(elementName)  qualifiedName: \(qName ?? "")  attributes: \n\(attributeDict)")
        
        currentElement = elementName
        
        switch elementName {
        case "METAR":
            currentMetar = METAR()
            currentElement = ""
        case "raw_text":
            currentElement = "raw_text"
        case "station_id":
            currentElement = "station_id"
        case "observation_time":
            currentElement = "observation_time"
        case "latitude":
            currentElement = "latitude"
        case "longitude":
            currentElement = "longitude"
        case "temp_c":
            currentElement = "temp_c"
        case "dewpoint_c":
            currentElement = "dewpoint_c"
        case "wind_dir_degrees":
            currentElement = "wind_dir_degrees"
        case "wind_speed_kt":
            currentElement = "wind_speed_kt"
        case "wind_gust_kt":
            currentElement = "wind_gust_kt"
        case "altim_in_hg":
            currentElement = "altim_in_hg"
        case "auto":
            currentElement = "auto"
        case "auto_station":
            currentElement = "auto_station"
        case "present_weather_sensor_off":
            currentElement = "present_weather_sensor_off"
        case "sky_condition":
            currentElement = "sky_condition"
            var sky = SkyCondition()
            
            if let skc = attributeDict["sky_cover"] {
                sky.skyCover = skc
            }
            if let skc = attributeDict["cloud_base_ft_agl"], let skcI = Int(skc) {
                sky.cloudBase = skcI
            }

            currentValues.skycondition = sky

        case "metar_type":
            currentElement = "metar_type"
        case "elevation_m":
            currentElement = "elevation_m"
        case "visibility_statute_mi":
            currentElement = "visibility_statute_mi"
        case "flight_category":
            currentElement = "flight_category"
        case "no_signal":
            currentElement = "no_signal"
        default:
            print("Element \(elementName) NOT started")
            currentElement = ""
        }
        
        
    }
    
    public func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {

        print("didEndElement: \(elementName)  qualifiedName: \(qName ?? "")")
        
        switch elementName {
        case "METAR":
            metars.append(currentMetar)
        case "raw_text":
            currentMetar.rawText = currentValues.string
            currentElement = ""
            currentValues = current()
        case "station_id":
            currentMetar.stationId = currentValues.string
            currentElement = ""
            currentValues = current()
        case "observation_time":
            currentMetar.observationTime = currentValues.integer
            currentElement = ""
            currentValues = current()
        case "latitude":
            currentMetar.latitude = currentValues.double
            currentElement = ""
            currentValues = current()
        case "longitude":
            currentMetar.longitude = currentValues.double
            currentElement = ""
            currentValues = current()
        case "temp_c":
            currentMetar.temperature = currentValues.double
            currentElement = ""
            currentValues = current()
        case "dewpoint_c":
            currentMetar.dewpoint = currentValues.double
            currentElement = ""
            currentValues = current()
        case "wind_dir_degrees":
            currentMetar.windDirection = currentValues.integer
            currentElement = ""
            currentValues = current()
        case "wind_speed_kt":
            currentMetar.windSpeed = currentValues.integer
            currentElement = ""
            currentValues = current()
        case "wind_gust_kt":
            currentMetar.windGust = currentValues.integer
            currentElement = ""
            currentValues = current()
        case "altim_in_hg":
            currentMetar.altimiter = currentValues.double
            currentElement = ""
            currentValues = current()
        case "auto":
            currentMetar.autoRecord = currentValues.bool
            currentElement = ""
            currentValues = current()
        case "auto_station":
            currentMetar.autoStation = currentValues.bool
            currentElement = ""
            currentValues = current()
        case "present_weather_sensor_off":
            currentMetar.presentWeatherSensor = currentValues.bool
            currentElement = ""
            currentValues = current()
        case "sky_condition":
            if currentMetar.skyCondition == nil {
                currentMetar.skyCondition = [currentValues.skycondition]
            } else {
                currentMetar.skyCondition?.append(currentValues.skycondition)
            }
            currentElement = ""
            currentValues = current()
        case "metar_type":
            currentMetar.metarType = currentValues.string
            currentElement = ""
            currentValues = current()
        case "elevation_m":
            currentMetar.elevation = currentValues.double
            currentElement = ""
            currentValues = current()
        case "flight_category":
            currentMetar.flightCategory = currentValues.string
            currentElement = ""
            currentValues = current()
        case "visibility_statute_mi":
            currentMetar.visibility = currentValues.double
            currentElement = ""
            currentValues = current()
        case "no_signal":
            currentMetar.noSignal = currentValues.bool
            currentElement = ""
            currentValues = current()


        default:
            print("Element \(elementName) NOT ended")
            currentElement = ""
            currentValues = current()
        }

        currentElement = ""

    }
    
    public func parser(_ parser: XMLParser, foundCharacters string: String) {
        
        let data = string.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        
        if !data.isEmpty {
            print("parser current element: \(currentElement) foundCharacters: \(data)")
            
            switch currentElement {
            case "raw_text":
                currentValues.string.append(data)
            case "station_id":
                currentValues.string.append(data)
            case "observation_time":
                if let di = dateformatter.date(from: data) {
                    let dii = di.timeIntervalSince1970
                    currentValues.integer = Int(dii)
                }
            case "latitude":
                currentValues.double = Double(data) ?? 0.0
            case "longitude":
                currentValues.double = Double(data) ?? 0.0
            case "temp_c":
                currentValues.double = Double(data) ?? 0.0
            case "dewpoint_c":
                currentValues.double = Double(data) ?? 0.0
            case "wind_dir_degrees":
                currentValues.integer = Int(data) ?? 0
            case "wind_speed_kt":
                currentValues.integer = Int(data) ?? 0
            case "wind_gust_kt":
                currentValues.integer = Int(data) ?? 0
            case "altim_in_hg":
                currentValues.double = Double(data) ?? 0.0
            case "auto":
                currentValues.bool = false
                if data == "TRUE" {
                    currentValues.bool = true
                }
            case "auto_station":
                currentValues.bool = false
                if data == "TRUE" {
                    currentValues.bool = true
                }
            case "present_weather_sensor_off":
                currentValues.bool = false
                if data == "TRUE" {
                    currentValues.bool = true
                }
            case "metar_type":
                currentValues.string.append(data)
            case "elevation_m":
                currentValues.double = Double(data) ?? 0.0
            case "flight_category":
                currentValues.string.append(data)
            case "visibility_statute_mi":
                currentValues.double = Double(data) ?? 0.0
            case "no_signal":
                currentValues.bool = false
                if data == "TRUE" {
                    currentValues.bool = true
                }

            default:
                print("The currentElement was NOT found for foundCharacters")
            }
        }
    }
    
    public func parser(_ parser: XMLParser, parseErrorOccurred parseError: Error) {
        print("parse error: \(parseError)")
    }
    
}
