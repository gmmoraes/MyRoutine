//
//  Track.swift
//  MyRoutine
//
//  Created by Gabriel on 1/16/19.
//  Copyright © 2019 Gabriel. All rights reserved.
//


import Foundation.NSURL

// Query service creates Track objects
class Track {
    
    let etag: String
    let snippet:  [String : AnyObject]
    //videoId: String //"https://www.youtube.com/watch?=\(videoId)"
    //var thumbnails: AnyObject
    let id: [String : AnyObject]
    
    //fhp-QLmrHAE

    init(etag: String, snippet:  [String : AnyObject], id: [String : AnyObject]) {
        self.etag = etag
        self.snippet = snippet
        self.id = id
    }
    
}
