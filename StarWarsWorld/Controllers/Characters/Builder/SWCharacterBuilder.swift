//
//  SWCharacterBuilder.swift
//  StarWarsWorld
//
//  Created by Nadzeya Savitskaya on 2023-10-05.
//  Copyright © 2023 nadzeyamatskevich. All rights reserved.
//

import UIKit

final class SWCharactersBuilder {
    static func build() -> UIViewController {
        let presenter = SWCharactersPresenter()
        let apiGateway = SWSwapiManager()
        let apiService = SWSwapiService(apiGateway: apiGateway)
        let interactor = SWCharactersInteractor(apiService: apiService, presenter: presenter)

        guard let controller = UIStoryboard(storyboard: .characters).instantiateInitialViewController() as? SWCharactersViewController
        else { return UIViewController() }

        controller.setup(interactor: interactor)
        presenter.setView(view: controller)
        return controller
    }
}
