//
//  SWMovieInfoPresentor.swift
//  StarWarsWorld
//
//  Created by Nadzeya Savitskaya on 2023-10-03.
//  Copyright © 2023 nadzeyamatskevich. All rights reserved.
//

import Foundation

protocol SWMovieInfoPresentationLogic {
    func display(characters: [SWCharacter])
    func displayEmptyList(with error: Error)
}

class SWMovieInfoPresentor {
    weak var view: SWMovieInfoDisplayLogic?

    func setView(view: SWMovieInfoDisplayLogic) {
        self.view = view
    }

}

extension SWMovieInfoPresentor: SWMovieInfoPresentationLogic {

    func display(characters: [SWCharacter]) {
        view?.display(characters: characters)
    }

    func displayEmptyList(with error: Error) {
        view?.displayEmptyList(with: error)
    }

}
