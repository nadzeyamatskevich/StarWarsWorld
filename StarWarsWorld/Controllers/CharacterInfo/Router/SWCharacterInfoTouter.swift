//
//  SWCharacterInfoRouter.swift
//  StarWarsWorld
//
//  Created by Nadzeya Savitskaya on 2023-10-04.
//  Copyright © 2023 nadzeyamatskevich. All rights reserved.
//

import UIKit

protocol SWCharacterInfoRouterLogic {
    func showPlanet(for planet: SWPlanet)
}

class SWCharacterInfoRouter {

    weak var source: UIViewController?

    init(source: UIViewController) {
        self.source = source
    }

}

extension SWCharacterInfoRouter: SWCharacterInfoRouterLogic {

    func showPlanet(for planet: SWPlanet) {
        let scene = SWPlanetInfoBuilder.build(with: planet)
        source?.navigationController?.pushViewController(scene, animated: true)
    }

}
