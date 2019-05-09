//
//  TafParser.swift
//  AviationKit
//
//  Created by Mike Silvers on 5/7/19.
//

import Foundation

public class TafParser : NSObject, XMLParserDelegate {
    
    public var demoTAF : String {
        get {
            var st = "<?xml version=\"1.0\" encoding=\"UTF-8\"?>"
            st.append("<response xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:xsi=\"http://www.w3.org/2001/XML-Schema-instance\" version=\"1.2\" ")
            return st
        }
    }
    //MARK: Supporting variables
    private var tafs : [TAF]       = []
    private var currentTaf         = TAF()
    private var currentForecast    = Forecast()
    private var currentTemperature = Temperature()

    private var parser : XMLParser = XMLParser()
    private var currentElement = ""
    
    private var currentValues = current()
    
    private var dateformatter = DateFormatter()
    
    //MARK: Supporting structures
    /// This private struct contains the current values parsed from XML
    private struct current {
        
        var bool    = false
        var double  = 0.0
        var string  = ""
        var integer = 0
        
        var forecast            = Forecast()
        var temperature         = Temperature()
        var skycondition        = SkyCondition()
        var icingcondition      = IcingCondition()
        var turbulencecondition = TurbulenceCondition()
        
    }

    //MARK: Initializers
    
    /**
     Initializes the new *MafParser*.
     
     - Returns: A new instance of the MafParser.
     
     */
    public override init() {
        // configure the date formatter for conversion between epoch time and the
        // time passed in ISO8601 UTC format
        dateformatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'"
        dateformatter.timeZone = TimeZone(secondsFromGMT: 0)
    }

    //MARK: Core functions
    /**
     The completion block for the return of parsed TAF objects.
     
     - parameter metar: An array of TAF objects parsed from the XML documents
     */
    public typealias parseCompletion = (_ taf: [TAF])->()

    /**
     This function will parse the XML document and return an array of TAF obects.
     
     - parameter data: *Data* representation of the XML document
     - parameter completion: The completion block that returns the TAF array
     
     */
    public func parseDocument(_ data: Data, completion: parseCompletion) {
        
        // we are setting the XMLParser and the delegate to this class
        parser = XMLParser(data: data)
        parser.delegate = self
        if parser.parse() {
            // return the array of METAR objects
            completion(self.tafs)
        } else if let  pe = parser.parserError {
            print("Parse Error: \(pe)")
        }
        
    }
    
    //MARK: XMLParserDelegate functions
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
        case "TAF":
            // note: no currentElement because this is the outermost element
            // reset the current TAF object.  We build this object as the XML is processed
            currentTaf = TAF()

        case "forecast":
            // reset the current Forecast object.  We build this object as the XML is processed
            currentElement = elementName
            currentForecast = Forecast()

        case "temperature":
            // reset the current Forecast object.  We build this object as the XML is processed
            currentElement     = elementName
            currentTemperature = Temperature()
            
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
            
            // set the new sky condition object to the current TAF
            currentValues.skycondition = sky
            
        case "turbulence_condition":
            // create a new TurbulenceCondition object for processing
            currentElement = elementName
            var sky = TurbulenceCondition()
            
            // the attributes of the sky conditions are all element attributes, there is
            // no data to this element - so all of the processing is done right here
            if let skc = attributeDict["turbulence_intensity"] {
                sky.intensity = skc
            }
            
            if let skc = attributeDict["turbulence_min_alt_ft_agl"], let skcI = Int(skc) {
                sky.minAltitude = skcI
            }
            
            if let skc = attributeDict["turbulence_max_alt_ft_agl"], let skcI = Int(skc) {
                sky.maxAltitude = skcI
            }

            // set the new turbulence condition object to the current TAF
            currentValues.turbulencecondition = sky
        
        case "icing_condition":
            // create a new IcingConditions object for processing
            currentElement = elementName
            var sky = IcingCondition()
            
            // the attributes of the sky conditions are all element attributes, there is
            // no data to this element - so all of the processing is done right here
            if let skc = attributeDict["icing_intensity"] {
                sky.intensity = skc
            }
            
            if let skc = attributeDict["icing_min_alt_ft_agl"], let skcI = Int(skc) {
                sky.minAltitude = skcI
            }
            
            if let skc = attributeDict["icing_max_alt_ft_agl"], let skcI = Int(skc) {
                sky.maxAltitude = skcI
            }
            
            // set the new icing condition object to the current TAF
            currentValues.icingcondition = sky

        default:
            // all other elements are processed, so set the current element name
            currentElement = elementName
        }

    }
    
    public func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        
        switch elementName {
        case "TAF":
            // when the TAF element is ended, add the TAF we created to the array that will be returned later
            tafs.append(currentTaf)
            
        case "forecast":
            // when the forecast element is ended, add the forecast we created to the current TAF
            if currentTaf.forecast == nil {
                currentTaf.forecast = [currentForecast]
            } else {
                currentTaf.forecast?.append(currentForecast)
            }

        case "sky_condition":
            // there may be multiple sky conditions - so this is an array of sky conditions
            if currentForecast.skyCondition == nil {
                currentForecast.skyCondition = [currentValues.skycondition]
            } else {
                currentForecast.skyCondition?.append(currentValues.skycondition)
            }

        case "turbulence_condition":
            // there may be multiple turbulence conditions - so this is an array of sky conditions
            if currentForecast.turbulenceCondition == nil {
                currentForecast.turbulenceCondition = [currentValues.turbulencecondition]
            } else {
                currentForecast.turbulenceCondition?.append(currentValues.turbulencecondition)
            }

        case "icing_condition":
            // there may be multiple icing conditions - so this is an array of sky conditions
            if currentForecast.icingCondition == nil {
                currentForecast.icingCondition = [currentValues.icingcondition]
            } else {
                currentForecast.icingCondition?.append(currentValues.icingcondition)
            }

        case "temperature":
            // there may be multiple temperature conditions - so this is an array of sky conditions
            if currentForecast.temperature == nil {
                currentForecast.temperature = [currentValues.temperature]
            } else {
                currentForecast.temperature?.append(currentValues.temperature)
            }

            
        case "raw_text":
            // this is the actual raw text of the METAR
            currentTaf.rawText = currentValues.string
        case "station_id":
            // the station ID for the weather station
            currentTaf.stationId = currentValues.string
        case "issue_time":
            // the time the observation was made (in Epoch)
            currentTaf.issueTime = currentValues.integer
        case "bulletin_time":
            // the time the observation was made (in Epoch)
            currentTaf.bulletinTime = currentValues.integer
        case "valid_time_from":
            // the time the TAF starts (in Epoch)
            currentTaf.fromTime = currentValues.integer
        case "valid_time_to":
            // the time the TAF ends (in Epoch)
            currentTaf.toTime = currentValues.integer
        case "latitude":
            // latitude of the weather station
            currentTaf.latitude = currentValues.double
        case "longitude":
            // longitude of the weather station
            currentTaf.longitude = currentValues.double
        case "remarks":
            // remarks for the TAF
            currentTaf.remarks = currentValues.string
        case "elevation_m":
            // the elevation of the weather station in meters
            currentTaf.elevation = currentValues.double

        case "time_from":
            // the current time from for forecast
            currentForecast.validFromTime = currentValues.integer
        case "time_to":
            // the current time from to forecast
            currentForecast.validToTime = currentValues.integer
        case "change_indicator":
            // the current change
            currentForecast.changeIndicator = currentValues.string
        case "time_becoming":
            // the current time starting
            currentForecast.timeBecoming = currentValues.integer
        case "probability":
            // the probability for the forecast
            currentForecast.probability = currentValues.integer
        case "wind_dir_degrees":
            currentForecast.windDirection = currentValues.integer
        case "wind_speed_kt":
            currentForecast.windSpeed = currentValues.integer
        case "wing_gust_kt":
            currentForecast.windGust = currentValues.integer
        case "wind_shear_hgt_ft_agl":
            currentForecast.windShearHeightAGL = currentValues.integer
        case "wind_shear_dir_degrees":
            currentForecast.windShearDirection = currentValues.integer
        case "wind_shear_speed_kt":
            currentForecast.windShearSpeed = currentValues.integer
        case "visibility_statute_mi":
            currentForecast.visibility = currentValues.double
        case "altim_in_hg":
            currentForecast.altimiter = currentValues.double
        case "vert_vis_ft":
            currentForecast.verticalVisibility = currentValues.integer
        case "wx_string":
            currentForecast.weatherDescription = currentValues.string
        case "not_decoded":
            currentForecast.notDecoded = currentValues.string
            
        case "valid_time":
            currentTemperature.validTime = currentValues.integer
        case "sfc_temp_c":
            currentTemperature.surfaceTemp = currentValues.double
        case "max_temp_c":
            currentTemperature.maxTemp = currentValues.double
        case "min_temp_c":
            currentTemperature.minTemp = currentValues.double

            
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
                
            case "time_to",
                 "time_from",
                 "valid_time",
                 "issue_time",
                 "bulletin_time",
                 "valid_time_to",
                 "time_becoming",
                 "valid_time_from":
                // format the date/time to Epoch
                if let di = dateformatter.date(from: data) {
                    let dii = di.timeIntervalSince1970
                    currentValues.integer = Int(dii)
                }
                
            // the integer elements
            case "vert_vis_ft",
                 "probability",
                 "wind_gust_kt",
                 "wind_speed_kt",
                 "wind_dir_degrees",
                 "wind_shear_speed_kt",
                 "wind_shear_hgt_ft_agl",
                 "wind_shear_dir_degrees":
                currentValues.integer = Int(data) ?? 0
                
            // the double elements
            case "latitude",
                 "longitude",
                 "sfc_temp_c",
                 "min_temp_c",
                 "max_temp_c",
                 "elevation_m",
                 "altim_in_hg",
                 "visibility_statute_mi":
                currentValues.double = Double(data) ?? 0.0
                
            // the text elements
            case "remarks",
                 "raw_text",
                 "wx_string",
                 "station_id",
                 "not_decoded",
                 "change_indicator":
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
