//
//  Extensions.swift
//  AviationKit
//
//  Created by Mike Silvers on 5/12/19.
//

import Foundation

// MARK: - Encodable extensions

extension Encodable {
    
    /**
     Allows an Encodable object to be converted to a Dictionary
     
     - Returns: An optional `[String:Any]` dictionary representing the data in the codable object
    */
    func asDictionary() -> [String:Any]? {
        
        if let data = try? JSONEncoder().encode(self) {
            return (try? JSONSerialization.jsonObject(with: data) as? [String:Any]) ?? nil
        }
        
        return nil
    }
}

// MARK: - URL extensions
extension URL {
    
    /**
     Add, update, or remove a group of query string parameters from the URL
     
     - parameter items: the dictionary of query string parameters to replace
     
     - returns: the URL with the mutated query string
     */
    mutating func appendQueryItems(_ items: [String: String]) {
        
        // if we can not create the URL components, then do not continue
        guard var urlComponents = URLComponents(url: self, resolvingAgainstBaseURL: false), !items.isEmpty else {
            return
        }
        
        // process the items passed in
        let keys = items.keys.map { $0 }
        
        // make sure we do not duplkcate the query string items - this means that we will use the new values in place of the existing values (if they exist)
        urlComponents.queryItems = urlComponents.queryItems?.filter { !keys.contains($0.name) } ?? []
        
        // add the new items to the query string
        urlComponents.queryItems?.append(contentsOf: items.map {
            return URLQueryItem(name: $0.key, value: $0.value)
        })
        
        // if there is a problem with the newly created URL, return and make no changes
        guard let theNewURL = urlComponents.url else { return }
        
        // update the existing URL
        self = theNewURL
    }
    
    /**
     Add, update, or remove a single query string from the URL
     
     - parameter key:   The key of the item you are adding to the query string.
     - parameter value: The value of the item you are adding to the query string.
     
     - returns: the URL with the mutated query string
     */
    mutating func appendQueryItem(key: String, value: String) {
        
        // if there is a problem with the passed in parameters, exit without changes
        guard var urlComponents = URLComponents(url: self, resolvingAgainstBaseURL: false) else {
            return
        }
        
        // add the new query items
        urlComponents.queryItems?.append(URLQueryItem(name: key, value: value))
        
        // if there is a problem with the newly created URL, return and make no changes
        guard let theNewURL = urlComponents.url else { return }
        
        // update the existing URL
        self = theNewURL
    }
}
