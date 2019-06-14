//
//  Ext.ReportError.swift
//  AviationKit
//
//  Created by Mike Silvers on 6/2/19.
//

import Foundation

extension GeneralError {
    
    /// Error descriptions for the general error.
    public var errorDescription: String? {
        switch self {
        case .notImplemented:
            return NSLocalizedString("This function is not implemented.", comment: "")
        case .generalError :
            return NSLocalizedString("There was a general error", comment: "")
        }
    }
    
}

