//
//  WgerApi.swift
//  MyRoutine
//
//  Created by Gabriel on 1/12/19.
//  Copyright © 2019 Gabriel. All rights reserved.
//

import Foundation
import Siesta

let wgerApi = WgerApi()
//fileprivate

class WgerApi {
    static let sharedInstance = WgerApi()
    let ApiEP = "/api/v2/exercise/?format=json&license_author=wger.de&limit=500"
    ///api/v2/exercise/?limit=500&license_author=wger.de
    
    
    private let service = Service(baseURL: "https://wger.de", standardTransformers: [.text, .image, .json])
    //https://wger.de/api/v2/exercise/?limit=500&license_author=wger.de
    //private
    fileprivate init() {
        
        let jsonDecoder = JSONDecoder()
        
        service.configureTransformer(ApiEP) {
            try jsonDecoder.decode(SearchResults<ExercisesWger>.self, from: $0.content).results
        }
        
        
        // 2
        SiestaLog.Category.enabled = [.network, .pipeline, .observers]
        
        service.configure("**") {
            
            // 3
            //$0.headers["Authorization"] =
            //"Bearer uyLqdyV33s7KBJ4IPy89H9f2b3p3XpnDkRXy0ybJlAlaPSe_7Pd2JLgtT-NV-Lh4RnLwyv-XEfEGE3IJL_qlAAEeuosPEq93DSdCmwtBS7CjWNSH9ZqviYjIixwMXHYx"
            
            // 4
            $0.expirationTime = 60 * 60 // 60s * 60m = 1 hour
        }
    }
    
    func exerciseList() -> Resource {
        return service
            .resource(ApiEP)
    }
    
    
}


