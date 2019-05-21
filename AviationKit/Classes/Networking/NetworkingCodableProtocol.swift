//
//  NetworkingProtocol.swift
//  AviationKit
//
//  Created by Mike Silvers on 5/13/19.
//

import Foundation

/**
 A generalized protocol to base all networking calls.
 
 This protocol allows new networking calls to be added in an organized manner with minimal effort.
 
 */
protocol NetworkingCodableProtocol {
    var baseUrl : URL { get set }
    var method : HTTPMethod { get set }
    var urlParams : [String:String]? { get set }
    var offsetLimit : OffsetLimit? { get set }
    var headers : [String:String]? { get set } 
}
