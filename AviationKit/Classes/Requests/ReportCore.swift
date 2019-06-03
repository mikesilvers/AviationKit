//
//  GetReport.swift
//  AviationKit
//
//  Created by Mike Silvers on 6/1/19.
//

import Foundation

public struct ReportCore : NetworkingCodableProtocol {
    
    var baseUrl: URL = URL(fileURLWithPath: Reports.url.reports)
    var method: HTTPMethod = .get
    var urlParams: [String : String]?
    var offsetLimit: OffsetLimit?
    var headers: [String : String]?
    
    //MARK: - initializers
    public init() {  }
    
    mutating func getReport<T>(_ reportStruct : T) {
        
        let cr = CoreRequirements()
        
        // setup the core params across all reports
        urlParams = [:]
        urlParams?["requesttype"] = cr.requestType
        urlParams?["format"] = cr.dataFormat

        switch reportStruct {
            
        case is MetarParams:
            if let rs = reportStruct as? MetarParams {
                self.setupMetar(rs)
            }
            
        case is TafParams:
            if let rs = reportStruct as? TafParams {
                self.setupTaf(rs)
            }
            
        case is AircraftReportParams:
            if let rs = reportStruct as? AircraftReportParams {
                self.setupAircraft(rs)
            }
            
        case is AirSigmetParams:
            if let rs = reportStruct as? AirSigmetParams {
                self.setupAirSigmet(rs)
            }
            
        case is StationInfoParams:
            if let rs = reportStruct as? StationInfoParams {
                self.setupStation(rs)
            }
            
        default:
            print("This should not happen here.  Passed in \(T.self)")
        }
    }
    
}
