//
//  SWTabbarViewController.swift
//  StarWarsWorld
//
//  Created by Nadzeya Savitskaya on 2023-10-02.
//  Copyright © 2023 nadzeyamatskevich. All rights reserved.
//

import UIKit


class SWTabbarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        generateTabBar()
        setTabBarAppearance()
    }

    private func generateTabBar() {
        viewControllers = [
            generateVC(
                viewController: SWMoviesBuilder.build(),
                title: "Movies",
                image: UIImage(named: "iconMovie")
            ),
            generateVC(
                viewController: SWMoviesBuilder.build(),
                title: "Characters",
                image: UIImage(named: "iconCharacters")
            )
        ]
    }

    private func generateVC(viewController: UIViewController, title: String, image: UIImage?) -> UIViewController {
        viewController.tabBarItem.title = title
        viewController.tabBarItem.image = image
        let nvc = UINavigationController(rootViewController: viewController)
        return nvc
    }

    private func setTabBarAppearance() {
        let positionOnX: CGFloat = 10
        let positionOnY: CGFloat = 14
        let width = tabBar.bounds.width - positionOnX * 2
        let height = tabBar.bounds.height + positionOnY * 2

        let roundLayer = CAShapeLayer()

        let bezierPath = UIBezierPath(
            roundedRect: CGRect(
                x: positionOnX,
                y: tabBar.bounds.minY - positionOnY,
                width: width,
                height: height
            ),
            cornerRadius: height / 2
        )

        roundLayer.path = bezierPath.cgPath

        tabBar.layer.insertSublayer(roundLayer, at: 0)

        tabBar.itemWidth = width / 5
        tabBar.itemPositioning = .centered

        roundLayer.fillColor = UIColor.white.cgColor

        tabBar.tintColor = .green
        tabBar.unselectedItemTintColor = .gray
    }
}
