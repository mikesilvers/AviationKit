//
//  Ext.Codable.swift
//  AviationKit
//
//  Created by Mike Silvers on 5/16/19.
//

import Foundation

//MARK: - Decodable Extensions
extension Decodable {
    
    // MARK: - Print Values
    /**
     Prints the values and returns a dictionary of the values
     
     Allows the printing of the `Decodable` values and returns a dictionary of the values.
     
     - Parameter printValues: Defaulrs to `false`.  Whenn `true`, the values are printed to `stdout`.
     
     - Returns: A dictionary of keys and values for the contents of the model.
    */
    @discardableResult
    public func printValues(_ printValues: Bool = false) -> [String:Any] {
        
        // we are using mirror to pull out the variables and their values
        let mirror = Mirror(reflecting: self).children
        
        var returnItems: [String:Any] = [:]
        
        // spin thru the children
        var items = ""
        for child in mirror {
            
            if let label = child.label {
                let value = child.value
                items.append("\n\n\(label): \(label)\n")
                
                returnItems["\(label)"] = processObjectValues(value)
            }
        }
        
        // print if they request
        if printValues { print(items) }
        
        // return the newly minted dictionary of key/values
        return returnItems
    }
    
    /**
     Private function to process the individual values
     
     Processes the optional values and makes them not optional
     
     - Parameter value: The value to be processed
     
     - Returns: The non-optional value
    */
    private func processObjectValues(_ value: Any) -> Any {
        
        var returnV = value
        
        // the object is to remove the optional from these items when printed
        switch value {
        case is Bool:
            if let s = (value as? Bool) { returnV = s as Any }
        case is String:
            if let s = (value as? String) { returnV = s as Any }
        case is Int:
            if let s = (value as? Int) { returnV = s as Any }
        case is Double:
            if let s = (value as? Double) { returnV = s as Any }
        case is Decimal:
            if let s = (value as? Decimal) { returnV = s as Any }
        case is Array<Any>:
            
            // process an array of objects
            if let arr = value as? Array<Any> {
                // run thru the elements of the array to process
                var arrtmp : [Any] = []
                for a in arr {
                    if a is Decodable, let v = a as? Decodable {
                        // recursively process the array
                        arrtmp.append(v.printValues())
                    }
                }
                returnV = arrtmp as Any
            }
            
        case is Set<AnyHashable>:
            if let s = (value as? Set<AnyHashable>) { returnV = s as Any }
        case is Dictionary<AnyHashable, Any>:
            if let s = (value as? Dictionary<AnyHashable, Any>) { returnV = s as Any }
        default:
            
            // if the object being checked is Decodable, it will have printObjects function
            if value is Decodable, let v = value as? Decodable {
                returnV = v.printValues()
            }
        }
        
        // return the non-optional item
        return returnV
    }

}
