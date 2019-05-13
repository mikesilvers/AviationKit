//
//  MainViewController.swift
//  AviationKit
//
//  Created by Mike Silvers on 5/6/19.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import UIKit
import AviationKit


//class TestGeneric<L : Codable>: Codable {
//    private var theGeneric : L?
//}

class MainViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate {
    
    @IBOutlet var tableView         : UITableView!
    
    @IBOutlet var airportLabel      : UILabel!
    @IBOutlet var airportCode       : UITextField!
    @IBOutlet var metarTafSelection : UISegmentedControl!

    private var tableData : [Any] = []
    private var currentItem : Codable?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        airportLabel.isHidden = true
        airportCode.isHidden  = true
        airportCode.text      = ""

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
            
            if let lon = m.longitude, let lat = m.latitude {
                cell.detailTextLabel?.text = "(\(lat), \(lon))"
            }
            
        } else if td is TAF {
            
            let m = td as! TAF
            
            if let lon = m.longitude, let lat = m.latitude {
                cell.detailTextLabel?.text = "(\(lat), \(lon))"
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
    
    
    // MARK: UITextFieldDelegate functions
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange,  replacementString string: String) -> Bool {
        
        // the first letter is 'K' and there are only 4 characters per
        if let tfc = textField.text?.count, ((tfc == 1 && string == "") || (tfc >= 4 && string != "")) { return false }
        
        // check for letters - they will all be capital
        if let ucs = string.unicodeScalars.first, CharacterSet.letters.contains(ucs) { return true }
        
        // check for the backspace
        if string == "" { return true }
        
        return false
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        // if the text is 3 or 4 long, run the process
        
        if let tfc = textField.text, tfc.count > 1 && tfc.count >= 3 {
            print("We did end editing: \(tfc)")
        }
    }
    
    // MARK: Segmented Controller functions
    @IBAction func fillMetarTaf(_ sender : UISegmentedControl) {
        
        switch sender.selectedSegmentIndex {
        case 0:
            
            // this is METAR Airport Code
            airportLabel.isHidden = false
            airportCode.isHidden  = false
            airportCode.text      = "K"
            airportCode.becomeFirstResponder()
            
        case 1:
            
            // this is TAC Airport Code
            airportLabel.isHidden = false
            airportCode.isHidden  = false
            airportCode.text      = "K"
            airportCode.becomeFirstResponder()
            
        case 2:
            
            // this is the METAR (location)
            airportLabel.isHidden = true
            airportCode.isHidden  = true
            airportCode.text      = ""
            airportCode.resignFirstResponder()
            
            // add the demo data
            let mp = MetarParser()
            if let data = mp.demoMETAR.data(using: .utf8) {
                mp.parseDocument(data) { (metar) in
                    self.tableData = metar
                    self.tableView.reloadData()
                }
            }
            
        case 3:
            
            // this is the TAC (location)
            airportLabel.isHidden = true
            airportCode.isHidden  = true
            airportCode.text      = ""
            airportCode.resignFirstResponder()

            // add the demo data
            let mp = TafParser()
            if let data = mp.demoTAF.data(using: .utf8) {
                mp.parseDocument(data) { (taf) in
                    self.tableData = taf
                    self.tableView.reloadData()
                }
            }

        default :
            
            airportLabel.isHidden = true
            airportCode.isHidden  = true
            airportCode.text      = ""
            airportCode.resignFirstResponder()
            
        }
        
    }

}
