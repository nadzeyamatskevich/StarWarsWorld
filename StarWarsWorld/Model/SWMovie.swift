//
//  SWMovieModel.swift
//  StarWarsWorld
//
//  Created by мак on 07.07.2018.
//  Copyright © 2018 мак. All rights reserved.
//

import Foundation
import RealmSwift

class SWMovie: Object {
    
    @objc dynamic var title = ""
    @objc dynamic var episodeID = 0
    @objc dynamic var releaseDate = ""
    @objc dynamic var director = ""
    @objc dynamic var crawl = ""
    @objc dynamic var url = ""
    var characters = List<String>()
    
    override static func primaryKey() -> String? {
        return "url"
    }
}
