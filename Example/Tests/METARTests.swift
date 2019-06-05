//
//  METARTests.swift
//  AviationKit_Tests
//
//  Created by Mike Silvers on 6/4/19.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import XCTest
import AviationKit

class METARTests: XCTestCase {

    func testMETARRequestQueryString() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        XCTAssert(true)
        
        let reports = Reports()
        var metarparms = MetarParams()
        
        // test the default parameters for the request
        var urlstring = reports.getReport(metarparms, true) { (result, error) in }
        if let urlstring = urlstring,
            let theurl = URL(string: urlstring),
            let components = URLComponents(url: theurl, resolvingAgainstBaseURL: false),
            let queryItems = components.queryItems {
            
                // break apart the query parms to make sure they are valid
                for pc in queryItems {
                
                    // test the query parameters
                    switch pc.name {
                    
                    // base items on all requests
                    case "hoursBeforeNow":
                        XCTAssertTrue(pc.value == "3")
                    case "requesttype":
                        XCTAssertTrue(pc.value == "retrieve")
                    case "dataSource":
                        XCTAssertTrue(pc.value == "metars")
                    case "format":
                        XCTAssertTrue(pc.value == "xml")
                    
                    default:
                        XCTAssert(false, "The name \(pc.name) with value \(pc.value ?? "NO_VALUE") was not found in the test")
                    }
                }
            
        } else {
            XCTAssert(false, "The URL query params were not parsed")
        }

        // test for
        metarparms = MetarParams()
        
        urlstring = reports.getReport(metarparms, true) { (result, error) in }
        if let urlstring = urlstring,
            let theurl = URL(string: urlstring),
            let components = URLComponents(url: theurl, resolvingAgainstBaseURL: false),
            let queryItems = components.queryItems {
            
            // break apart the query parms to make sure they are valid
            for pc in queryItems {
                
                // test the query parameters
                switch pc.name {
                    
                // base items on all requests
                case "hoursBeforeNow", "requesttype", "dataSource", "format":
                    XCTAssert(true)

                // test the remainder of the items....
                
                    
                    
                default:
                    XCTAssert(false, "The name \(pc.name) with value \(pc.value ?? "NO_VALUE") was not found in the test")
                }
            }
            
        } else {
            XCTAssert(false, "The URL query params were not parsed")
        }

    }
    
}
