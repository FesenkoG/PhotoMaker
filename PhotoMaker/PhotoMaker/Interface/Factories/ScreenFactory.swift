//
//  ScreenFactory.swift
//  PhotoMaker
//
//  Created by Georgy Fesenko on 4/10/21.
//

import UIKit

//sourcery: AutoMockable
protocol ScreenFactoryProtocol {
    func makeHomeScreen(
        navigationController: UINavigationController
    ) -> UIViewController
    func makePhotosListScreen(flow: HomeFlow) -> UIViewController
    func makeSavePhotoAlert(
        completion: @escaping (String) -> Void
    ) -> UIViewController
    func makePhotoFullScreen(
        image: UIImage
    ) -> UIViewController
}

final class ScreenFactory: ScreenFactoryProtocol {
    func makeHomeScreen(
        navigationController: UINavigationController
    ) -> UIViewController {
        navigationController.viewControllers = [
            HomeViewController(
                viewModel: HomeViewModel(
                    flow: HomeFlow(
                        navigationController: navigationController
                    )
                )
            )
        ]

        return navigationController
    }

    func makePhotosListScreen(flow: HomeFlow) -> UIViewController {
        return PhotosListViewController(
            viewModel: .init(homeFlow: flow)
        )
    }

    func makeSavePhotoAlert(
        completion: @escaping (String) -> Void
    ) -> UIViewController {
        let alert = UIAlertController(
            title: "Save image",
            message: "Please, provide a name for an image",
            preferredStyle: .alert
        )

        alert.addTextField { (textField) in
            textField.text = ""
        }
        alert.addAction(
            UIAlertAction(
                title: "Save",
                style: .default,
                handler: { [weak alert] _ in
                    guard let imageName = alert?.textFields?.first?.text else { return }
                    completion(imageName)
                }
            )
        )

        return alert
    }

    func makePhotoFullScreen(
        image: UIImage
    ) -> UIViewController {
        return PhotoFullScreenViewController(image: image)
    }
}
