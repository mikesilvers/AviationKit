//
//  XMLCustomParserProtocol.swift
//  AviationKit
//
//  Created by Mike Silvers on 5/17/19.
//

import Foundation

protocol XMLCustomParserProtocol {
    typealias parseCompletion = (_ results: [Any])->()
    func parseDocument(_ data: Data, completion: parseCompletion)
}
