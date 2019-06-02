//
//  GetReport.swift
//  AviationKit
//
//  Created by Mike Silvers on 6/1/19.
//

import Foundation

func getReport<T>(_ reportStruct : T) {
    
    switch reportStruct {
    case is MetarParams:
        print("METAR passed")
    case is TafParams:
        print("TAF passed")
    case is AircraftReports:
        print("AircraftReport passed - NOT IMPLEMENTED")
    case is AIRSIGMET:
        print("AIRSIGMET passed - NOT IMPLEMENTED")
    case is StationInfo:
        print("Station passed - NOT IMPLEMENTED")
    default:
        print("Incorrect item passed")
    }
    
}
