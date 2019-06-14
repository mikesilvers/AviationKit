//
//  File.swift
//  AviationKit
//
//  Created by Mike Silvers on 6/2/19.
//

import Foundation

/**
 The struct *AIRSIGMET* represents a AIRSIGMET object.
 This object is *codable* to allow easy manipulaition with JSON.
 */
public struct AIRSIGMET {
    
    // MARK: - Variables used for the AIRSIGMET object
    /// The raw data returned from the server (raw_text)
    public var rawText              : String?

}
