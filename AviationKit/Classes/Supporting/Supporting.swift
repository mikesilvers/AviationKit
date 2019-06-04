//
//  Supporting.swift
//  AviationKit
//
//  Created by Mike Silvers on 6/1/19.
//

import Foundation

// MARK: - Parameters
public struct TimeConstraints : Codable {
    var hoursBeforeNow : Int?
    var startEnd       : StartEnd?
}

public struct StartEnd : Codable {
    var startTime : Int = 0
    var endTime   : Int = 0
}

public struct StationConstraints : Codable {
    var stationString            : [String]?
    var mostRecentForEachStation : MostRecentForEachStationConstraints?
}

public enum MostRecentForEachStationConstraints : String, Codable {
    case constraint = "constraint"
    case postfilter = "postfilter"
    case `false`    = "false"
    case `true`     = "true"
}

public struct Coordinates : Codable {
    var longitude : Double = 0.0
    var latitude  : Double = 0.0
}

public struct CoordinatePath : Codable {
    var leg                   : Int = 1
    var endPoint              : Coordinates?
    var startPoint            : Coordinates?
    var stationString         : String?
}

public struct FlightPath  : Codable {
    var maxDistanceInMiles   : Double
    var flightPathCoordinates:[CoordinatePath]
}

//struct hold {
//    var mostRecent : Bool = false
//}

struct CoreRequirements : Codable {
    let requestType : String = "retrieve"
    let dataFormat  : String = "xml"
}

// MARK: - Report structures
public struct MetarParams  : Codable {
    let dataSource            : String  = "metars"
    var timeConstraints       : TimeConstraints
    var stationConstraints    : StationConstraints?
    var mostRecent            : Bool?
    var flightPath            : FlightPath?
    var fields                : [String]?
    var areaConstraint        : AreaConstraints?
    var coordinateRectangle   : CoordinateRectangle?
    var minimumDegreeDistance : Double?
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

// area constraints
public struct AreaConstraints : Codable {
    var coordinates   : Coordinates
    var radiusInMiles : Int   = 5
}

public struct CoordinateRectangle : Codable {
    var minimum : Coordinates
    var maximum : Coordinates
}



