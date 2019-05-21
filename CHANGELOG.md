## Change Log: Master Branch
The change log contains all version updates and information.

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
