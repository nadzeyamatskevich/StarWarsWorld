//
//  SWCharacterInfoBuilder.swift
//  StarWarsWorld
//
//  Created by Nadzeya Savitskaya on 2023-10-03.
//  Copyright © 2023 nadzeyamatskevich. All rights reserved.
//

import UIKit

final class SWCharacterInfoBuilder {
    static func build(with character: SWCharacter) -> UIViewController {
        let presenter = SWMovieInfoPresentor()
        let apiGateway = SWSwapiManager()
        let apiService = SWSwapiService(apiGateway: apiGateway)
        let interactor = SWMovieInfoInteractor(apiService: apiService, presenter: presenter)

        guard let controller = UIStoryboard(storyboard: .characterInfo).instantiateInitialViewController() as? SWCharacterInfoViewController
        else { return UIViewController() }

        //controller.setup(interactor: interactor, character: character)
        //presenter.setView(view: controller)
        return controller
    }
}
