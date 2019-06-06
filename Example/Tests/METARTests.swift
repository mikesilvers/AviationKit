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
            
                print("Checking the URL: \(theurl)")

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

        // test for a single station
        metarparms = MetarParams()
        metarparms.stationConstraints = StationConstraints(["KDCA"], nil)
        
        urlstring = reports.getReport(metarparms, true) { (result, error) in }
        if let urlstring = urlstring,
            let theurl = URL(string: urlstring),
            let components = URLComponents(url: theurl, resolvingAgainstBaseURL: false),
            let queryItems = components.queryItems {
            
                print("Checking the URL: \(theurl)")
            
                // break apart the query parms to make sure they are valid
                for pc in queryItems {
                
                    // test the query parameters
                    switch pc.name {
                    
                    // base items on all requests
                    case "hoursBeforeNow", "requesttype", "dataSource", "format":
                        XCTAssert(true)

                    // test the remainder of the items....
                    case "stationString":
                        XCTAssertTrue(pc.value == "KDCA")

                    default:
                        XCTAssert(false, "The name \(pc.name) with value \(pc.value ?? "NO_VALUE") was not found in the test")
                    }
                }
            
        } else {
            XCTAssert(false, "The URL query params were not parsed")
        }

        // test for multiple stations
        metarparms.stationConstraints = StationConstraints(["KDCA","KIAD"], nil)
        
        urlstring = reports.getReport(metarparms, true) { (result, error) in }
        if let urlstring = urlstring,
            let theurl = URL(string: urlstring),
            let components = URLComponents(url: theurl, resolvingAgainstBaseURL: false),
            let queryItems = components.queryItems {
            
            print("Checking the URL: \(theurl)")
            
            // break apart the query parms to make sure they are valid
            for pc in queryItems {
                
                // test the query parameters
                switch pc.name {
                    
                // base items on all requests
                case "hoursBeforeNow", "requesttype", "dataSource", "format":
                    XCTAssert(true)
                    
                // test the remainder of the items....
                case "stationString":
                    XCTAssertTrue(pc.value == "KDCA,KIAD")
                    
                default:
                    XCTAssert(false, "The name \(pc.name) with value \(pc.value ?? "NO_VALUE") was not found in the test")
                }
            }
            
        } else {
            XCTAssert(false, "The URL query params were not parsed")
        }

        // test for time constraints (start and end time)
        metarparms = MetarParams()
        metarparms.stationConstraints = StationConstraints(["KDCA"], nil)
        metarparms.timeConstraints = TimeConstraints(nil, StartEnd(1559348490, 1559780490))
        
        urlstring = reports.getReport(metarparms, true) { (result, error) in }
        if let urlstring = urlstring,
            let theurl = URL(string: urlstring),
            let components = URLComponents(url: theurl, resolvingAgainstBaseURL: false),
            let queryItems = components.queryItems {
            
            print("Checking the URL: \(theurl)")
            
            // break apart the query parms to make sure they are valid
            for pc in queryItems {
                
                // test the query parameters
                switch pc.name {
                    
                // base items on all requests
                case "hoursBeforeNow", "requesttype", "dataSource", "format":
                    XCTAssert(true)
                    
                // test the remainder of the items....
                case "stationString":
                    XCTAssertTrue(pc.value == "KDCA")
                case "startTime":
                    XCTAssertTrue(pc.value == "1559348490")
                case "endTime":
                    XCTAssertTrue(pc.value == "1559780490")

                default:
                    XCTAssert(false, "The name \(pc.name) with value \(pc.value ?? "NO_VALUE") was not found in the test")
                }
            }
            
        } else {
            XCTAssert(false, "The URL query params were not parsed")
        }

        // test for most recent report
        metarparms = MetarParams()
        metarparms.stationConstraints = StationConstraints(["KDCA"], nil)
        metarparms.mostRecent = true
        
        urlstring = reports.getReport(metarparms, true) { (result, error) in }
        if let urlstring = urlstring,
            let theurl = URL(string: urlstring),
            let components = URLComponents(url: theurl, resolvingAgainstBaseURL: false),
            let queryItems = components.queryItems {
            
            print("Checking the URL: \(theurl)")
            
            // break apart the query parms to make sure they are valid
            for pc in queryItems {
                
                // test the query parameters
                switch pc.name {
                    
                // base items on all requests
                case "hoursBeforeNow", "requesttype", "dataSource", "format":
                    XCTAssert(true)
                    
                // test the remainder of the items....
                case "stationString":
                    XCTAssertTrue(pc.value == "KDCA")
                case "mostRecent":
                    XCTAssertTrue(pc.value == "true")
                    
                default:
                    XCTAssert(false, "The name \(pc.name) with value \(pc.value ?? "NO_VALUE") was not found in the test")
                }
            }
            
        } else {
            XCTAssert(false, "The URL query params were not parsed")
        }

        // test for most recent report for each station
        metarparms = MetarParams()
        metarparms.stationConstraints = StationConstraints(["KDCA"], .true)
        
        urlstring = reports.getReport(metarparms, true) { (result, error) in }
        if let urlstring = urlstring,
            let theurl = URL(string: urlstring),
            let components = URLComponents(url: theurl, resolvingAgainstBaseURL: false),
            let queryItems = components.queryItems {
            
            print("Checking the URL: \(theurl)")
            
            // break apart the query parms to make sure they are valid
            for pc in queryItems {
                
                // test the query parameters
                switch pc.name {
                    
                // base items on all requests
                case "hoursBeforeNow", "requesttype", "dataSource", "format":
                    XCTAssert(true)
                    
                // test the remainder of the items....
                case "stationString":
                    XCTAssertTrue(pc.value == "KDCA")
                case "mostRecentForEachStation":
                    XCTAssertTrue(pc.value == "true")
                    
                default:
                    XCTAssert(false, "The name \(pc.name) with value \(pc.value ?? "NO_VALUE") was not found in the test")
                }
            }
            
        } else {
            XCTAssert(false, "The URL query params were not parsed")
        }

        // test for minLat, minLon, maxLat, maxLon
        metarparms = MetarParams()
        metarparms.coordinateRectangle = CoordinateRectangle(Coordinates(-77.031372, 38.920898), Coordinates(-77.029720, 38.921920))
        
        urlstring = reports.getReport(metarparms, true) { (result, error) in }
        if let urlstring = urlstring,
            let theurl = URL(string: urlstring),
            let components = URLComponents(url: theurl, resolvingAgainstBaseURL: false),
            let queryItems = components.queryItems {
            
            print("Checking the URL: \(theurl)")
            
            // break apart the query parms to make sure they are valid
            for pc in queryItems {
                
                // test the query parameters
                switch pc.name {
                    
                // base items on all requests
                case "hoursBeforeNow", "requesttype", "dataSource", "format":
                    XCTAssert(true)
                    
                // test the remainder of the items....
                case "minLat":
                    XCTAssertTrue(pc.value == "38.920898")
                case "minLon":
                    XCTAssertTrue(pc.value == "-77.031372")
                case "maxLon":
                    XCTAssertTrue(pc.value == "-77.02972")
                case "maxLat":
                    XCTAssertTrue(pc.value == "38.92192")

                default:
                    XCTAssert(false, "The name \(pc.name) with value \(pc.value ?? "NO_VALUE") was not found in the test")
                }
            }
            
        } else {
            XCTAssert(false, "The URL query params were not parsed")
        }

        // test for radial distance
        metarparms = MetarParams()
        metarparms.areaConstraint = AreaConstraints(Coordinates(-77.031372, 38.920898), 1)
        
        urlstring = reports.getReport(metarparms, true) { (result, error) in }
        if let urlstring = urlstring,
            let theurl = URL(string: urlstring),
            let components = URLComponents(url: theurl, resolvingAgainstBaseURL: false),
            let queryItems = components.queryItems {
            
            print("Checking the URL: \(theurl)")
            
            // break apart the query parms to make sure they are valid
            for pc in queryItems {
                
                // test the query parameters
                switch pc.name {
                    
                // base items on all requests
                case "hoursBeforeNow", "requesttype", "dataSource", "format":
                    XCTAssert(true)
                    
                // test the remainder of the items....
                case "stationString":
                    XCTAssertTrue(pc.value == "KDCA")
                case "radialDistance":
                    XCTAssertTrue(pc.value == "1;-77.031372,38.920898")
                    
                default:
                    XCTAssert(false, "The name \(pc.name) with value \(pc.value ?? "NO_VALUE") was not found in the test")
                }
            }
            
        } else {
            XCTAssert(false, "The URL query params were not parsed")
        }

        // test for flight path with station identifiers
        metarparms = MetarParams()
        metarparms.flightPath = FlightPath(1.25, [CoordinatePath(1, nil, nil, "KDCA"), CoordinatePath(2, nil, nil, "KBWI")])
        
        urlstring = reports.getReport(metarparms, true) { (result, error) in }
        if let urlstring = urlstring,
            let theurl = URL(string: urlstring),
            let components = URLComponents(url: theurl, resolvingAgainstBaseURL: false),
            let queryItems = components.queryItems {
            
            print("Checking the URL: \(theurl)")
            
            // break apart the query parms to make sure they are valid
            for pc in queryItems {
                
                // test the query parameters
                switch pc.name {
                    
                // base items on all requests
                case "hoursBeforeNow", "requesttype", "dataSource", "format":
                    XCTAssert(true)
                    
                // test the remainder of the items....
                case "stationString":
                    XCTAssertTrue(pc.value == "KDCA")
                case "flightPath":
                    XCTAssertTrue(pc.value == "1.25;KDCA;KBWI")
                    
                default:
                    XCTAssert(false, "The name \(pc.name) with value \(pc.value ?? "NO_VALUE") was not found in the test")
                }
            }
            
        } else {
            XCTAssert(false, "The URL query params were not parsed")
        }

        // test for flight path with coordinates
        metarparms = MetarParams()
        metarparms.flightPath = FlightPath(1.25, [CoordinatePath(1, Coordinates(-76.668388, 39.177402),
                                                                 Coordinates(-77.042980, 38.852360), nil)])
        
        urlstring = reports.getReport(metarparms, true) { (result, error) in }
        if let urlstring = urlstring,
            let theurl = URL(string: urlstring),
            let components = URLComponents(url: theurl, resolvingAgainstBaseURL: false),
            let queryItems = components.queryItems {
            
            print("Checking the URL: \(theurl)")
            
            // break apart the query parms to make sure they are valid
            for pc in queryItems {
                
                // test the query parameters
                switch pc.name {
                    
                // base items on all requests
                case "hoursBeforeNow", "requesttype", "dataSource", "format":
                    XCTAssert(true)
                    
                // test the remainder of the items....
                case "stationString":
                    XCTAssertTrue(pc.value == "KDCA")
                case "flightPath":
                    XCTAssertTrue(pc.value == "1.25;-76.668388,39.177402;-77.04298,38.85236","\(pc.value ?? "NO VALUE")")
                    
                default:
                    XCTAssert(false, "The name \(pc.name) with value \(pc.value ?? "NO_VALUE") was not found in the test")
                }
            }
            
        } else {
            XCTAssert(false, "The URL query params were not parsed")
        }

        // test for flight path with coordinates
        metarparms = MetarParams()
        metarparms.flightPath = FlightPath(1.25, [CoordinatePath(1, Coordinates(-76.668388, 39.177402),
                                                                 Coordinates(-77.042980, 38.852360), nil),
            CoordinatePath(2, nil, nil, "KBWI"), CoordinatePath(3, nil, nil, "KLNS")])
        
        urlstring = reports.getReport(metarparms, true) { (result, error) in }
        if let urlstring = urlstring,
            let theurl = URL(string: urlstring),
            let components = URLComponents(url: theurl, resolvingAgainstBaseURL: false),
            let queryItems = components.queryItems {
            
            print("Checking the URL: \(theurl)")
            
            // break apart the query parms to make sure they are valid
            for pc in queryItems {
                
                // test the query parameters
                switch pc.name {
                    
                // base items on all requests
                case "hoursBeforeNow", "requesttype", "dataSource", "format":
                    XCTAssert(true)
                    
                // test the remainder of the items....
                case "stationString":
                    XCTAssertTrue(pc.value == "KDCA")
                case "flightPath":
                    XCTAssertTrue(pc.value == "1.25;-76.668388,39.177402;-77.04298,38.85236;KBWI;KLNS","\(pc.value ?? "NO VALUE")")
                    
                default:
                    XCTAssert(false, "The name \(pc.name) with value \(pc.value ?? "NO_VALUE") was not found in the test")
                }
            }
            
        } else {
            XCTAssert(false, "The URL query params were not parsed")
        }

    }
    
}
