//
//  DBImage.swift
//  PhotoMaker
//
//  Created by Georgy Fesenko on 4/10/21.
//

import CoreData

final class DBImage: NSManagedObject, DBInsertable {
    static var entityName: String = "Image"

    @NSManaged var image: Data
    @NSManaged var name: String
    @NSManaged var creationDate: Date
}

extension DBImage {
    func update(with dto: ImageStoreDto) {
        image = dto.image
        name = dto.name
        creationDate = dto.creationDate
    }

    func toDto() -> ImageStoreDto {
        return .init(
            image: image,
            name: name,
            creationDate: creationDate
        )
    }
}

