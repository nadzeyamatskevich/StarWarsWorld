//
//  SWPlanet.swift
//  StarWarsWorld
//
//  Created by мак on 08.07.2018.
//  Copyright © 2018 мак. All rights reserved.
//

import Foundation

class SWPlanet: Decodable {

    let name: String
    let population: String
    let climate: String
    let diameter: String
    let terrain: String
    let url: String

}

class SWPlanetResponse: Decodable {

    let count: Int
    let next: String?
    let previous: String?
    let results: [SWPlanet]

}
