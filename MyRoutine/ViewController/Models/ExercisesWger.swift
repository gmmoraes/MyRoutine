//
//  ExercisesWger.swift
//  MyRoutine
//
//  Created by Gabriel on 1/12/19.
//  Copyright © 2019 Gabriel. All rights reserved.
//


import Foundation

struct ExercisesWger: Codable {
    //let id: Int
    let name_original: String

    
    enum CodingKeys: String, CodingKey {
        //case id
        case name_original
    }
    
}

struct SearchResults<T: Decodable>: Decodable {
    let results: [T]
}
