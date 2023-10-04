//
//  SWPlanetInfoIneractor.swift
//  StarWarsWorld
//
//  Created by Nadzeya Savitskaya on 2023-10-04.
//  Copyright © 2023 nadzeyamatskevich. All rights reserved.
//

import Foundation

protocol SWPlanetInfoIneractorLogic {
    func showPlanetInfo()
}

class SWPlanetInfoIneractor {
    private let presenter: SWPlanetInfoPresentationLogic
    private let planet: SWPlanet

    init(presenter: SWPlanetInfoPresentationLogic, planet: SWPlanet) {
        self.presenter = presenter
        self.planet = planet
    }

}

extension SWPlanetInfoIneractor: SWPlanetInfoIneractorLogic {
    
    func showPlanetInfo() {
        presenter.displayPlanetInfo(with: planet)
    }

}
