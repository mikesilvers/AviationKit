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
    var mostRecentForEachStation : Bool?
}

public struct AreaConstraints : Codable {
    var coordinates   : Coordinates?
    var radiusInMiles : Int?   = 5
}

public struct Coordinates : Codable {
    var longitude : Double = 0.0
    var latitude  : Double = 0.0
}

struct hold {
    var mostRecent : Bool = false
}

struct CoreRequirements : Codable {
    let requestType : String = "retrieve"
    let dataFormat  : String = "xml"
}

// MARK: - Report structures
public struct MetarParams : Codable {
    let dataSource         : String  = "metars"
    var timeConstraints    : TimeConstraints
    var stationConstraints : StationConstraints?
    var mostRecent         : Bool?
    var flightPath         : Bool?
    var fields             : [String]?
}

public struct TafParams : Codable {
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


