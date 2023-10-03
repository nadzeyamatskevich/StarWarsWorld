//
//  SWMovieInfoInterctor.swift
//  StarWarsWorld
//
//  Created by Nadzeya Savitskaya on 2023-10-03.
//  Copyright © 2023 nadzeyamatskevich. All rights reserved.
//

import Foundation

protocol SWMovieInfoLogic {
    func fetchCharacters()
}

class SWMovieInfoInteractor {
    let apiService: SWSwapiGateway
    let presenter: SWMovieInfoPresentationLogic

    init(apiService: SWSwapiGateway, presenter: SWMovieInfoPresentationLogic) {
        self.apiService = apiService
        self.presenter = presenter
    }

}

extension SWMovieInfoInteractor: SWMovieInfoLogic {

    func fetchCharacters() {
        apiService.getCharacters(pageURL: nil) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let success):
                    self.presenter.display(characters: success.results)
                case .failure(let failure):
                    self.presenter.displayEmptyList(with: failure as Error)
                }
            }
        }
    }

}
