//
//  Ext.ReportError.swift
//  AviationKit
//
//  Created by Mike Silvers on 6/2/19.
//

import Foundation

extension MetarError {
    public var errorDescription: String? {
        switch self {
        case .incorrectParameters:
            return NSLocalizedString("The incorrect parameters were passed in.  Please review the documentation for the correct parameter combination.", comment: "")
        case .notImplemented:
            return NSLocalizedString("This function was not implemented", comment: "")
        }
    }
}

extension TafError {
    
    public var errorDescription: String? {
        switch self {
        case .incorrectParameters:
            return NSLocalizedString("The incorrect parameters were passed in.  Please review the documentation for the correct parameter combination.", comment: "")
        case .notImplemented:
            return NSLocalizedString("This function was not implemented", comment: "")
        }
    }

}

extension AircraftError {
    
    public var errorDescription: String? {
        switch self {
        case .incorrectParameters:
            return NSLocalizedString("The incorrect parameters were passed in.  Please review the documentation for the correct parameter combination.", comment: "")
        case .notImplemented:
            return NSLocalizedString("This function was not implemented", comment: "")
        }
    }

}

extension AirSigmetError {
    
    public var errorDescription: String? {
        switch self {
        case .incorrectParameters:
            return NSLocalizedString("The incorrect parameters were passed in.  Please review the documentation for the correct parameter combination.", comment: "")
        case .notImplemented:
            return NSLocalizedString("This function was not implemented", comment: "")
        }
    }
    
}

extension StationError {
    
    public var errorDescription: String? {
        switch self {
        case .incorrectParameters:
            return NSLocalizedString("The incorrect parameters were passed in.  Please review the documentation for the correct parameter combination.", comment: "")
        case .notImplemented:
            return NSLocalizedString("This function was not implemented", comment: "")
        }
    }

}

extension GeneralError {
    
    public var errorDescription: String? {
        switch self {
        case .generalError :
            return NSLocalizedString("There was a general error", comment: "")
        }
    }
    
}

