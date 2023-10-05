//
//  SWCharactersInteractor.swift
//  StarWarsWorld
//
//  Created by Nadzeya Savitskaya on 2023-10-05.
//  Copyright © 2023 nadzeyamatskevich. All rights reserved.
//

import Foundation

protocol SWCharactersInteractorLogic {
    func fetchCharacters()
}

class SWCharactersInteractor {
    let apiService: SWSwapiGateway
    let presenter: SWCharactersPresentationLogic

    init(apiService: SWSwapiGateway, presenter: SWCharactersPresentationLogic) {
        self.apiService = apiService
        self.presenter = presenter
    }

}

extension SWCharactersInteractor: SWCharactersInteractorLogic {

    func fetchCharacters() {
        apiService.getCharacters(with: nil) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let success):
                    self.presenter.display(characters: success.results)
                case .failure(let failure):
                    self.presenter.displayEmptyList(error: failure as Error)
                }
            }
        }
    }

}
