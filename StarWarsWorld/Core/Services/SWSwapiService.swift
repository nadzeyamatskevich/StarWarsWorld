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
    func getCharacter(pageURL: URL?, completion: @escaping ((Result<SWCharacterResponse, AFError>) -> Void))
    func getPlanets(pageURL: URL?, completion: @escaping ((Result<SWPlanetResponse, AFError>) -> Void))
    func getPlanet(pageURL: URL, completion: @escaping ((Result<SWPlanet, AFError>) -> Void))
    func getSpecies(pageURL: URL?, completion: @escaping ((Result<SWSpeciesResponse, AFError>) -> Void))
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

    func getCharacter(pageURL: URL?, completion: @escaping ((Result<SWCharacterResponse, Alamofire.AFError>) -> Void)) {
        apiGateway.getCharacter(pageURL: pageURL) { result in
            completion(result)
        }
    }

    func getPlanets(pageURL: URL?, completion: @escaping ((Result<SWPlanetResponse, Alamofire.AFError>) -> Void)) {
        apiGateway.getPlanets(pageURL: pageURL) { result in
            completion(result)
        }
    }

    func getPlanet(pageURL: URL, completion: @escaping ((Result<SWPlanet, Alamofire.AFError>) -> Void)) {
        apiGateway.getPlanet(pageURL: pageURL) { result in
            completion(result)
        }
    }

    func getSpecies(pageURL: URL?, completion: @escaping ((Result<SWSpeciesResponse, Alamofire.AFError>) -> Void)) {
        apiGateway.getSpecies(pageURL: pageURL) { result in
            completion(result)
        }
    }
}
