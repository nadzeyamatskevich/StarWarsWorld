//
//  SWWSwapiService.swift
//  StarWarsWorld
//
//  Created by мак on 07.07.2018.
//  Copyright © 2018 мак. All rights reserved.
//

import Foundation
import Alamofire

protocol ApiGateway: SWSwapiGateway {
}

class SWSwapiManager: ApiGateway {

    func getMovies(completion: @escaping ((Result<SWMovieResponse, AFError>) -> Void)) {

        AF.request(SWSwapiMethod.films.url, method: .get).responseDecodable(of: SWMovieResponse.self) { response in
            completion(response.result)
        }
    }
    
    func getCharacters(pageURL: URL?, completion: @escaping ((Result<SWCharacterResponse, AFError>) -> Void)) {

        var charactersURL: URL = SWSwapiMethod.people.url
        
        switch pageURL {
        case .none: charactersURL = SWSwapiMethod.people.url
        case .some(let url): charactersURL = url
        }
        
        AF.request(charactersURL).responseDecodable(of: SWCharacterResponse.self) { response in
            completion(response.result)
        }
    }
    
    func getPlanets(pageURL: URL?, completion: @escaping ((Result<SWPlanetResponse, AFError>) -> Void)) {

        var planetsURL: URL = SWSwapiMethod.planets.url
        
        switch pageURL {
        case .none: planetsURL = SWSwapiMethod.planets.url
        case .some(let url): planetsURL = url
        }
        
        AF.request(planetsURL, method: .get).responseDecodable(of: SWPlanetResponse.self) { response in
            completion(response.result)
        }
    }

    func getPlanet(pageURL: URL, completion: @escaping ((Result<SWPlanet, AFError>) -> Void)) {

        AF.request(pageURL, method: .get).responseDecodable(of: SWPlanet.self) { response in
            completion(response.result)
        }
    }
    
    func getSpecies(pageURL: URL?, completion: @escaping ((Result<SWSpeciesResponse, AFError>) -> Void)) {

        var speciesURL: URL = SWSwapiMethod.species.url
        
        switch pageURL {
        case .none: speciesURL = SWSwapiMethod.species.url
        case .some(let url): speciesURL = url
        }
        
        AF.request(speciesURL, method: .get).responseDecodable(of: SWSpeciesResponse.self) { response in
            completion(response.result)
        }
    }

}
