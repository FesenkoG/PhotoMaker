//
//  StorageService.swift
//  PhotoMaker
//
//  Created by Georgy Fesenko on 4/10/21.
//

import Foundation
import CoreData

public final class StorageService {
    private let modelURL: URL
    public init(modelURL: URL) {
        self.modelURL = modelURL
    }

    private lazy var container: NSPersistentContainer = {
        guard let model = NSManagedObjectModel(contentsOf: modelURL) else {
                fatalError("Wrong core data container configuration")
        }
        let container = NSPersistentContainer(
            name: "PhotoMaker",
            managedObjectModel: model
        )
        container.loadPersistentStores { description, error in
            if let error = error {
                fatalError("Unable to load persistent stores: \(error)")
            }
        }
        return container
    }()

    public var viewContext: NSManagedObjectContext {
        container.viewContext
    }

    public func fetch<T: DBInsertable>(predicate: NSPredicate?) -> [T]? {
        var objects: [T]?
        viewContext.performAndWait {
            let request = NSFetchRequest<NSFetchRequestResult>(entityName: T.entityName)
            request.predicate = predicate
            if let result = try? viewContext.fetch(request) as? [T] {
                objects = result
            }
        }
        return objects
    }

    public func persist<T: DBInsertable>(
        updateWith: (T) -> Void,
        predicate: NSPredicate
    ) {
        viewContext.performAndWait {
            T.insertOrUpdate(
                context: viewContext,
                updateWith: updateWith,
                predicate: predicate
            )
        }
        do {
            try viewContext.save()
        } catch {
            viewContext.rollback()
        }
    }
}
