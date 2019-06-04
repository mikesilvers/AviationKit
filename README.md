# AviationKit

[![CI Status](https://img.shields.io/travis/mikesilvers/AviationKit.svg?style=flat)](https://travis-ci.org/mikesilvers/AviationKit)
[![Version](https://img.shields.io/cocoapods/v/AviationKit.svg?style=flat)](https://cocoapods.org/pods/AviationKit)
[![License](https://img.shields.io/cocoapods/l/AviationKit.svg?style=flat)](https://cocoapods.org/pods/AviationKit)
[![Platform](https://img.shields.io/cocoapods/p/AviationKit.svg?style=flat)](https://cocoapods.org/pods/AviationKit)

## Overview
The FAA provides weather reports and additional notices on a XML based server format.  The FAA [weather server](https://www.aviationweather.gov/dataserver)   provides [METAR's](https://www.aviationweather.gov/metar), [TAF's](https://aviationweather.gov/static/help/taf-decode.php), [AIREP](https://www.aviationweather.gov/airep/help), [AIR/SIGMET's](https://aviationweather.gov/sigmet/help), [G-AIRMET's](https://aviationweather.gov/gairmet/help), and STATION INFO.

The initial release of the library contains basic METAR and TAF information based on location.  As the library grows, additional functionality and additional reports will be added.

## Example

The pod contains a fully functional example app.  To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements
In order to keep the library up to date, we will develop one OS level behind the current iOS version.  For example, as iOS current version is 12, we will develop this project at iOS version 11.  When iOS version 13 is released, this project will update to iOS 12 and the back level.  

## Installation

AviationKit is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'AviationKit'
```

## Screenshots

| METAR By Location | TAF By Location |
| :----- | :------ |
| ![METAR by location](https://github.com/mikesilvers/AviationKit/blob/master/images/metar-location-1.png) | ![TAF by location](https://github.com/mikesilvers/AviationKit/blob/master/images/taf-location-1.png)

| METAR Sample | TAF Sample |
| :--- | :--- |
| ![METAR Sample](https://github.com/mikesilvers/AviationKit/blob/master/images/metar-sample-1.png) | ![TAF Sample](https://github.com/mikesilvers/AviationKit/blob/master/images/taf-sample-1.png)

## Usage
The reports are created using the base report function and the proper report parameter structure.  The core reporting function is:

```
let reports = Reports()
reports.getReport(parmStructure) { (results, error) in 
    // code here 
}
```
### METAR
The METAR report is generated using the `MetarParams` structure.  There are no parameter checking processes.  

You are responsible for setting the correct parameters as described in the [FAA weather site](https://www.aviationweather.gov/dataserver/example?datatype=metar).  

If you set incorrect parameters, the error is returned from the API endpoint in the `error` variable of the closure.

METAR example:

```
var metarParms = MetarParams()
metarParms.areaConstraint = AreaConstraints(Coordinates(location.longitude, location.latitude), milesRadius)

let reports = Reports()
reports.getReport(metarParms) { (results, error) in
    
    if let res = results, let resultsarray = res as? [METAR] {
    	// process the METAR array
    } else {
    	// process the error
    }
    
}           
```

### TAF
The TAF reports are still using the older functions.  You use the `Comms` object ro get the TAF information.  There are only a few options at this time - more updates to come!

TAF example: 

```
let location = CLLocationCoordinate2D(latitude: 38.920898, longitude:-77.031372)
let milesRadius = 10

let comms = Comms()
comms.getTAF(location, milesRadius) { (results, error) in

	// process the results array of [TAF] objects
	
}
```

## Author

Mike Silvers, mikesilvers@gmail.com

## License

AviationKit is available under the MIT license. See the LICENSE file for more info.