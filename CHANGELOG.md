## Change Log: Master Branch
The change log contains all version updates and information.

### Version 1.1.1
* Changed the `TimeConstraints.hoursBeforeNow` from an `Int` to a `Double` to allow for more precise time.
* Added more documentation - with tables, words and other fun stuff!
* Added tests related to the `METAR`.  The tests cover the query parameters of the call itself.  We need to make sure the parameters are getting added to the query string properly.


### Version 1.1.0

* Reworked the report generation process.  The core processes were changed to be more generic and be driven by the use of parameter structures.  It will make the addition of new reports easier and more direct.  
* Added all parameters for the METAR reports (and have them using the new report process).  The parameters are described on the [FAA weather website](https://www.aviationweather.gov/dataserver/example?datatype=metar).
* Updated the documentation to show the usage of the new processes.

### Version 1.0.1

* Minor changes to the README and associated documentation.

### Version 1.0.0: Initial Release
This is the primary release and contains the following:

* [METAR](https://aviationweather.gov/dataserver):
	* The following functionality has been implemented.
		* Radial Distance: the distance (in miles) from the latitude and longitude specified.
		* Latitude & Longitude: the center point for the radial distance.
		* Data Source: The type of report to retrieve.  `metars` is the type of report we are accessing.
		* Most Recent: `true` will return only one report, the most recent report.  `false` will return all reports within the timeline indicated.
		* Hours Before Now: The number of hours prior to the request time for data.  The maximum number of hours is 3.
		* Request type: the type of request: `retrieve` used to retrieve data.
		* Data Format: indicates the type of service to be used.  The default is XML.  We only process XML in this project.
* [TAF](https://aviationweather.gov/dataserver)
	* The following functionality has been implemented.
		* Radial Distance: the distance (in miles) from the latitude and longitude specified.
		* Latitude & Longitude: the center point for the radial distance.
		* Data Source: The type of report to retrieve.  `metars` is the type of report we are accessing.
		* Most Recent: `true` will return only one report, the most recent report.  `false` will return all reports within the timeline indicated.
		* Hours Before Now: The number of hours prior to the request time for data.  The maximum number of hours is 3.
		* Request type: the type of request: `retrieve` used to retrieve data.
		* Data Format: indicates the type of service to be used.  The default is XML.  We only process XML in this project.
		
* Example Project.
The sample project provided displays sample METAR data and sample TAF data.  The sample project also provides a map and actively queries METAR and TAF data using the GPS from your phone.
