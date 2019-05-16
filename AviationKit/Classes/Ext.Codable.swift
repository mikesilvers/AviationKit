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
    @discardableResult
    public func printValues(_ printValues: Bool = false) -> [String:Any] {
        
        let mirror = Mirror(reflecting: self).children
        
        var returnItems: [String:Any] = [:]
        
        var items = ""
        for child in mirror {
            
            if let label = child.label {
                let value = child.value
                items.append("\n\n\(label): \(label)\n")
                
                returnItems["\(label)"] = printObjectValues(value)
            }
        }
        
        // print if they request
        if printValues { print(items) }
        
        return returnItems
    }
    
    /**
     Minimizes optional designation for optional types
    */
    private func printObjectValues(_ value: Any) -> Any {
        
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
            
            if let arr = value as? Array<Any> {
                // run thru the elements of the array to process
                var arrtmp : [Any] = []
                for a in arr {
                    if a is Decodable, let v = a as? Decodable {
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
        
        return returnV
    }

}

//MARK: - Encodable Extensions
extension Encodable {
    
}

