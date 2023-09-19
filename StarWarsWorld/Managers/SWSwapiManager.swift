//
//  SWWSwapiService.swift
//  StarWarsWorld
//
//  Created by мак on 07.07.2018.
//  Copyright © 2018 мак. All rights reserved.
//

import Foundation
import Alamofire

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

//TODO: use dispach in completion
//TODO: check flow in alamofire
//TODO: return result (besides success and fail)
class SWSwapiManager {

    //TODO: rewrite with generics
    /*static func getData<T:Decodable>(for method: SWSwapiMethod, pageURL: URL? = nil, success: @escaping ([T]) -> Void, fail: @escaping (_ error: Error) -> Void) -> Void {

        var url: URL = method.url

        switch pageURL {
        case .none: url = method.url
        case .some(let u): url = u
        }

        AF.request(url, method: .get).responseDecodable(of: T.self) { response in
            switch response.result {
            case .success(let data):
                success(data.results)
            case .failure(let error):
                fail(error)
            }
        }
    }*/

    
    static func getMovies(success: @escaping ([SWMovie]) -> Void, fail: @escaping (_ error: Error) -> Void) -> Void {
        
        AF.request(SWSwapiMethod.films.url, method: .get).responseDecodable(of: SWMovieResponse.self) { response in
            switch response.result {
            case .success(let data):
                success(data.results)
            case .failure(let error):
                fail(error)
            }
        }
    }
    
    static func getCharacter(pageURL: URL? = nil, success: @escaping ([SWCharacter]) -> Void, fail: @escaping (_ error: Error) -> Void) -> Void {

        var charactersURL: URL = SWSwapiMethod.people.url
        
        switch pageURL {
        case .none: charactersURL = SWSwapiMethod.people.url
        case .some(let url): charactersURL = url
        }
        
        AF.request(charactersURL).responseDecodable(of: SWCharacterResponse.self) { response in
            switch response.result {
            case .success(let data):
                success(data.results)
            case .failure(let error):
                fail(error)
            }
        }
    }
    
    static func getPlanets(pageURL: URL? = nil, success: @escaping ([SWPlanet]) -> Void, fail: @escaping (_ error: Error) -> Void) -> Void {
        
        var planetsURL: URL = SWSwapiMethod.planets.url
        
        switch pageURL {
        case .none: planetsURL = SWSwapiMethod.planets.url
        case .some(let url): planetsURL = url
        }
        
        AF.request(planetsURL, method: .get).responseDecodable(of: SWPlanetResponse.self) { response in
            switch response.result {
            case .success(let data):
                success(data.results)
            case .failure(let error):
                fail(error)
            }
        }
    }

    static func getPlanet(pageURL: URL, success: @escaping (SWPlanet) -> Void, fail: @escaping (_ error: Error) -> Void) -> Void {

        AF.request(pageURL, method: .get).responseDecodable(of: SWPlanet.self) { response in
            switch response.result {
            case .success(let data):
                success(data)
            case .failure(let error):
                fail(error)
            }
        }
    }
    
    static func getSpecies(pageURL: URL? = nil, success: @escaping ([SWSpecies]) -> Void, fail: @escaping (_ error: Error) -> Void) -> Void  {
        
        var speciesURL: URL = SWSwapiMethod.species.url
        
        switch pageURL {
        case .none: speciesURL = SWSwapiMethod.species.url
        case .some(let url): speciesURL = url
        }
        
        AF.request(speciesURL, method: .get).responseDecodable(of: SWSpeciesResponse.self) { response in
            switch response.result {
            case .success(let data):
                success(data.results)
            case .failure(let error):
                fail(error)
            }
        }
    }

}
