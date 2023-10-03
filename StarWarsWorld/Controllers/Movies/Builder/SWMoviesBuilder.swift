//
//  SWMoviesBuilder.swift
//  StarWarsWorld
//
//  Created by Nadzeya Savitskaya on 2023-10-02.
//  Copyright © 2023 nadzeyamatskevich. All rights reserved.
//

import UIKit

class SWMoviesBuilder: MoviesSceneBuilder {
    func build() -> UIViewController {
        let presenter = SWMoviesPresenter()
        let apiGateway = SWSwapiManager()
        let apiService = SWSwapiService(apiGateway: apiGateway)
        let interactor = SWMoviesInteractor(apiService: apiService, presenter: presenter)

        guard let controller = UIStoryboard(storyboard: .movies).instantiateInitialViewController() as? SWMoviesViewController
        else { return UIViewController() }

        controller.setup(interactor: interactor)
        presenter.setView(view: controller)
        return controller
    }
}
