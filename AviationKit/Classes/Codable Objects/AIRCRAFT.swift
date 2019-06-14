//
//  AIRCRAFT.swift
//  AviationKit
//
//  Created by Mike Silvers on 6/2/19.
//

import Foundation

/**
 The struct *AIRCRAFT* represents a AIRCRAFT object.
 This object is *codable* to allow easy manipulaition with JSON.
 */
public struct AIRCRAFT : Codable {
    
    // MARK: - Variables used for the AIRCRAFT object
    /// The raw return from the server (raw_text)
    public var rawText              : String?
}
