//
//  PhotosListViewModel.swift
//  PhotoMaker
//
//  Created by Georgy Fesenko on 4/10/21.
//

import Foundation

final class PhotosListViewModel {
    private let photosRepository: PhotosRepository
    private let homeFlow: HomeFlow

    private(set) lazy var images: [Image] = {
        photosRepository.getImages()
    }()

    init(
        homeFlow: HomeFlow,
        photosRepository: PhotosRepository = PhotosRepository()
    ) {
        self.homeFlow = homeFlow
        self.photosRepository = photosRepository
    }
}

extension PhotosListViewModel {
    func modelFor(indexPath: IndexPath) -> Image {
        images[indexPath.row]
    }

    func numberOfRows() -> Int {
        images.count
    }

    func didSelect(indexPath: IndexPath) {
        homeFlow.presentPhotoView(image: images[indexPath.row].image)
    }
}
