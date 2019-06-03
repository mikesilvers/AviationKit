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
    public init () {}
    
    static func getReport<T>(_ reportStruct : T, completion: @escaping (_ results: [T]?, Error?)->()) {
        
        switch reportStruct {
        case is MetarParams:
            if let rs = reportStruct as? MetarParams {
                
            }
        case is TafParams:
            if let rs = reportStruct as? TafParams {
                
            }
        case is AircraftReportParams:
            if let rs = reportStruct as? AircraftReportParams {
                
            }
        case is AirSigmetParams:
            if let rs = reportStruct as? AirSigmetParams {
                
            }
        case is StationInfoParams:
            if let rs = reportStruct as? StationInfoParams {
                
            }
        default:
            completion(nil,  (GeneralError.self as! Error))
        }
    }
}
