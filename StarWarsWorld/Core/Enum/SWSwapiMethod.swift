//
//  SWSwapiMethod.swift
//  StarWarsWorld
//
//  Created by Nadzeya Savitskaya on 2023-10-02.
//  Copyright © 2023 nadzeyamatskevich. All rights reserved.
//

import Foundation

enum SWSwapiMethod {
    case people
    case films
    case planets
    case species

    var url: URL {
        switch self {
        case .people: return URL(string: "https://swapi.dev/api/people/")!
        case .films: return URL(string: "https://swapi.dev/api/films/")!
        case .planets: return URL(string: "https://swapi.dev/api/planets/")!
        case .species: return URL(string: "https://swapi.dev/api/species/")!
        }
    }
}
