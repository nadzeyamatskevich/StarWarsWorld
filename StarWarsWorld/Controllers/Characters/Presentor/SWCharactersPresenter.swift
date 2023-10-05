//
//  SWCharactersPresenter.swift
//  StarWarsWorld
//
//  Created by Nadzeya Savitskaya on 2023-10-05.
//  Copyright © 2023 nadzeyamatskevich. All rights reserved.
//

import Foundation

protocol SWCharactersPresentationLogic {
    func display(characters: [SWCharacter])
    func displayEmptyList(error: Error)
}

class SWCharactersPresenter {
    weak var view: SWCharactersDisplayLogic?

    func setView(view: SWCharactersDisplayLogic) {
        self.view = view
    }

}

extension SWCharactersPresenter: SWCharactersPresentationLogic {

    func display(characters: [SWCharacter]) {
        view?.display(characters: characters)
    }

    func displayEmptyList(error: Error) {
        view?.displayEmptyList()
    }

}
