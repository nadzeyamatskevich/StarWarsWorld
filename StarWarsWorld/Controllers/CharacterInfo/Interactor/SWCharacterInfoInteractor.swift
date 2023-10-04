//
//  SWCharacterInfoInteractor.swift
//  StarWarsWorld
//
//  Created by Nadzeya Savitskaya on 2023-10-04.
//  Copyright © 2023 nadzeyamatskevich. All rights reserved.
//

import Foundation

protocol SWCharacterInfoInteractorLogic {
    func fetchSpeciesIfProvided(for character: SWCharacter)
    func fetchHomeworldIfProvided(for character: SWCharacter)
    func setUpCharacter()
}

class SWCharacterInfoInteractor {
    let apiService: SWSwapiGateway
    let presenter: SWCharacterInfoPresentationLogic
    let character: SWCharacter

    init(apiService: SWSwapiGateway, presenter: SWCharacterInfoPresentationLogic, character: SWCharacter) {
        self.apiService = apiService
        self.presenter = presenter
        self.character = character
    }

}

extension SWCharacterInfoInteractor: SWCharacterInfoInteractorLogic {

    func setUpCharacter() {
        presenter.displayCharacterInfo(character: character)
    }

    func fetchSpeciesIfProvided(for character: SWCharacter) {
        guard let urlString = character.species.first, let url = URL(string: urlString) else {
            return presenter.displayDefaultSpecies(with: nil)
        }
        
        apiService.getSpeciesInfo(with: url) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let success):
                    self.presenter.displayProvided(species: success.name)
                case .failure(let failure):
                    self.presenter.displayDefaultSpecies(with: failure)
                }
            }
        }
    }

    func fetchHomeworldIfProvided(for character: SWCharacter) {
        guard let url = URL(string: character.homeworld) else {
            return presenter.displayDefaultHomeworld(with: nil)
        }

        apiService.getPlanet(with: url) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let success):
                    self.presenter.displayProvided(homeworld: success)
                case .failure(let failure):
                    self.presenter.displayDefaultHomeworld(with: failure)
                }
            }
        }
    }

}
