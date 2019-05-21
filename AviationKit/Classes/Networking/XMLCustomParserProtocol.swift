//
//  XMLCustomParserProtocol.swift
//  AviationKit
//
//  Created by Mike Silvers on 5/17/19.
//

import Foundation

/**
 A generalized protocol to base all XML parsing networking calls.
 
 This protocol allows new XML parsing networking calls to be added in an organized manner with minimal effort.
 
 */
protocol XMLCustomParserProtocol {
    /**
     The completion block for the XML parsing protocol.
     
     The completion block when parsing an XML document.
     
     - Parameter results: An array of the results from the search,.
    */
    typealias parseCompletion = (_ results: [Any])->()
    
    /**
    The main function to parse the document
     
    The main function used to parse the XML document.
     
     - Parameter data: The data to be parsed
     - Parameter completion: The completion for the successful parse.
    */
    func parseDocument(_ data: Data, completion: parseCompletion)
}
