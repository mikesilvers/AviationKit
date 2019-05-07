//
//  MainViewController.swift
//  AviationKit
//
//  Created by Mike Silvers on 5/6/19.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import UIKit
import AviationKit

class MainViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate {
    
    @IBOutlet weak var tableView         : UITableView!
    
    @IBOutlet weak var airportLabel      : UILabel!
    @IBOutlet weak var airportCode       : UITextField!
    @IBOutlet weak var metarTafSelection : UISegmentedControl!

    private var tableData : [Any] = []
    
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

        if td is METAR {
            cell = tableView.dequeueReusableCell(withIdentifier: "MetarCell", for: indexPath)
        } else if td is TAF {
            cell = tableView.dequeueReusableCell(withIdentifier: "TafCell", for: indexPath)
        }
        
        return cell
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
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
            
            // this is for testing
            if let path = Bundle.main.url(forResource: "metars.cache", withExtension: "xml"),
                let document = try? String(contentsOf: path, encoding: .utf8) {
                
                let _ = MetarParser(document)
                
            }
            
            
            
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
        case 3:
            // this is the TAC (location)
            airportLabel.isHidden = true
            airportCode.isHidden  = true
            airportCode.text      = ""
            airportCode.resignFirstResponder()
        default :
            airportLabel.isHidden = true
            airportCode.isHidden  = true
            airportCode.text      = ""
            airportCode.resignFirstResponder()
        }
        
    }

}
