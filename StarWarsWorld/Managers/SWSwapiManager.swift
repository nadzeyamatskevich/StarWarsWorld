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
    
    enum Method: String {
        case allCharacters = "https://swapi.co/api/people/"
        case allMovies = "https://swapi.co/api/films/"
        case allPlanets = "https://swapi.co/api/planets/"
        case allSpecies = "https://swapi.co/api/species/"
    }
    
    static func getMovies( success:@escaping () -> Void, fail:@escaping (_ error:NSError)->Void)->Void {
        
        let moviesURL = URL(string: Method.allMovies.rawValue)
        
        Alamofire.request(moviesURL!, method: .get).responseJSON { response in
            switch response.result {
            case .success(let data):
                let json = data as? NSDictionary
               
                if let movieArray = json!["results"] as? [NSDictionary] {
                    for movie in movieArray {
                        let realm = try! Realm()
                        try! realm.write({
                            
                            let record = SWMovie()
                            record.title = movie["title"] as! String
                            record.episodeID = movie["episode_id"] as! Int
                            record.releaseDate = movie["release_date"] as! String
                            record.director = movie["director"] as! String
                            record.crawl = movie["opening_crawl"] as! String
                            record.url = movie["url"] as! String
                            
                            for char in movie["characters"] as! [String]{
                                record.characters.append(char)
                            }
                            
                            realm.add(record, update: true)
                        })
                    }
                    success()
                }
            case .failure(let error):
                print("Handlem \(error)")
            }
        }
    }
    
    static func getCharacter(page: String, success:@escaping () -> Void, fail:@escaping (_ error:NSError)->Void)->Void {
        
        let charactersURL: URL?
        
        if page == "" { charactersURL = URL(string: Method.allCharacters.rawValue) }
        else { charactersURL = URL(string: page) }
        
        Alamofire.request(charactersURL!).responseJSON { response in
         
            switch response.result {
                case .success(let data):
                    let json = data as? NSDictionary
                    
                    if let nextPageURL = json!["next"] as? String {
                        self.getCharacter(page: nextPageURL, success: {
                        }, fail:  { error in
                            print("ERROR: ", error)
                            })
                    }
                    
                    if let charArray = json!["results"] as? [NSDictionary] {
                        for char in charArray {
                            let realm = try! Realm()
                            try! realm.write({
                            
                                let record = SWCharacter()
                                record.birthDate = char["birth_year"] as! String
                                record.url = char["url"] as! String
                                record.name = char["name"] as! String
                                record.homeworld = char["homeworld"] as! String
                                record.gender = char["gender"] as! String
                                
                                
                                for char in char["films"] as! [String]{
                                    record.films.append(char)
                                }
                                for char in char["species"] as! [String]{
                                    record.species.append(char)
                                }
                                
                                realm.add(record, update: true)
                            })
                        }
                        
                        success()
                    }
            case .failure(let error):
                print(error)
            }
            
        }
    }
    
    static func getPlanets (page: String, success:@escaping () -> Void, fail:@escaping (_ error:NSError)->Void)->Void {
        
        let moviesURL: URL?
        
        if page == "" { moviesURL = URL(string: Method.allPlanets.rawValue) }
        else { moviesURL = URL(string: page) }
        
        Alamofire.request(moviesURL!, method: .get).responseJSON { response in
            switch response.result {
            case .success(let data):
                let json = data as? NSDictionary
                
                if let nextPageURL = json!["next"] as? String {
                    self.getPlanets(page: nextPageURL, success: {
                    }, fail:  { error in
                        print("ERROR: ", error)
                    })
                }
                
                if let planetArray = json!["results"] as? [NSDictionary] {
                    for planet in planetArray {
                        let realm = try! Realm()
                        try! realm.write({
                            
                            let record = SWPlanet()
                            record.name = planet["name"] as! String
                            record.population = planet["population"] as! String
                            record.climate = planet["climate"] as! String
                            record.diameter = planet["diameter"] as! String
                            record.terrain = planet["terrain"] as! String
                            record.url = planet["url"] as! String
                            
                            realm.add(record, update: true)
                            
                            print(record)
                        })
                    }
                    success()
                }
            case .failure(let error):
                print("Handlem \(error)")
            }
        }
    }
    
    static func getSpecies (page: String, success:@escaping () -> Void, fail:@escaping (_ error:NSError)->Void)->Void  {
        
        let speciesURL: URL?
        
        if page == "" { speciesURL = URL(string: Method.allSpecies.rawValue) }
        else { speciesURL = URL(string: page) }
        
        Alamofire.request(speciesURL!, method: .get).responseJSON { response in
            switch response.result {
            case .success(let data):
                let json = data as? NSDictionary
                
                if let nextPageURL = json!["next"] as? String {
                    self.getSpecies(page: nextPageURL, success: {
                    }, fail:  { error in
                        print("ERROR: ", error)
                    })
                }
                
                if let spaciesArray = json!["results"] as? [NSDictionary] {
                    for spacies in spaciesArray {
                        let realm = try! Realm()
                        try! realm.write({
                            
                            let record = SWSpecies()
                            record.name = spacies["name"] as! String
                            record.url = spacies["url"] as! String
                            
                            realm.add(record, update: true)
                            
                            print(record)
                        })
                    }
                    success()
                }
            case .failure(let error):
                print("Handlem \(error)")
            }
        }
    }
}
