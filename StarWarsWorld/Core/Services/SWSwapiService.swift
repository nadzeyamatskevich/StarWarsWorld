//
//  SWSwapiService.swift
//  StarWarsWorld
//
//  Created by Nadzeya Savitskaya on 2023-10-02.
//  Copyright © 2023 nadzeyamatskevich. All rights reserved.
//

import Foundation
import Alamofire

protocol SWSwapiGateway {
    func getMovies(completion: @escaping ((Result<SWMovieResponse, AFError>) -> Void))
    func getCharacters(with pageURL: URL?, completion: @escaping ((Result<SWCharacterResponse, AFError>) -> Void))
    func getPlanets(with pageURL: URL?, completion: @escaping ((Result<SWPlanetResponse, AFError>) -> Void))
    func getPlanet(with url: URL, completion: @escaping ((Result<SWPlanet, AFError>) -> Void))
    func getSpecies(with pageURL: URL?, completion: @escaping ((Result<SWSpeciesResponse, AFError>) -> Void))
    func getSpeciesInfo(with url: URL, completion: @escaping ((Result<SWSpecies, AFError>) -> Void))
}

class SWSwapiService: SWSwapiGateway {

    let apiGateway: ApiGateway

    init(apiGateway: ApiGateway) {
        self.apiGateway =  apiGateway
    }

    func getMovies(completion: @escaping ((Result<SWMovieResponse, Alamofire.AFError>) -> Void)) {
        apiGateway.getMovies { result in
            completion(result)
        }
    }

    func getCharacters(with pageURL: URL?, completion: @escaping ((Result<SWCharacterResponse, Alamofire.AFError>) -> Void)) {
        apiGateway.getCharacters(with: pageURL) { result in
            completion(result)
        }
    }

    func getPlanets(with pageURL: URL?, completion: @escaping ((Result<SWPlanetResponse, Alamofire.AFError>) -> Void)) {
        apiGateway.getPlanets(with: pageURL) { result in
            completion(result)
        }
    }

    func getPlanet(with url: URL, completion: @escaping ((Result<SWPlanet, Alamofire.AFError>) -> Void)) {
        apiGateway.getPlanet(with: url) { result in
            completion(result)
        }
    }

    func getSpecies(with pageURL: URL?, completion: @escaping ((Result<SWSpeciesResponse, Alamofire.AFError>) -> Void)) {
        apiGateway.getSpecies(with: pageURL) { result in
            completion(result)
        }
    }

    func getSpeciesInfo(with url: URL, completion: @escaping ((Result<SWSpecies, Alamofire.AFError>) -> Void)) {
        apiGateway.getSpeciesInfo(with: url) { result in
            completion(result)
        }
    }

}
