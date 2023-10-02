//
//  SWCharacterModel.swift
//  StarWarsWorld
//
//  Created by мак on 07.07.2018.
//  Copyright © 2018 мак. All rights reserved.
//

import Foundation

struct SWCharacter: Decodable {

    let name: String
    let gender: String
    let birth_year: String
    let homeworld: String
    let url: String
    let species: [String]
    let films: [String]
}

struct SWCharacterResponse: Decodable {

    let count: Int
    let next: String?
    let previous: String?
    let results: [SWCharacter]
}
