//
//  SkyCondition.swift
//  AviationKit
//
//  Created by Mike Silvers on 5/7/19.
//

import Foundation

public struct SkyCondition : Codable {
    
    var skyCover  : String?
    var cloudBase : Int?
    
    enum CodingKeys: String, CodingKey {
        case skyCover  = "sky_cover"
        case cloudBase = "cloud_base_ft_agl"
    }
}
