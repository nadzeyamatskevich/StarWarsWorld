//
//  SWMovieModel.swift
//  StarWarsWorld
//
//  Created by мак on 07.07.2018.
//  Copyright © 2018 мак. All rights reserved.
//

import Foundation

class SWMovie: Decodable {
    
    let title: String
    let episode_id: Int
    let release_date: String
    let director: String
    let opening_crawl: String
    let url: String
    let characters: [String]
}

class SWMovieResponse: Decodable {

    let count: Int
    let next: String?
    let previous: String?
    let results: [SWMovie]
}
