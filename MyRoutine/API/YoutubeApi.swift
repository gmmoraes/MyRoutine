//
//  YoutubeApi.swift
//  MyRoutine
//
//  Created by Gabriel on 1/14/19.
//  Copyright © 2019 Gabriel. All rights reserved.
//

import Foundation
import Siesta

/**class YoutubeApi {
    static let sharedInstance = YoutubeApi()
    
    let apiKey = "AIzaSyAcI8Tb5nOGhOEPaxbfDwoyP1bauoaZgAQ"
    let UrlParameter = "/youtube/v3/search"
    
    // 1
    private let service = Service(baseURL: "https://www.googleapis.com", standardTransformers: [.text, .image])
    
    private init() {
        
        let jsonDecoder = JSONDecoder()
        
        service.configureTransformer(UrlParameter) {
            try jsonDecoder.decode(SearchVideos<VideoList>.self, from: $0.content).items
        }
        
        
        // 2
        SiestaLog.Category.enabled = [.network, .pipeline, .observers]
        
        service.configure("**") {
            
            // 3
            //$0.headers["Authorization"] =
            //"Bearer 232095424833-air9vln7kado70g69gu6p77tucbgh1id.apps.googleusercontent.com"
            
            // 4
            $0.expirationTime = 60 * 60 // 60s * 60m = 1 hour
        }
    }
    
    func videoList(for videoName: String) -> Resource {
        return service
            .resource(UrlParameter)
            .withParam("part", "snippet")
            .withParam("type", "video")
            .withParam("q", videoName)
            .withParam("key", "AIzaSyAcI8Tb5nOGhOEPaxbfDwoyP1bauoaZgAQ")
    }
    
    
}**/



