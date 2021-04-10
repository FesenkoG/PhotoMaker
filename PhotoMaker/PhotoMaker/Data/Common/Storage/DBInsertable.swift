//
//  DBInsertable.swift
//  PhotoMaker
//
//  Created by Georgy Fesenko on 4/10/21.
//

import CoreData

public protocol DBInsertable: NSManagedObject {
    associatedtype DtoModel
    static var entityName: String { get }
    func toDto() -> DtoModel
}

extension DBInsertable {
    static func insertOrUpdate(
        context: NSManagedObjectContext,
        updateWith: (Self) -> Void,
        predicate: NSPredicate
    ) {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        request.predicate = predicate
        let object: Self
        if let result = try? context.fetch(request).first as? Self {
            object = result
        } else {
            object = Self(context: context)
        }
        updateWith(object)
    }
}
