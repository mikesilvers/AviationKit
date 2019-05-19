//
//  CodableHTTP.swift
//  AviationKit
//
//  Created by Mike Silvers on 5/13/19.
//

import Foundation

/**
 A singleton class used to make the HTTP requests
 
 The purpose of this class is to perform HTTP requests and return the data in a completion block.
 */
class ProcessHTTP {
    
    // create the singleton:
    private init() { }
    static let shared = ProcessHTTP()

    // MARK: - Request functions
    
    /**
     Creates the request and executes the same.
     
     This function actually creates the request and processes it.  The return information is in a completion block.
     
     - Parameter theRequest: a `NetworkingCodableProtocol` used to create the actual HTTP request
     - Parameter responseType: a `DecodableSuccess` type that defines the object to be returned
     - Parameter requestBody: an `Encodable` object that contains the data for the HTTP body in a request.
     - Parameter XMLParserCore: an `XMLParserDelegate` object that contains the XMLParser for the HTTP body in a request.
     - Parameter withDecoder: an optional decoder used to process the request.  If no `JSONDecoder` is passed, the default `JSONDecoder` is used.
     - Parameter completion: the completion block containing the following arameters:
     - Parameter : The first completion block parameter.  This is an optional successfully decoded bject representing the data returned
     - Parameter DecodableSuccess: HTTPURLResponse: An optional HTTP response.  Included to allow further processing and setermination of errors.  This object includes the status codes and other return information from the HTTP server.
     - Parameter Data: An optional data represetation of the data returned.  Provided to allow for further processing, if needed.
     - Parameter Error: An optional error representing errors if they occur during the call.  This does not include status codes as they are represented by the HTTPURLResponse parameter.
     */
    func makeRequest<GenericRequest : NetworkingCodableProtocol, DecodableSuccess : Decodable, HTTPBody: Encodable, XMLParserCore: XMLCustomParserProtocol>
        (_ theRequest  : GenericRequest,
         responseType  : DecodableSuccess.Type,
         requestBody   : HTTPBody,
         xmlParser     : XMLParserCore? = nil,
         _ withDecoder : JSONDecoder?=nil,
         _ completion  : @escaping (DecodableSuccess?, [Any]?, HTTPURLResponse?, Data?, Error?)->Void) {
        
        // Make it so we can change the decoder depending on the request requirements and desired codable model types.
        let theDecoder = withDecoder ?? JSONDecoder()
        
        // Start forming our request:
        var url = theRequest.baseUrl
        
        // add all of the URL parameters for the query string
        if let urlParams = theRequest.urlParams {
            url.appendQueryItems(urlParams)
        }
        
        // the optional offset/limit parameters
        if let offsetLimit = theRequest.offsetLimit {
            url.appendQueryItem(key: "offset", value: "\(offsetLimit.offset)")
            url.appendQueryItem(key: "limit", value: "\(offsetLimit.limit)")
        }
        
        // prepare the actual request for processing
        var request = URLRequest(url: url)
        request.httpMethod = theRequest.method.rawValue
        request.httpBody = try? JSONEncoder().encode(requestBody)
        
        // adding in the headers (includes the authentication token)
        if let requestHeaders = theRequest.headers {
            request.allHTTPHeaderFields = requestHeaders
        }
        
        // process the actual request
        URLSession.shared.dataTask(with: request) { (theData, response, error) in
            
            // prepare the response for return in the completion
            let httpResponse = response as? HTTPURLResponse
            
            // Check the URLSession Error:
            if (error != nil) {
                // return the completion when there is an error
                completion(nil, nil, httpResponse, theData, error)
                return
            }
            
            // lets see if this is an XML
            if let xml = xmlParser, let theD = theData {
                
                xml.parseDocument(theD, completion: { (result) in
                    
                    completion(nil, result, httpResponse, theData, error)
                    
                })
                
            }
            
            
            
            // process the data returned from the async call
            if (theData != nil) {
                do {
                    // First try decoding the JSON to CodableSuccess generic type:
                    let successResponse = try theDecoder.decode(responseType, from: theData!)
                    // return the completion block
                    completion(successResponse, nil, httpResponse, theData, nil)
                    return
                } catch {
                    // return the completion block when there is an error
                    completion(nil, nil, httpResponse, theData, error)
                    return
                }
            } else {
                // when there was no data returned (a server error), lets make sure we still return - so there is no app error
                completion(nil, nil, httpResponse, theData, error)
            }
            
        }.resume()
    }
}
