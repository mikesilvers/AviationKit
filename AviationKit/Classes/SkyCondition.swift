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
    
    // MARK: variables to define the sky condition
    var skyCover  : String?
    var cloudType : String?
    var cloudBase : Int?

    // MARK: Coding Key enum
    enum CodingKeys: String, CodingKey {
        case skyCover  = "sky_cover"
        case cloudBase = "cloud_base_ft_agl"
        case cloudType = "cloud_type"
    }
}
