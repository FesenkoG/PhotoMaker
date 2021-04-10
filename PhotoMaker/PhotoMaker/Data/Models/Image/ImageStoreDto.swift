//
//  ImageStoreDto.swift
//  PhotoMaker
//
//  Created by Georgy Fesenko on 4/10/21.
//

import UIKit

struct ImageStoreDto {
    let image: Data
    let name: String
    let creationDate: Date
}

extension ImageStoreDto {
    init(from domain: Image) {
        image = domain.image.jpegData(compressionQuality: 1.0) ?? Data()
        name = domain.name
        creationDate = domain.creationDate
    }

    func toDomain() -> Image {
        return .init(
            image: UIImage(data: image) ?? UIImage(),
            name: name,
            creationDate: creationDate
        )
    }
}
