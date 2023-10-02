//
//  StoryboardEnum.swift
//  StarWarsWorld
//
//  Created by Nadzeya Savitskaya on 2023-10-02.
//  Copyright © 2023 nadzeyamatskevich. All rights reserved.
//

import Foundation

enum Storyboard: String {

    // - Movie
    case movies = "SWMovies"
    case movieInfo = "SWMovieInfo"

    // - Character
    case characters = "SWCharacters"
    case characterInfo = "SWCharacterInfo"

    // - Planet
    case planetInfo = "SWPlanetInfo"

    var filename: String {
        return rawValue
    }

}
