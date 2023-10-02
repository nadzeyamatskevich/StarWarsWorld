//
//  SWMoviesInteractor.swift
//  StarWarsWorld
//
//  Created by Nadzeya Savitskaya on 2023-10-02.
//  Copyright © 2023 nadzeyamatskevich. All rights reserved.
//

import Foundation

protocol SWMoviesLogic {
    func fetchMovies()
}

class SWMoviesInteractor {
    let apiService: SWSwapiGateway
    let presenter: SWMoviesPresentationLogic

    init(apiService: SWSwapiGateway, presenter: SWMoviesPresentationLogic) {
        self.apiService = apiService
        self.presenter = presenter
    }

}

extension SWMoviesInteractor: SWMoviesLogic {
    
    func fetchMovies() {
        apiService.getMovies { result in
            switch result {
            case .success(let success):
                self.presenter.didFetchMovies(movies: success.results)
            case .failure(let failure):
                self.presenter.showError(error: failure as Error)
            }
        }
    }

}
