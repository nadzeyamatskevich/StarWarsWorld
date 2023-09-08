//
//  SWWSwapiService.swift
//  StarWarsWorld
//
//  Created by мак on 07.07.2018.
//  Copyright © 2018 мак. All rights reserved.
//

import Foundation
import Alamofire
import RealmSwift

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
    
    static func getCharacter(page: String, success: @escaping () -> Void, fail: @escaping (_ error: Error) -> Void) -> Void {

        let charactersURL: URL?
        
        if page == "" { charactersURL = Method.characters.url }
        else { charactersURL = URL(string: page) }
        
        AF.request(charactersURL!).responseDecodable(of: [SWCharacter].self) { response in

            switch response.result {
            case .success(let data):
                let realm = try! Realm()
                realm.add(data, update: .modified)
            case .failure(let error):
                print("ERROR characters: \(error)")
            }
            
        }
    }
    
    static func getPlanets(page: String, success: @escaping () -> Void, fail: @escaping (_ error:NSError) -> Void) -> Void {
        
        let moviesURL: URL?
        
        if page == "" { moviesURL = Method.planets.url }
        else { moviesURL = URL(string: page) }
        
        AF.request(moviesURL!, method: .get).responseDecodable(of: [SWPlanet].self) { response in
            switch response.result {
            case .success(let data):
                let realm = try! Realm()
                realm.add(data, update: .modified)
            case .failure(let error):
                print("ERROR planets: \(error)")
            }
        }
    }
    
    static func getSpecies(page: String, success: @escaping () -> Void, fail: @escaping (_ error:NSError) -> Void) -> Void  {
        
        let speciesURL: URL?
        
        if page == "" { speciesURL = Method.species.url }
        else { speciesURL = URL(string: page) }
        
        AF.request(speciesURL!, method: .get).responseDecodable(of: [SWSpecies].self) { response in
            switch response.result {
            case .success(let data):
                let realm = try! Realm()
                realm.add(data, update: .modified)
            case .failure(let error):
                print("ERROR species: \(error)")
            }
        }
    }
}
