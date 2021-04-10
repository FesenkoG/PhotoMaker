//
//  HomeFlow.swift
//  PhotoMaker
//
//  Created by Georgy Fesenko on 4/10/21.
//

import UIKit
import AVFoundation
import Photos

final class HomeFlow {
    private let navigationController: UINavigationController
    private let imagePickerDelegate: ImagePickerDelegate
    private let screenFactory: ScreenFactory
    private let photosRepository: PhotosRepository
    private let permissionsManager: PermissionsManager

    init(
        navigationController: UINavigationController,
        screenFactory: ScreenFactory = ScreenFactory(),
        photosRepository: PhotosRepository = PhotosRepository(),
        imagePickerDelegate: ImagePickerDelegate = .init(),
        permissionsManager: PermissionsManager = .init()
    ) {
        self.navigationController = navigationController
        self.screenFactory = screenFactory
        self.photosRepository = photosRepository
        self.imagePickerDelegate = imagePickerDelegate
        self.permissionsManager = permissionsManager
    }
    
    func presentCamera() {
        guard UIImagePickerController.isSourceTypeAvailable(.camera) else {
            return
        }

        permissionsManager.verifyCameraPermissions { [weak self] in
            guard let self = self else { return }
            let controller = UIImagePickerController()
            controller.sourceType = .camera
            controller.allowsEditing = false
            controller.delegate = self.imagePickerDelegate
            self.imagePickerDelegate.completion = { [weak self] kek, shpek in
                self?.presentPhotoPreview(image: kek, creationDate: shpek)
            }
            self.navigationController.present(controller, animated: true)
        }
    }

    func presentPhotoList() {
        navigationController.pushViewController(
            screenFactory.makePhotosListScreen(flow: self),
            animated: true
        )
    }

    func presentPhotoPreview(image: UIImage, creationDate: Date) {
        let viewControllerToPresentFrom = navigationController.presentedViewController ?? navigationController

        viewControllerToPresentFrom.present(
            screenFactory.makeSavePhotoAlert { [weak self] photoName in
                self?.storeImage(
                    image: .init(image: image, name: photoName, creationDate: creationDate)
                )
            },
            animated: true
        )
    }

    private func storeImage(image: Image) {
        photosRepository.storeImage(image: image)
        navigationController.dismiss(animated: true)
    }

    func presentPhotoView(image: UIImage) {
        navigationController.pushViewController(
            PhotoFullScreenViewController(image: image),
            animated: true
        )
    }
}

final class ImagePickerDelegate: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    var completion: (UIImage, Date) -> Void = { _, _ in }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else { return }
        completion(
            image,
            (info[UIImagePickerController.InfoKey.phAsset] as? PHAsset)?.creationDate ?? Date()
        )
    }
}
