//
//  HTTPMethod.swift
//  AviationKit
//
//  Created by Mike Silvers on 5/13/19.
//

import Foundation

/**
 Defined to permitted network call types.
 
 Used to define a predetermined number of networking protocols.
 */
enum HTTPMethod : String {
    case get = "GET"
    case put = "PUT"
    case post = "POST"
    case patch = "PATCH"
    case head = "HEAD"
    case options = "OPTIONS"
}
