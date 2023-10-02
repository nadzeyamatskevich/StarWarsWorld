//
//  SWMoviesPresentor.swift
//  StarWarsWorld
//
//  Created by Nadzeya Savitskaya on 2023-10-02.
//  Copyright © 2023 nadzeyamatskevich. All rights reserved.
//

import Foundation

protocol SWMoviesPresentationLogic {
    func didFetchMovies(movies: [SWMovie])
    func showError(error: Error)
}

class SWMoviesPresenter {
    weak var view: SWMoviesDisplayLogic?

    func setView(view: SWMoviesDisplayLogic) {
        self.view = view
    }

}

extension SWMoviesPresenter: SWMoviesPresentationLogic {
    
    func didFetchMovies(movies: [SWMovie]) {
        view?.displayMovies(movies: movies)
    }
    
    func showError(error: Error) {
        view?.displayEmptyList()
    }

}
