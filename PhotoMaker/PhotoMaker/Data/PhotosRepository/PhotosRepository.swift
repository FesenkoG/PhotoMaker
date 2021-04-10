//
//  PhotosRepository.swift
//  PhotoMaker
//
//  Created by Georgy Fesenko on 4/10/21.
//

import Foundation

final class PhotosRepository {
    private let storageService: PhotosStorageService

    init(storageService: PhotosStorageService = .init()) {
        self.storageService = storageService
    }

    func storeImage(image: Image) {
        storageService.storeImage(image: .init(from: image))
    }

    func getImages() -> [Image] {
        storageService.getStoredImages().map { $0.toDomain() }
    }
}
