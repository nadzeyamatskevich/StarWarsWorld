//
//  SWPlanet.swift
//  StarWarsWorld
//
//  Created by мак on 08.07.2018.
//  Copyright © 2018 мак. All rights reserved.
//

import Foundation
import RealmSwift

class SWPlanet: Object {
    
    @objc dynamic var name = ""
    @objc dynamic var population = ""
    @objc dynamic var climate = ""
    @objc dynamic var diameter = ""
    @objc dynamic var terrain = ""
    @objc dynamic var url = ""
    
    override static func primaryKey() -> String? {
        return "url"
    }
}
