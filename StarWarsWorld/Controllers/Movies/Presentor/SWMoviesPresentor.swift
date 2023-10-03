//
//  SWMoviesPresentor.swift
//  StarWarsWorld
//
//  Created by Nadzeya Savitskaya on 2023-10-02.
//  Copyright © 2023 nadzeyamatskevich. All rights reserved.
//

import Foundation

protocol SWMoviesPresentationLogic {
    func displayMovies(movies: [SWMovie])
    func displayEmptyList(error: Error)
}

class SWMoviesPresenter {
    weak var view: SWMoviesDisplayLogic?

    func setView(view: SWMoviesDisplayLogic) {
        self.view = view
    }

}

extension SWMoviesPresenter: SWMoviesPresentationLogic {
    
    func displayMovies(movies: [SWMovie]) {
        view?.displayMovies(movies: movies)
    }
    
    func displayEmptyList(error: Error) {
        view?.displayEmptyList()
    }

}
