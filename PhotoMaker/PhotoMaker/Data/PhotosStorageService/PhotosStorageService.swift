//
//  PhotosStorageService.swift
//  PhotoMaker
//
//  Created by Georgy Fesenko on 4/10/21.
//

import UIKit

final class PhotosStorageService {
    private let storageService: StorageService

    init() {
        self.storageService = StorageService(
            modelURL: Bundle(for: Self.self).url(
                forResource: "PhotoMaker",
                withExtension: "momd"
            )!
        )
    }

    func storeImage(image: ImageStoreDto) {
        storageService.persist(
            updateWith: { (dbSymbol: DBImage) in
                dbSymbol.update(with: image)
            },
            predicate: NSPredicate(format: "name = %@", "\(image.name)")
        )
    }

    func getStoredImages() -> [ImageStoreDto] {
        let images: [DBImage]? = storageService.fetch(predicate: nil)
        return (images ?? []).map { $0.toDto() }
    }
}
