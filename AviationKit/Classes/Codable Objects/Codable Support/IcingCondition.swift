//
//  IcingCondition.swift
//  AviationKit
//
//  Created by Mike Silvers on 5/9/19.
//

import Foundation

/**
 This struct contains the icing condition information.
 */
public struct IcingCondition : Codable {
    
    // MARK: - Variables to define the sky condition
    public var intensity   : String?
    public var minAltitude : Int?
    public var maxAltitude : Int?

    // MARK: - Coding Key enum
    enum CodingKeys: String, CodingKey {
        case intensity   = "icing_intensity"
        case minAltitude = "icing_min_alt_ft_agl"
        case maxAltitude = "icing_max_alt_ft_agl"
    }
}
