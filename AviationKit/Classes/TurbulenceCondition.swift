//
//  TurbulenceCondition.swift
//  AviationKit
//
//  Created by Mike Silvers on 5/9/19.
//

import Foundation

/**
 This struct contains the turbulence condition information.
 */
public struct TurbulenceCondition : Codable {
    
    // MARK: variables to define the sky condition
    public var intensity   : String?
    public var minAltitude : Int?
    public var maxAltitude : Int?

    // MARK: Coding Key enum
    enum CodingKeys: String, CodingKey {
        case intensity   = "turbulence_intensity"
        case minAltitude = "turbulence_min_alt_ft_agl"
        case maxAltitude = "turbulence_max_alt_ft_agl"
    }
}
