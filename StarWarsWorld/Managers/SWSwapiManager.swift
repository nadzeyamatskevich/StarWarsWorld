//
//  SWWSwapiService.swift
//  StarWarsWorld
//
//  Created by мак on 07.07.2018.
//  Copyright © 2018 мак. All rights reserved.
//

import Foundation
import Alamofire

class SWSwapiManager {
    
    enum Method {
        case characters
        case movies
        case planets
        case species

        var url: URL {
            switch self {
            case .characters: return URL(string: "https://swapi.dev/api/people/")!
            case .movies: return URL(string: "https://swapi.dev/api/films/")!
            case .planets: return URL(string: "https://swapi.dev/api/planets/")!
            case .species: return URL(string: "https://swapi.dev/api/species/")!
            }
        }
    }
    
    static func getMovies(success: @escaping ([SWMovie]) -> Void, fail: @escaping (_ error: Error) -> Void) -> Void {
        
        AF.request(Method.movies.url, method: .get).responseDecodable(of: SWMovieResponse.self) { response in
            switch response.result {
            case .success(let data):
                success(data.results)
            case .failure(let error):
                fail(error)
            }
        }
    }
    
    static func getCharacter(pageURL: URL? = nil, success: @escaping ([SWCharacter]) -> Void, fail: @escaping (_ error: Error) -> Void) -> Void {

        let charactersURL: URL?
        
        switch pageURL {
        case .none: charactersURL = Method.characters.url
        case .some(let url): charactersURL = url
        }
        
        AF.request(charactersURL!).responseDecodable(of: SWCharacterResponse.self) { response in
            switch response.result {
            case .success(let data):
                success(data.results)
            case .failure(let error):
                fail(error)
            }
        }
    }
    
    static func getPlanets(pageURL: URL? = nil, success: @escaping ([SWPlanet]) -> Void, fail: @escaping (_ error: Error) -> Void) -> Void {
        
        let planetsURL: URL?
        
        switch pageURL {
        case .none: planetsURL = Method.planets.url
        case .some(let url): planetsURL = url
        }
        
        AF.request(planetsURL!, method: .get).responseDecodable(of: SWPlanetResponse.self) { response in
            switch response.result {
            case .success(let data):
                success(data.results)
            case .failure(let error):
                fail(error)
            }
        }
    }
    
    static func getSpecies(pageURL: URL? = nil, success: @escaping ([SWSpecies]) -> Void, fail: @escaping (_ error: Error) -> Void) -> Void  {
        
        let speciesURL: URL?
        
        switch pageURL {
        case .none: speciesURL = Method.species.url
        case .some(let url): speciesURL = url
        }
        
        AF.request(speciesURL!, method: .get).responseDecodable(of: SWSpeciesResponse.self) { response in
            switch response.result {
            case .success(let data):
                success(data.results)
            case .failure(let error):
                fail(error)
            }
        }
    }
}
