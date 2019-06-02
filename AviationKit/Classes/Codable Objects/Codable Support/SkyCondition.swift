//
//  SkyCondition.swift
//  AviationKit
//
//  Created by Mike Silvers on 5/7/19.
//

import Foundation

/**
 This struct contains the sky condition information.
 */
public struct SkyCondition : Codable {
    
    // MARK: - Variables to define the sky condition
    public var skyCover  : String?
    public var cloudType : String?
    public var cloudBase : Int?

    // MARK: - Coding Key enum
    enum CodingKeys: String, CodingKey {
        case skyCover  = "sky_cover"
        case cloudBase = "cloud_base_ft_agl"
        case cloudType = "cloud_type"
    }
}
