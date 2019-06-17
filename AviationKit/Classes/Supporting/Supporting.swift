//
//  Supporting.swift
//  AviationKit
//
//  Created by Mike Silvers on 6/1/19.
//

import Foundation

// MARK: - Supporting Structures
public struct TimeConstraints : Codable {
    public var hoursBeforeNow : Double?
    public var startEnd       : StartEnd?
    
    public init() {
        self.startEnd       = nil
        self.hoursBeforeNow = nil
    }
    
    public init(_ hoursBefore: Double?,_ startEnd: StartEnd?) {
        self.hoursBeforeNow = hoursBefore
        self.startEnd = startEnd
    }
}

public struct StartEnd : Codable {
    public var startTime : Int = 0
    public var endTime   : Int = 0
    
    public init() {
        self.startTime = 0
        self.endTime   = 0
    }
    
    public init(_ start: Int,_ end: Int) {
        self.startTime = start
        self.endTime   = end
    }
}

public struct StationConstraints : Codable {
    public var stationString            : [String]?
    public var mostRecentForEachStation : MostRecentForEachStationConstraints?
    
    public init() {
        self.stationString            = nil
        self.mostRecentForEachStation = nil
    }
    
    public init(_ stationString: [String]?,_ mostRecent: MostRecentForEachStationConstraints?) {
        self.stationString            = stationString
        self.mostRecentForEachStation = mostRecent
    }

}

/**
 An object representing the latitude and longitude of a point.
 */
public struct Coordinates : Codable {
    /// The longitude
    public var longitude : Double = 0.0
    /// The latitude
    public var latitude  : Double = 0.0
    
    /**
     Default initializer.
     
     - Returns: An initialized `Coordinates` object.
     */
    public init() {
        self.longitude = 0.0
        self.latitude  = 0.0
    }
    
    /**
     Initializer with all variables.
     
     - Parameter longitude: The longitude
     - Parameter latitude: The latitude
     - Returns: An initialized `Coordinates` object.
     */
    public init(_ longitude: Double,_ latitude: Double) {
        self.longitude = longitude
        self.latitude = latitude
    }
}

/**
 Represents one leg of a flight path.
 
 Representing one leg of a flight path using either:
 - A station String
 - The starting point and the ending point
 
 When using the station string, the four digit airport is the starting point.  The ending point is the is the next leg station string.
 */
public struct CoordinatePath : Codable {
    /// The leg of the journey.  Organized ascending and this number should be a positive interger.
    public var leg                   : Int = 1
    /// The starting coordinate for the leg
    public var endPoint              : Coordinates?
    /// The ending coordinate for the leg
    public var startPoint            : Coordinates?
    /// The station string for the airport
    public var stationString         : String?
    
    //MARK: Initializers
    /**
     The default initilaizer.
     
     - Returns: An initialized `CoordinatePath` object.
    */
    public init() {
        self.leg           = 1
        self.endPoint      = nil
        self.startPoint    = nil
        self.stationString = nil
    }
    
    /**
     Initializer with all variables.
     
     - Parameter leg: Int representing the leg of the journey
     - Parameter startPoint: The `Coordinates` object representing the latitude and longitude of the starting point.
     - Parameter endPoint: The `Coordinates` object representing the latitude and longitude of the ending point.
     - Parameter stationString: The four character station string for the airport.
     - Returns: An initialized `CoordinatePath` object.
     */
    public init(_ leg: Int = 1, _ startPoint: Coordinates?, _ endPoint: Coordinates?, _ stationString: String?) {
        self.leg           = leg
        self.startPoint    = startPoint
        self.endPoint      = endPoint
        self.stationString = stationString
    }
}

/**
 The total flight path.
 
 The flight path containing all legs of the flight.  The `CoordinatePath` objects are arranged in ascending order of leg numbers.
 */
public struct FlightPath  : Codable {
    /// The maximum distance from the flight path in miles.
    public var maxDistanceInMiles   : Double
    /// An `Array` of `CoordinatePath` objects representing the flight path.
    public var flightPathCoordinates:[CoordinatePath]
    
    /**
     The default initializer.
     
     - Returns: An initialized `FlightPath` object.
     */
    public init() {
        self.maxDistanceInMiles    = 1.0
        self.flightPathCoordinates = []
    }
    
    /**
     The initializer with all variables.
     
     - Parameter maxDistance: A `Double` representing the maximum distance from the flight path.
     - Parameter flightPath: An `Array` of `CoordinatePath` objects representing each leg of the flight path.
     - Returns: An initialized `FlightPath` object.
     */
    public init(_ maxDistance: Double, _ flightPath: [CoordinatePath]) {
        self.maxDistanceInMiles    = maxDistance
        self.flightPathCoordinates = flightPath
    }
}

// area constraints
/**
 Represents the coordinates and radius of a specific point.
 */
public struct AreaConstraints : Codable {
    /// Coordinates of a specific point
    public var coordinates   : Coordinates
    /// Radius around the coordinate (in miles)
    public var radiusInMiles : Int   = 5
    
    // MARK: Initializers
    /**
     Default initializer.
     
     - Returns: An initialized `AreaConstraints` object
    */
    public init() {
        self.coordinates   = Coordinates()
        self.radiusInMiles = 5
    }
    
    /**
     Initializer with all parameters.
     
     - Parameter coordinates: A `Coordinates` object representing the coordinate point
     - Parameter radius: The radius on miles from the coordinate.
     
     - Returns: An initialized `AreaConstraints` object
     */
    public init(_ coordinates: Coordinates, _ radius: Int) {
        self.coordinates = coordinates
        self.radiusInMiles = radius
    }
}

/**
 A rectangle bounded by coordinates
 */
public struct CoordinateRectangle : Codable {
    /// The minimum coordinates for the rectangle
    public var minimum : Coordinates
    /// The maximum coordinates for the rectangle
    public var maximum : Coordinates
    
    // MARK: Initializers
    /**
     Default initializer
     
     - Returns: An initialized `CoordinateRectangle` object.
     */
    public init() {
        self.minimum = Coordinates()
        self.maximum = Coordinates()
    }
    
    /**
     An initializer with all variables.
     
     - Parameter minimum: The `Coordinates` object representing the minimum corner of the rectangle
     - Parameter maximum: The `Coordinates` object representing the maximum corner of the rectangle
     - Returns: An initialized `CoordinateRectangle` object.
     */
    public init(_ minimum: Coordinates, _ maximum: Coordinates) {
        self.minimum = minimum
        self.maximum = maximum
    }
}

struct CoreRequirements : Codable {
    let requestType : String = "retrieve"
    let dataFormat  : String = "xml"
}

//MARK: - Enums
/**
 Valid values for the constraint `MostRecentForEachStation`.
 */
public enum MostRecentForEachStationConstraints : String, Codable {
    /// Request the most recent METAR for each station
    case constraint = "constraint"
    /// Post filter results after applying all other constrants
    case postfilter = "postfilter"
    /// Do not apply this parameter.  The same as omitting the parameter.
    case `false`    = "false"
    /// Same as the `postfilter`
    case `true`     = "true"
}

// MARK: - Report structures
public struct MetarParams  : Codable {
    let dataSource            : String  = "metars"
    public var timeConstraints       : TimeConstraints
    public var stationConstraints    : StationConstraints?
    public var mostRecent            : Bool?
    public var flightPath            : FlightPath?
    public var fields                : [String]?
    public var areaConstraint        : AreaConstraints?
    public var coordinateRectangle   : CoordinateRectangle?
    public var minimumDegreeDistance : Double?
    
    public init() {
        self.timeConstraints       = TimeConstraints()
        self.stationConstraints    = nil
        self.mostRecent            = nil
        self.flightPath            = nil
        self.fields                = nil
        self.areaConstraint        = nil
        self.coordinateRectangle   = nil
        self.minimumDegreeDistance = nil
    }
}

struct TafParams : Codable {
    let dataSource : String  = "tafs"
}

struct AircraftReportParams : Codable {
    let dataSource : String  = ""
}

struct AirSigmetParams : Codable {
    let dataSource : String  = ""
}

struct StationInfoParams : Codable {
    let dataSource : String  = ""
}
