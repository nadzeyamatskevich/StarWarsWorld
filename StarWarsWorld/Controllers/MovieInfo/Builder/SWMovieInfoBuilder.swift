//
//  SWMovieInfoBuilder.swift
//  StarWarsWorld
//
//  Created by Nadzeya Savitskaya on 2023-10-03.
//  Copyright © 2023 nadzeyamatskevich. All rights reserved.
//

import UIKit

class SWMovieInfoBuilder: MovieInfoSceneBuilder {
    func build(with movie: SWMovie) -> UIViewController {
        let presenter = SWMoviesPresenter()
        let apiGateway = SWSwapiManager()
        let apiService = SWSwapiService(apiGateway: apiGateway)
        let interactor = SWMoviesInteractor(apiService: apiService, presenter: presenter)

        guard let controller = UIStoryboard(storyboard: .movieInfo).instantiateInitialViewController() as? SWMoviesViewController
        else { return UIViewController() }

        controller.setup(interactor: interactor)
        presenter.setView(view: controller)
        return controller
    }
}
