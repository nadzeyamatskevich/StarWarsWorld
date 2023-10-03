//
//  SWMovieInfoRouter.swift
//  StarWarsWorld
//
//  Created by Nadzeya Savitskaya on 2023-10-03.
//  Copyright © 2023 nadzeyamatskevich. All rights reserved.
//

import UIKit

protocol SWMovieInfoRouterLogic {
    func showCharacterInfo(for character: SWCharacter)
}

class SWMovieInfoRouter {

    weak var source: UIViewController?

    init(source: UIViewController) {
        self.source = source
    }

}

extension SWMovieInfoRouter: SWMovieInfoRouterLogic {

    func showCharacterInfo(for character: SWCharacter) {
        let scene = SWCharacterInfoBuilder.build(with: character)
        source?.navigationController?.pushViewController(scene, animated: true)
    }

}
