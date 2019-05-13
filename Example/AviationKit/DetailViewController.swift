//
//  DetailViewController.swift
//  AviationKit_Example
//
//  Created by Mike Silvers on 5/10/19.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import UIKit
import AviationKit

class DetailViewController: UIViewController {

    var currentItem : Codable?
    
    @IBOutlet var doneButton : UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let ci = currentItem {
            
            if ci is METAR {
                setupMETAR(ci as! METAR)
            } else if ci is TAF {
                setupTAF(ci as! TAF)
            }
            
        }
    }
    

    private func setupTAF(_ taf: TAF) {
        
    }
    
    private func setupMETAR(_ metar: METAR) {
        
    }
    
    @IBAction func doneAction(_ sender: UIButton) {

        self.dismiss(animated: true, completion: nil)
        
    }
    
}
