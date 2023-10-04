//
//  SWPlanetInfoPresentor.swift
//  StarWarsWorld
//
//  Created by Nadzeya Savitskaya on 2023-10-04.
//  Copyright © 2023 nadzeyamatskevich. All rights reserved.
//

import Foundation

protocol SWPlanetInfoPresentationLogic {
    func displayPlanetInfo(with planet: SWPlanet)
}

class SWPlanetInfoPresentor {
    weak var view: SWPlanetInfoDisplayLogic?

    func setView(view: SWPlanetInfoDisplayLogic) {
        self.view = view
    }

}

extension SWPlanetInfoPresentor: SWPlanetInfoPresentationLogic {
    func displayPlanetInfo(with planet: SWPlanet) {
        view?.displayPlanetInfo(with: planet)
    }

}
