//
//  SWSpecie.swift
//  StarWarsWorld
//
//  Created by мак on 08.07.2018.
//  Copyright © 2018 мак. All rights reserved.
//

import Foundation

struct SWSpecies: Decodable {
        
    let name: String
    let url: String
}

struct SWSpeciesResponse: Decodable {
    
    let count: Int
    let next: String?
    let previous: String?
    let results: [SWSpecies]
}
