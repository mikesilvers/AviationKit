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
    @IBOutlet var textView   : UITextView!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let ci = currentItem {
            setupDisplay(ci as AnyObject)
        }
    }
    
    private func setupDisplay(_ item: AnyObject) {

        let font     = [NSAttributedString.Key.font:UIFont.systemFont(ofSize: 14.0)]
        let boldfont = [NSAttributedString.Key.font:UIFont.boldSystemFont(ofSize: 14.0)]
        
        var text = NSMutableAttributedString()

        if let it = item as? Decodable {
            let tmpValues = it.printValues()
            
            for tmp in tmpValues {
                text.append(NSAttributedString(string: "\(tmp.key): ", attributes: boldfont))
                text.append(NSAttributedString(string: "\(tmp.value)\n\n", attributes: font))
            }
        
            if tmpValues.count == 0 {
                text = NSMutableAttributedString(string: "No results found", attributes: font)
            }
        }
        
        textView.attributedText = text

    }
    
    @IBAction func doneAction(_ sender: UIButton) {

        self.dismiss(animated: true, completion: nil)
        
    }
    
}
