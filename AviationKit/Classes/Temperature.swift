//
//  Temperature.swift
//  AviationKit
//
//  Created by Mike Silvers on 5/7/19.
//

import Foundation

/**
 This struct contains the temperature information.
 */
public struct Temperature : Codable {
    
    // MARK: variables to define the sky condition
    var validTime   : Int?
    var surfaceTemp : Double?
    var maxTemp     : Double?
    var minTemp     : Double?

    // MARK: Coding Key enum
    enum CodingKeys: String, CodingKey {
        case validTime   = "valid_time"
        case surfaceTemp = "sfc_temp_c"
        case maxTemp     = "max_temp_c"
        case minTemp     = "min_temp_c"
    }
    
    
}
