//
//  ReportError.swift
//  AviationKit
//
//  Created by Mike Silvers on 6/2/19.
//

import Foundation

/**
 A general error thrown by AviationKit.
 
 A generalized error thrown by AviationKit
 */
public enum GeneralError: Swift.Error {
    /// The general error
    case generalError
    /// The expected function has not been implemented
    case notImplemented(message: String)
}
