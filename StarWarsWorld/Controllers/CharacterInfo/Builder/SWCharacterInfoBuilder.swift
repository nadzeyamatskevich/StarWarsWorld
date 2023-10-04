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
        let presenter = SWCharacterInfoPresentor()
        let apiGateway = SWSwapiManager()
        let apiService = SWSwapiService(apiGateway: apiGateway)
        let interactor = SWCharacterInfoInteractor(apiService: apiService, presenter: presenter, character: character)

        guard let controller = UIStoryboard(storyboard: .characterInfo).instantiateInitialViewController() as? SWCharacterInfoViewController
        else { return UIViewController() }

        controller.setup(interactor: interactor)
        presenter.setView(view: controller)
        return controller
    }
}
