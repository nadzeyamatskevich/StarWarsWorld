//
//  SWCharacterInfoPresentor.swift
//  StarWarsWorld
//
//  Created by Nadzeya Savitskaya on 2023-10-04.
//  Copyright © 2023 nadzeyamatskevich. All rights reserved.
//

import Foundation

protocol SWCharacterInfoPresentationLogic {
    func displayCharacterInfo(character: SWCharacter)
    func displayProvided(species: String)
    func displayDefaultSpecies(with error: Error?)
    func displayProvided(homeworld: SWPlanet)
    func displayDefaultHomeworld(with error: Error?)
}

class SWCharacterInfoPresentor {
    weak var view: SWCharacterInfoDisplayLogic?

    func setView(view: SWCharacterInfoDisplayLogic) {
        self.view = view
    }

}

extension SWCharacterInfoPresentor: SWCharacterInfoPresentationLogic {

    func displayProvided(species: String) {
        view?.displayProvided(species: species)
    }
    
    func displayDefaultSpecies(with error: Error?) {
        view?.displayDefaultSpecies(with: error)
    }

    func displayProvided(homeworld: SWPlanet) {
        view?.displayProvided(homeworld: homeworld)
    }

    func displayDefaultHomeworld(with error: Error?) {
        view?.displayDefaultHomeworld(with: error)
    }

    func displayCharacterInfo(character: SWCharacter) {
        view?.displayCharacterInfo(character: character)
    }

}
