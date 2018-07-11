//
//  SWCharacterModel.swift
//  StarWarsWorld
//
//  Created by мак on 07.07.2018.
//  Copyright © 2018 мак. All rights reserved.
//

import Foundation
import RealmSwift

class SWCharacter: Object {
    
    @objc dynamic var name = ""
    @objc dynamic var gender = ""
    @objc dynamic var birthDate = ""
    @objc dynamic var homeworld = ""
    @objc dynamic var url = ""
    var species = List<String>()
    var films = List<String>()
    
    override static func primaryKey() -> String? {
        return "name"
    }
}
