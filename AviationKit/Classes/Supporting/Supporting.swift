//
//  Supporting.swift
//  AviationKit
//
//  Created by Mike Silvers on 6/1/19.
//

import Foundation

// MARK: - Parameters
public struct TimeConstraints {
    var hoursBeforeNow : Int?
    var startEnd       : StartEnd?
}

public struct StartEnd {
    var startTime : Int = 0
    var endTime   : Int = 0
}

public struct StationConstraints {
    var stationString            : [String]?
    var mostRecentForEachStation : Bool?
}

public struct AreaConstraints {
    var coordinates   : Coordinates?
    var radiusInMiles : Int?   = 5
}

public struct Coordinates {
    var longitude : Double = 0.0
    var latitude  : Double = 0.0
}

struct hold {
    var mostRecent : Bool = false
}

struct CoreRequirements {
    let requestType : String = "retrieve"
    let dataFormat  : String = "xml"
}

// MARK: - Report structures
public struct MetarParams {
    let dataSource         : String  = "metars"
    var timeConstraints    : TimeConstraints
    var stationConstraints : StationConstraints?
    var mostRecent         : Bool?
    var flightPath         : Bool?
    var fields             : [String]?
}

public struct TafParams {
    let dataSource : String  = "tafs"
}

struct AircraftReports {
    let dataSource : String  = ""
}

struct AIRSIGMET {
    let dataSource : String  = ""
}

struct StationInfo {
    let dataSource : String  = ""
}


