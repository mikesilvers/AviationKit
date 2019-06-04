//
//  MainViewController.swift
//  AviationKit
//
//  Created by Mike Silvers on 5/6/19.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import UIKit
import MapKit
import AviationKit
import CoreLocation

//class TestGeneric<L : Codable>: Codable {
//    private var theGeneric : L?
//}

class MainViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate {
    
    @IBOutlet var centerbutton      : UIButton!
    @IBOutlet var tableView         : UITableView!
    @IBOutlet var metarTafSelection : UISegmentedControl!
    @IBOutlet var mapView           : MKMapView!
    
    private var tableData : [Any] = []
    private var currentItem : Codable?
    
    private var locationManager = CLLocationManager()
    
    internal var initialLocation = CLLocationCoordinate2D(latitude: 0.0, longitude: 0.0)
    internal var lastLocation    = CLLocationCoordinate2D(latitude: 0.0, longitude: 0.0)
    internal var milesRadius     = 10
    
    internal var dateformatter = DateFormatter()
    
    // MARK: - View functions
    override func viewDidLoad() {
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        
        // register the custom annotation to use the annotation view
        mapView.register(MKMarkerAnnotationView.self, forAnnotationViewWithReuseIdentifier: NSStringFromClass(WeatherAnnotation.self))
        
        // configure the date formatter for conversion between epoch time and the
        // time passed in ISO8601 UTC format
        dateformatter.dateFormat = "MM/dd/yyyy HH:mm:ss z"
        dateformatter.timeZone = TimeZone.current

    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let status = CLLocationManager.authorizationStatus()
        switch status {
        case .authorizedWhenInUse:
            locationManager.startUpdatingLocation()
        case .denied:
            DisplayMessages.deniedLocation(self, locationManager)
        default:
            DisplayMessages.requestLocation(self, locationManager)
        }
        
    }
    
    // MARK: - Table view data source
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
        var cell = UITableViewCell()
        
        let td = tableData[indexPath.row]

        cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        if td is METAR {
            
            let m = td as! METAR
            
            if let mt = m.stationId { cell.textLabel?.text = "METAR: \(mt)" }
            
            if let obt = m.observationTime {
                let ts = dateformatter.string(from: Date(timeIntervalSince1970: Double(obt)))
                cell.detailTextLabel?.text = "Observed: \(ts)"
            }
            
        } else if td is TAF {
            
            let m = td as! TAF
            
            if let mt = m.stationId { cell.textLabel?.text = "TAF: \(mt)" }

            if let obt = m.toTime {
                let ts = dateformatter.string(from: Date(timeIntervalSince1970: Double(obt)))
                cell.detailTextLabel?.text = "Valid Until: \(ts)"
            }

        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // deselect the cell
        tableView.deselectRow(at: indexPath, animated: false)
        
        // now show the details
        if let ci = tableData[indexPath.row] as? Codable {
            currentItem = ci
            self.performSegue(withIdentifier: "DetailSegue", sender: self)
        }
        
    }

    
    // MARK: - Navigation
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {

        // only allow the segue to continue if the data is there
        if identifier == "DetailSegue", currentItem == nil { return false }
        
        return true
    }
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        // deal with the detail segue
        if segue.identifier == "DetailSegue" {
            let dvc = segue.destination as! DetailViewController
            dvc.currentItem = self.currentItem
        }
        
    }
    
    // MARK: Segmented Controller functions
    @IBAction func fillMetarTaf(_ sender : UISegmentedControl) {
        
        // clear the data source
        tableData = []
        
        switch sender.selectedSegmentIndex {
        case 0:
            
            tableData = []
            
            var location: CLLocationCoordinate2D
            
            // this is METAR Airport Code
            #if targetEnvironment(simulator)
                // in the simulator, we will use one single location
                location = CLLocationCoordinate2D(latitude: 38.920898,
                                                  longitude: -77.031372)
                lastLocation    = location
                initialLocation = location
            
                //set region on the map
                let region = getRegion(Double(milesRadius), lastLocation)
                mapView.setRegion(region, animated: true)

            #else
                // get the current location
                location = lastLocation

            #endif
            
            var metarParms = MetarParams()
            metarParms.areaConstraint = AreaConstraints(Coordinates(location.longitude, location.latitude), milesRadius)
            
            let reports = Reports()
            reports.getReport(metarParms) { (results, error) in
                let results = results as! [METAR]
                DispatchQueue.main.async {
                    self.tableData = results.sorted { ($0.observationTime ?? 0) > ($1.observationTime ?? 0) }
                    self.tableView.reloadData()
                    self.dropPins()
                }

            }
            
        case 1:

            tableData = []

            var location: CLLocationCoordinate2D

            // this is TAC Airport Code
            #if targetEnvironment(simulator)
                // in the simulator, we will use one single location
                location = CLLocationCoordinate2D(latitude: 38.920898,
                                                  longitude: -77.031372)
                lastLocation    = location
                initialLocation = location
            
                //set region on the map
                let region = getRegion(Double(milesRadius), lastLocation)
                mapView.setRegion(region, animated: true)

            #else
                // get the current location
                location = lastLocation
            #endif
            
            let comms = Comms()
            comms.getTAF(location, milesRadius) { (results, error) in
                DispatchQueue.main.async {
                    self.tableData = results.sorted { ($0.toTime ?? 0) > ($1.toTime ?? 0) }
                    self.tableView.reloadData()
                    self.dropPins()
                }
            }
            
        case 2:
            
            let initialLocation = CLLocation(latitude: 39.809734, longitude: -98.555618)
            let regionRadius: CLLocationDistance = 4828032   // 3000 miles
            let coordinateRegion = MKCoordinateRegion(center: initialLocation.coordinate ,
                                                      latitudinalMeters: regionRadius,
                                                      longitudinalMeters: regionRadius)
            mapView.setRegion(coordinateRegion, animated: true)
                
            tableData = []

            // add the sample data for METAR
            let mp = MetarParser()
            if let data = mp.sampleMETAR.data(using: .utf8) {
                mp.parseDocument(data) { (metar) in
                    self.tableData = metar.sorted { (($0 as! METAR).observationTime ?? 0) > (($1 as! METAR).observationTime ?? 0) }
                    self.tableView.reloadData()
                    self.dropPins()
                }
            }
            
        case 3:

            let initialLocation = CLLocation(latitude: 39.809734, longitude: -98.555618)
            let regionRadius: CLLocationDistance = 4828032     // 3000 miles
            let coordinateRegion = MKCoordinateRegion(center: initialLocation.coordinate ,
                                                      latitudinalMeters: regionRadius,
                                                      longitudinalMeters: regionRadius)
            mapView.setRegion(coordinateRegion, animated: true)

            tableData = []

            // add the sample data for TAF
            let mp = TafParser()
            if let data = mp.sampleTAF.data(using: .utf8) {
                mp.parseDocument(data) { (taf) in
                    self.tableData = taf.sorted { (($0 as! TAF).toTime ?? 0) > (($1 as! TAF).toTime ?? 0) }
                    self.tableView.reloadData()
                    self.dropPins()
                }
            }
        default:

            tableData = []

            print("This should not occur")
        }
    }
    
    // MARK: - Map Functions
    internal func dropPins() {
        
        // remove the current pins
        for p in mapView.annotations {
            mapView.removeAnnotation(p)
        }
        
        // add the new pins
        for p in tableData {
            
            let pin = WeatherAnnotation()
            var loc = CLLocationCoordinate2D()
            
            if p is METAR, let p1 = p as? METAR,
                let lat = p1.latitude, let lon = p1.longitude,
                let title = p1.stationId {
                    loc.latitude   = lat
                    loc.longitude  = lon
                    pin.coordinate = loc
                    pin.title      = title
                    pin.subtitle   = "Latitude: \(lat), Longitude: \(lon)"
            } else if p is TAF, let p1 = p as? TAF,
                let lat = p1.latitude, let lon = p1.longitude,
                let title = p1.stationId {
                    loc.latitude = lat
                    loc.longitude = lon
                    pin.coordinate = loc
                    pin.title      = title
                    pin.subtitle   = "Latitude: \(lat), Longitude: \(lon)"
            }
            
            // now drop the pin
            mapView.addAnnotation(pin)
        }
    }
    
    // MARK: - Button functions
    @IBAction func centerMap(_ sender: UIButton) {
        
        let region = getRegion((Double(milesRadius) * 2.0), lastLocation)
        
        #if targetEnvironment(simulator)
            mapView.setCenter(lastLocation, animated: true)
        #else
            mapView.setCenter(mapView?.userLocation.coordinate ?? lastLocation, animated: true)
        #endif
        
        mapView.setRegion(region, animated: true)
        
    }
    
}
