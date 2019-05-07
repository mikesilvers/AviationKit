//
//  MetarParser.swift
//  AviationKit
//
//  Created by Mike Silvers on 5/7/19.
//

import Foundation

public class MetarParser : NSObject, XMLParserDelegate {

    private var metars : [METAR] = []
    private var currentMetar  = METAR()
    
    private var currentElement = ""
    
    public override init() { }
    
    public convenience init(_ document: String ) {
        self.init()
        
        self.parseDocument(document)
        
    }
    
    public func parseDocument(_ document: String) {
        
        if let parsedata = document.data(using: .utf8) {
            
            let parser = XMLParser(data: parsedata)
            parser.delegate = self
            parser.parse()
            
        }
        
    }
    
    private func parserDidStartDocument(_ parser: XMLParser) {
        
    }
    
    private func parserDidEndDocument(_ parser: XMLParser) {
        
    }
    
    private func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        
        print("didStartElement: \(elementName)  qualifiedName: \(qName ?? "")  attributes: \n\(attributeDict)")
        
        currentElement = elementName
        
        switch elementName {
        case "METAR":
            currentMetar = METAR()
            currentElement = ""
        default:
            print("Element \(elementName) NOT started")
            currentElement = ""
        }
        
        
    }
    
    private func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {

        print("didEndElement: \(elementName)  qualifiedName: \(qName ?? "")")
        
        switch elementName {
        case "METAR":
            metars.append(currentMetar)
        default:
            print("Element \(elementName) NOT ended")
        }

        currentElement = ""

    }
    
    private func parser(_ parser: XMLParser, foundCharacters string: String) {
        
        let data = string.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        
        if !data.isEmpty {
            print("parser current element: \(currentElement) foundCharacters: \(data)")
            
            switch currentElement {
            default:
                print("The currentElement was NOT found for foundCharacters")
            }
        }

    }
    
}
