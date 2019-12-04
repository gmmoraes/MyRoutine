//
//  QueryYoutube.swift
//  MyRoutine
//
//  Created by Gabriel on 1/19/19.
//  Copyright © 2019 Gabriel. All rights reserved.
//

import Foundation
// Runs query data task, and stores results in array of Tracks
class QueryService {
    
    typealias JSONDictionary = [String: Any]
    typealias QueryResult = ([Track]?, String) -> ()
    
    var tracks: [Track] = []
    var errorMessage = ""
    var defaultSession = URLSession(configuration: .default)
    var dataTask: URLSessionDataTask?
    
    // TODO
    func getSearchResults(UrlString: String,queryPart: String, updateFunction: @escaping (_ sampleParameter: Data) -> Void, completion: @escaping QueryResult) {
        
        dataTask?.cancel()
        
        
        if var urlComponents = URLComponents(string: UrlString) {
            urlComponents.query = queryPart

            guard let url = urlComponents.url else { return }
            
            dataTask = defaultSession.dataTask(with: url) { data, response, error in
                defer { self.dataTask = nil }
                
                if let error = error {
                    self.errorMessage += "DataTask error: " + error.localizedDescription + "\n"
                } else if let data = data,
                    let response = response as? HTTPURLResponse,
                    response.statusCode == 200 {
                    print(data)
                    updateFunction(data)
                    
                    DispatchQueue.main.async {
                        completion(self.tracks, self.errorMessage)
                    }
                }
            }
        
            dataTask?.resume()
        }

    }

}
