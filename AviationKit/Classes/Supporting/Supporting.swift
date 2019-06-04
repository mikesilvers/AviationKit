//
//  Supporting.swift
//  AviationKit
//
//  Created by Mike Silvers on 6/1/19.
//

import Foundation

// MARK: - Supporting Structures
public struct TimeConstraints : Codable {
    public var hoursBeforeNow : Int?
    public var startEnd       : StartEnd?
    
    public init() {
        self.startEnd       = nil
        self.hoursBeforeNow = nil
    }
    
    public init(_ hoursBefore: Int?,_ startEnd: StartEnd?) {
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

public struct Coordinates : Codable {
    public var longitude : Double = 0.0
    public var latitude  : Double = 0.0
    
    public init() {
        self.longitude = 0.0
        self.latitude  = 0.0
    }
    
    public init(_ longitude: Double,_ latitude: Double) {
        self.longitude = longitude
        self.latitude = latitude
    }
}

public struct CoordinatePath : Codable {
    public var leg                   : Int = 1
    public var endPoint              : Coordinates?
    public var startPoint            : Coordinates?
    public var stationString         : String?
    
    public init() {
        self.leg           = 1
        self.endPoint      = nil
        self.startPoint    = nil
        self.stationString = nil
    }
    
    public init(_ leg: Int, _ startPoint: Coordinates?, _ endPoint: Coordinates?, _ stationString: String?) {
        self.leg           = leg
        self.startPoint    = startPoint
        self.endPoint      = endPoint
        self.stationString = stationString
    }
}

public struct FlightPath  : Codable {
    public var maxDistanceInMiles   : Double
    public var flightPathCoordinates:[CoordinatePath]
    
    public init() {
        self.maxDistanceInMiles    = 1.0
        self.flightPathCoordinates = []
    }
    
    public init(_ maxDistance: Double, _ flightPath: [CoordinatePath]) {
        self.maxDistanceInMiles    = maxDistance
        self.flightPathCoordinates = flightPath
    }
}

// area constraints
public struct AreaConstraints : Codable {
    public var coordinates   : Coordinates
    public var radiusInMiles : Int   = 5
    
    public init() {
        self.coordinates   = Coordinates()
        self.radiusInMiles = 5
    }
    
    public init(_ coordinates: Coordinates, _ radius: Int) {
        self.coordinates = coordinates
        self.radiusInMiles = radius
    }
}

public struct CoordinateRectangle : Codable {
    public var minimum : Coordinates
    public var maximum : Coordinates
    
    public init() {
        self.minimum = Coordinates()
        self.maximum = Coordinates()
    }
    
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
public enum MostRecentForEachStationConstraints : String, Codable {
    case constraint = "constraint"
    case postfilter = "postfilter"
    case `false`    = "false"
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
