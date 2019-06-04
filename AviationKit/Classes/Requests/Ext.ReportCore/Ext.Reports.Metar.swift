//
//  Ext.Comms.Metar.swift
//  AviationKit
//
//  Created by Mike Silvers on 6/2/19.
//

import Foundation

extension ReportCore {

    mutating func setupMetar(_ params:MetarParams) {
        
        // refer to: https://www.aviationweather.gov/dataserver/example?datatype=metar
        urlParams?["dataSource"] = params.dataSource
        
        // lets start creating our request -- do we have stations?
        if let stat = params.stationConstraints, let stations = stat.stationString {
            // lets process the station constrants (station identifiers)
            urlParams?["stationString"] = stations.joined(separator: ",")
            
            if let hbn = stat.mostRecentForEachStation {
                urlParams?["mostRecentForEachStation"] = hbn.rawValue
            }
        }

        // add the most recent
        if let mr = params.mostRecent {
            urlParams?["mostRecent"] = mr.description
        }
        
        // process the time constraints
        if let tcbn = params.timeConstraints.hoursBeforeNow {
            urlParams?["hoursBeforeNow"] = tcbn.description
        } else if let stend = params.timeConstraints.startEnd {
            urlParams?["startTime"] = stend.startTime.description
            urlParams?["endTime"]   = stend.endTime.description
        } else {
            // the default of 3 hours
            urlParams?["hoursBeforeNow"] = "3"
        }
        
        // do we have most recent?
        if let _ = params.coordinateRectangle,
            let _ = params.areaConstraint {
            
            // this is an error - we will not use either
            
        } else if let ac = params.areaConstraint {
            urlParams?["radialDistance"] = "\(ac.radiusInMiles);\(ac.coordinates.longitude),\(ac.coordinates.latitude)"
        } else if let cr = params.coordinateRectangle {
            urlParams?["minLat"] = cr.minimum.latitude.description
            urlParams?["minLon"] = cr.minimum.longitude.description
            urlParams?["maxLat"] = cr.maximum.latitude.description
            urlParams?["maxLon"] = cr.maximum.longitude.description
        }
        
        // what about flight fields?
        if let ff = params.fields {
            urlParams?["fields"] = ff.joined(separator: ",")
        }
        
        // flight path
        if let fp = params.flightPath {
            var line = "\(fp.maxDistanceInMiles)"
            let fpc = fp.flightPathCoordinates
            for fpe in fpc.sorted(by: { $0.leg < $1.leg }) {
                if let ss = fpe.stationString {
                    // station string
                    line.append(";\(ss)")
                } else if let sp = fpe.startPoint, let ep = fpe.endPoint {
                    // add the start point and end point of the path
                    line.append(";\(sp.longitude),\(sp.latitude)")
                    line.append(";\(ep.longitude),\(ep.latitude)")
                }
            }
            
            // add it to the params
            urlParams?["flightPath"] = line
        }
        
        // minimum degree distances
        if let mdd = params.minimumDegreeDistance {
            urlParams?["minDegreeDistance"] = mdd.description
        }
    }
}
