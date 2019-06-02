//
//  GetReport.swift
//  AviationKit
//
//  Created by Mike Silvers on 6/1/19.
//

import Foundation

public struct Reports {
    
    @discardableResult
    public static func getReport<T>(_ reportStruct : T) -> ([T]?, Error?) {
    
        switch reportStruct {
        case is MetarParams:
            print("METAR passed")
            return Comms.getMetarReport(reportStruct as! MetarParams) as! ([T]?, Error?)
        case is TafParams:
            print("TAF passed")
            return Comms.getTafReport(reportStruct as! TafParams) as! ([T]?, Error?)
        case is AircraftReportParams:
            print("AircraftReport passed - NOT IMPLEMENTED")
            let error = AircraftError.notImplemented
            return (nil,error)
        case is AirSigmetParams:
            print("AIRSIGMET passed - NOT IMPLEMENTED")
            let error = AirSigmetError.notImplemented
            return (nil,error)
        case is StationInfoParams:
            print("Station passed - NOT IMPLEMENTED")
            let error = StationError.notImplemented
            return (nil,error)
        default:
            print("Incorrect item passed")
            return (nil,nil)
        }
    }
}
