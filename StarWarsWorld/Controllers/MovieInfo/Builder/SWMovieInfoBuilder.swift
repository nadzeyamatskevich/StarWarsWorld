//
//  SWMovieInfoBuilder.swift
//  StarWarsWorld
//
//  Created by Nadzeya Savitskaya on 2023-10-03.
//  Copyright © 2023 nadzeyamatskevich. All rights reserved.
//

import UIKit

final class SWMovieInfoBuilder {
    static func build(with movie: SWMovie) -> UIViewController {
        let presenter = SWMovieInfoPresentor()
        let apiGateway = SWSwapiManager()
        let apiService = SWSwapiService(apiGateway: apiGateway)
        let interactor = SWMovieInfoInteractor(apiService: apiService, presenter: presenter)

        guard let controller = UIStoryboard(storyboard: .movieInfo).instantiateInitialViewController() as? SWMovieInfoViewController
        else { return UIViewController() }

        controller.setup(interactor: interactor, movie: movie)
        presenter.setView(view: controller)
        return controller
    }
}
