//
//  SWPlanetInfoBuilder.swift
//  StarWarsWorld
//
//  Created by Nadzeya Savitskaya on 2023-10-04.
//  Copyright © 2023 nadzeyamatskevich. All rights reserved.
//

import UIKit

final class SWPlanetInfoBuilder {
    static func build(with planet: SWPlanet) -> UIViewController {
        let presenter = SWPlanetInfoPresentor()
        let interactor = SWPlanetInfoIneractor(presenter: presenter, planet: planet)

        guard let controller = UIStoryboard(storyboard: .planetInfo).instantiateInitialViewController() as? SWPlanetViewController
        else { return UIViewController() }

        controller.setup(interactor: interactor)
        presenter.setView(view: controller)
        return controller
    }
}
