//
//  CoreDataManager.swift
//  JLife
//
//  Created by OoO on 5/1/24.
//

import CoreData

protocol CoreDataManagerProtocol {
    
}

class CoreDataManager: CoreDataManagerProtocol {
    private let name: String
    
    private lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: name)
        container.loadPersistentStores { _, error in
            if error != nil {
                print(CoreDataError.failToLoadPersistentStores)
            }
        }
        
        return container
    }()
    
    private lazy var context = persistentContainer.viewContext
    
    init(name: String) {
        self.name = name
    }
    
    // MARK: - CRUD
    func fetchData(request: NSFetchRequest<NSFetchRequestResult>) throws -> [some NSFetchRequestResult] {
        let data = try context.fetch(request)
        
        return data
    }
    
    func insert(entityName: String, entityProperties: [String: Any]) {
        if let entity = NSEntityDescription.entity(forEntityName: entityName, in: context) {
            let managedObject = NSManagedObject(entity: entity, insertInto: context)
            
            for entityProperty in entityProperties {
                managedObject.setValue(entityProperty.value, forKey: entityProperty.key)
            }
            
            saveContext()
        }
    }
    
    func update(object: NSFetchRequest<NSFetchRequestResult>, entityProperties: [String: Any]) {
        guard let updatedObject = request(object) else { return }
        
        for entityProperty in entityProperties {
            updatedObject.setValue(entityProperty.value, forKey: entityProperty.key)
        }
        
        saveContext()
    }
    
    func deleteData(object: NSFetchRequest<NSFetchRequestResult>) {
        guard let deleteObject = request(object) else { return }
        
        context.delete(deleteObject)
        saveContext()
    }
    
    func isExistData(object: NSFetchRequest<NSFetchRequestResult>) -> Bool {
        request(object) != nil ? true : false
    }
    
    // MARK: - Private Function
    private func request(_ fetchObject: NSFetchRequest<NSFetchRequestResult>) -> NSManagedObject? {
        do {
            guard let object = try fetchData(request: fetchObject).first as? NSManagedObject else { return nil }
            
            return object
        } catch {
            print(CoreDataError.failToFetchData)
            
            return nil
        }
    }
    
    private func saveContext() {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                print(CoreDataError.failToSaveContext)
            }
        }
    }
}
