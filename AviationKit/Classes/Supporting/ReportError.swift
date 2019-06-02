//
//  ReportError.swift
//  AviationKit
//
//  Created by Mike Silvers on 6/2/19.
//

import Foundation

public enum MetarError: Swift.Error {
    case incorrectParameters(message: String)
    case notImplemented
}

public enum TafError: Swift.Error {
    case incorrectParameters(message: String)
    case notImplemented
}

public enum AircraftError: Swift.Error {
    case incorrectParameters(message: String)
    case notImplemented
}

public enum AirSigmetError: Swift.Error {
    case incorrectParameters(message: String)
    case notImplemented
}

public enum StationError: Swift.Error {
    case incorrectParameters(message: String)
    case notImplemented
}
