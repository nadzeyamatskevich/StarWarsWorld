//
//  SWMovieInfoInterctor.swift
//  StarWarsWorld
//
//  Created by Nadzeya Savitskaya on 2023-10-03.
//  Copyright © 2023 nadzeyamatskevich. All rights reserved.
//

import Foundation

protocol SWMovieInfoInteractorLogic {
    func setUpMovieInfo()
    func fetchCharacters()
}

class SWMovieInfoInteractor {
    private let apiService: SWSwapiGateway
    private let presenter: SWMovieInfoPresentationLogic
    private let movie: SWMovie

    init(apiService: SWSwapiGateway, presenter: SWMovieInfoPresentationLogic, movie: SWMovie) {
        self.apiService = apiService
        self.presenter = presenter
        self.movie = movie
    }

}

extension SWMovieInfoInteractor: SWMovieInfoInteractorLogic {
    
    func setUpMovieInfo() {
        presenter.displayMovieInfo(with: movie)
    }
    
    func fetchCharacters() {
        apiService.getCharacters(with: nil) { result in
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
