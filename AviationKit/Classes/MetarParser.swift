//
//  MetarParser.swift
//  AviationKit
//
//  Created by Mike Silvers on 5/7/19.
//

import Foundation

/**
The *MetarParser* class will parse the XML document containing METAR data
and return an array of METAR objects.
 
This class parses the XML document in the *parseDocument* function and
returns the array of METAR's in a closure.
 */
public class MetarParser : NSObject, XMLParserDelegate {

    // MARK: - Supporting variables with sample data
    /**
    The variable that contains METAR XML for testing.
    There are three individual METAR's used for testing.
    */
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
    
    // MARK: - Supporting variables
    private var metars : [METAR] = []
    private var currentMetar  = METAR()
    
    private var parser : XMLParser = XMLParser()
    private var currentElement = ""
    
    private var currentValues = current()
    
    private var dateformatter = DateFormatter()
    
    // MARK: - Supporting structures
    /// This private struct contains the current values parsed from XML
    private struct current {
        var string       = ""
        var integer      = 0
        var double       = 0.0
        var bool         = false
        var skycondition = SkyCondition()
    }

    // MARK: - Initializers
    
    /**
    Initializes the new *MetarParser*.
     
    - Returns: A new instance of the MetarParser.
     
    */
    public override init() {
        // configure the date formatter for conversion between epoch time and the
        // time passed in ISO8601 UTC format
        dateformatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'"
        dateformatter.timeZone = TimeZone(secondsFromGMT: 0)
    }
    
    // MARK: - Core functions
    /**
     The completion block for the return of parsed METAR objects.
     
     - parameter metar: An array of METAR objects parsed from the XML documents
    */
    public typealias parseCompletion = (_ metar: [METAR])->()
    
    /**
    This function will parse the XML document and return an array of METAR obects.
     
    - parameter data: *Data* representation of the XML document
    - parameter completion: The completion block that returns the METAR array
     
    */
    public func parseDocument(_ data: Data, completion: parseCompletion) {
        
        // we are setting the XMLParser and the delegate to this class
        parser = XMLParser(data: data)
        parser.delegate = self
        if parser.parse() {
            // return the array of METAR objects
            completion(self.metars)
        } else if let  pe = parser.parserError {
            print("Parse Error (PE1000): \(pe)")
        }
        
    }
    
    // MARK: - XMLParserDelegate functions
    public func parserDidStartDocument(_ parser: XMLParser) {
        // we are only setting this for debug purposes - so you can see when the document has started processing
        print("parserDidStartDocument")
    }
    
    public func parserDidEndDocument(_ parser: XMLParser) {
        // we are only setting this for debug purposes - so you can see when the document has ended processing
        print("parserDidEndDocument")
    }
    
    public func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        
        currentElement = ""
        
        // process dependent upon the current element
        switch elementName {
        case "METAR":
            // reset the current METAR object.  We build this object as the XML is processed
            currentMetar = METAR()
            
        case "sky_condition":
            // create a new SkyConditions object for processing
            currentElement = elementName
            var sky = SkyCondition()
            
            // the attributes of the sky conditions are all element attributes, there is
            // no data to this element - so all of the processing is done right here
            if let skc = attributeDict["sky_cover"] {
                sky.skyCover = skc
            }
            
            if let skc = attributeDict["cloud_base_ft_agl"], let skcI = Int(skc) {
                sky.cloudBase = skcI
            }

            if let skc = attributeDict["cloud_type"] {
                sky.cloudType = skc
            }

            // set the new sky condition object to the current METAR
            currentValues.skycondition = sky

        default:
            // all other elements are processed, so set the current element name
            currentElement = elementName
        }
        
        
    }
    
    public func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {

        switch elementName {
        case "METAR":
            // when the METAR element is ended, add the METAR we created to the array that will be returned later
            metars.append(currentMetar)
        case "raw_text":
            // this is the actual raw text of the METAR
            currentMetar.rawText = currentValues.string
        case "station_id":
            // the station ID for the weather station
            currentMetar.stationId = currentValues.string
        case "observation_time":
            // the time the observation was made (in Epoch)
            currentMetar.observationTime = currentValues.integer
        case "latitude":
            // latitude of the weather station
            currentMetar.latitude = currentValues.double
        case "longitude":
            // longitude of the weather station
            currentMetar.longitude = currentValues.double
        case "temp_c":
            // the current temperature in celsius
            currentMetar.temperature = currentValues.double
        case "precip_in":
            // current liquid parcipitation since the last METAR in inches
            currentMetar.precipitation = currentValues.double
        case "dewpoint_c":
            // the current dewpoint in celsius
            currentMetar.dewpoint = currentValues.double
        case "wind_dir_degrees":
            // the direction the wind is blowing
            currentMetar.windDirection = currentValues.integer
        case "wind_speed_kt":
            // the speed the wind is blowing in knots
            currentMetar.windSpeed = currentValues.integer
        case "wind_gust_kt":
            // wind gust speeds in knots
            currentMetar.windGust = currentValues.integer
        case "altim_in_hg":
            // the altimiter
            currentMetar.altimiter = currentValues.double
        case "corrected":
            // this is a corrected report
            currentMetar.correctedRecord = currentValues.bool
        case "auto":
            // this is a fully automated weather station
            currentMetar.autoRecord = currentValues.bool
        case "auto_station":
            // the automated weather station is one of the following types (the type is not returned):
            // A01 A01A A02 A02A AOA AWOS
            currentMetar.autoStation = currentValues.bool
        case "lightning_sensor_off":
            // the lightning sensors are not working for this weather station
            // thunderstorm information is not available
            currentMetar.lightningSensorOff = currentValues.bool
        case "freezing_rain_sensor_off":
            // the freezing rain sensors are not working for this station
            currentMetar.freezingRainSensorOff = currentValues.bool
        case "present_weather_sensor_off":
            // the present weather sensor is not working
            currentMetar.presentWeatherSensorOff = currentValues.bool
        case "maintenance_indicator_on":
            // the weather station needs maintenance
            currentMetar.maintenance = currentValues.bool
        case "sea_level_pressure_mb":
            // sea level pressure
            currentMetar.sealevelPressure = currentValues.double
        case "three_hr_pressure_tendency_mb":
            // the pressure change in the past three hours
            currentMetar.threeHourPressure = currentValues.double
        case "maxT_c":
            // maximum air temperature in the past 6 hours (celsius)
            currentMetar.sixHourMaxTemp = currentValues.double
        case "minT_c":
            // minimum air temperature in the past 6 hours (celsius)
            currentMetar.sixHourMinTemp = currentValues.double
        case "maxT24hr_c":
            // the maximum air temperature on the past 24 hours (celsius)
            currentMetar.twentyFourHourTempMax = currentValues.double
        case "minT24hr_c":
            // the minimum air temperature in the past 24 hours (celsius)
            currentMetar.twentyFourHourTempMin = currentValues.double
        case "pcp3hr_in":
            // liquid precipitation in the past 3 hours (trace = 0.0005 in)
            currentMetar.precipitationThreeHour = currentValues.double
        case "pcp6hr_in":
            // liquid precipitation in the past 6 hours (trace = 0.0005 in)
            currentMetar.precipitationSixHour = currentValues.double
        case "pcp24hr_in":
            // liquid precipitation in the past 24 hours (trace = 0.0005 in)
            currentMetar.precipitationTwentyFourHour = currentValues.double
        case "snow_in":
            // snow depth on the ground (inches)
            currentMetar.snow = currentValues.double

        case "sky_condition":
            // there may be multiple sky conditions - so this is an array of sky conditions
            if currentMetar.skyCondition == nil {
                currentMetar.skyCondition = [currentValues.skycondition]
            } else {
                currentMetar.skyCondition?.append(currentValues.skycondition)
            }

        case "wx_string":
            // the weather symbol/text matching:
            // https://www.aviationweather.gov/docs/metar/wxSymbols_anno2.pdf
            currentMetar.weatherDescription = currentValues.string
        case "metar_type":
            // either METAR or SPECI
            currentMetar.metarType = currentValues.string
        case "elevation_m":
            // the elevation of the weather station in meters
            currentMetar.elevation = currentValues.double
        case "flight_category":
            // flight category of this METAR (VFR MVFR IFT LIFR)
            currentMetar.flightCategory = currentValues.string
        case "visibility_statute_mi":
            // horizontal visibility in miles
            currentMetar.visibility = currentValues.double
        case "vert_vis_ft":
            // vertical visibility in feet
            currentMetar.verticalVisibility = currentValues.integer
        case "no_signal":
            // there is no signal from the weather station
            currentMetar.noSignal = currentValues.bool

        default:
            // this is the default "whoops - we missed that one"
            print("Element \(elementName) NOT ended")
        }

        // after we have processed the record, reset the current stuff
        currentElement = ""
        currentValues = current()

    }
    
    public func parser(_ parser: XMLParser, foundCharacters string: String) {
        
        // set the base data and make sure there are no spaces or anything
        let data = string.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        
        if !data.isEmpty {
            // this is used to debug - left in here because we cna see the values if
            // the current element is not in the list of elements - helps us figure out
            // what is going on
            print("parser current element: \(currentElement) foundCharacters: \(data)")
            
            // process the correct data type according to the current element we are using
            switch currentElement {
                
            case "observation_time":
                // format the date/time to Epoch
                if let di = dateformatter.date(from: data) {
                    let dii = di.timeIntervalSince1970
                    currentValues.integer = Int(dii)
                }

            // the integer elements
            case "vert_vis_ft",
                 "wind_gust_kt",
                 "wind_speed_kt",
                 "wind_dir_degrees":
                currentValues.integer = Int(data) ?? 0
                
            // the double elements
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

            // the boolean elements
            case "auto",
                 "corrected",
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

            // the text elements
            case "raw_text",
                 "wx_string",
                 "cloud_type",
                 "metar_type",
                 "station_id",
                 "flight_category":
                currentValues.string.append(data)

            default:
                // the current element was not found int he list - this is a debug statement
                print("The element \(currentElement) was NOT found for foundCharacters  The data is: \(data)")
            }
        }
    }
    
    public func parser(_ parser: XMLParser, parseErrorOccurred parseError: Error) {
        // this is just a debug statement for a parser error
        print("parse error: \(parseError)")
    }
    
}
