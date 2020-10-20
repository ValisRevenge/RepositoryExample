//
//  DBManager.swift
//  RepositoryExample
//
//  Created by Mishko on 10/19/20.
//  Copyright © 2020 byMishko. All rights reserved.
//

import Foundation
import CoreData

public typealias StorageContextBlock = (NSManagedObjectContext) -> Void
public typealias StorageVoidBlock = () -> Void

public protocol DBStorableObject { }
public extension DBStorableObject where Self: NSManagedObject {
    
    func inContext(_ aContext: NSManagedObjectContext) -> Self? {
        
        var result: NSManagedObject?
        
        do {
            try managedObjectContext?.obtainPermanentIDs(for: [self])
            aContext.performAndWait {
                result = aContext.object(with: objectID)
            }
        } catch {
            print("Failed to check object's context")
        }
        
        return result as? Self
    }
}

extension NSManagedObject: DBStorableObject { }

class DBManager {
    
    static var shared: DBManager = DBManager()
    
    private init() {}
    
    // MARK: - Config
    
    var shouldCacheStorage: Bool = false
    
    var storeType: String {
        
        return NSSQLiteStoreType
    }
    
    lazy var managedObjectModel: NSManagedObjectModel = {
        
        let managedObjectModel: NSManagedObjectModel = createManagedObjectModel()
        return managedObjectModel
    } ()
    
    lazy var defaultContext: NSManagedObjectContext = {
        let context: NSManagedObjectContext = createDefaultContext(container: defaultPersistentContainer)
        context.mergePolicy = NSMergePolicy.overwrite
        return context
    } ()
    
    
    lazy var defaultPersistentContainer: NSPersistentContainer = {

        let result = createDefaultContainer()
        return result
    } ()
    
    // MARK: - Creation
    
    func createDefaultContainer()-> NSPersistentContainer {
        
        let container = NSPersistentContainer(name: "Model")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            print("storeDescription = \(storeDescription)")
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }
    
    func createDefaultContext(container: NSPersistentContainer) -> NSManagedObjectContext {
        
        let result: NSManagedObjectContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        
        result.persistentStoreCoordinator = container.persistentStoreCoordinator
        result.mergePolicy = NSOverwriteMergePolicy
        result.undoManager = nil
        
        return result
    }
    
    func createManagedObjectModel() -> NSManagedObjectModel {
        
        var result: NSManagedObjectModel
        
        if let mergedModel: NSManagedObjectModel = NSManagedObjectModel.mergedModel(from: [Bundle.main]) {
            
            result = mergedModel
        } else {
            
            result = NSManagedObjectModel()
        }
        
        return result
    }
    
    // MARK: - Save
    
    func saveDefault() {
        
        save(context: defaultContext)
    }
    
    func save(context aContext: NSManagedObjectContext) {
        
        if aContext.hasChanges {
            
            do {
                try aContext.save()
                
                if let parent: NSManagedObjectContext = aContext.parent {
                    save(context: parent)
                }
            } catch _ as NSError {
                
                #if DEBUG
                abort()
                #else
                aContext.rollback()
                #endif
            }
        }
    }
    
    open func saveAndWait(block aBlock: StorageContextBlock, completion aCompletion: StorageVoidBlock? = nil) {
        
        let savingContext: NSManagedObjectContext = self.defaultContext
        
        savingContext.performAndWait {
            
            aBlock(savingContext)
            self.save(context: savingContext)
            
            if let completion: StorageVoidBlock = aCompletion {
                
                completion()
            }
        }
    }
    
    // MARK: - Find same object
    
    func isBreedUnique(id: String) -> Bool {
        
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest<NSFetchRequestResult>(entityName: "CatBreed")
        fetchRequest.predicate = NSPredicate(format: "identifier = %d", argumentArray: [id])
        
        if let result = try? defaultContext.fetch(fetchRequest), result.count != 0 {
            return false
        }
        return true
    }
    
    // MARK: - Remove entities
    
    open func removeAllEntitiesWithName(_ anEntityName: String) {
        
        self.saveAndWait(block: { context in
            let entitiesRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest<NSFetchRequestResult>()
            entitiesRequest.entity = NSEntityDescription.entity(forEntityName: anEntityName, in: context)
            entitiesRequest.includesPropertyValues = false
            
            var aError: Error?
            var entities: [AnyObject]
            
            do {
                entities = try context.fetch(entitiesRequest)
                
                for object: AnyObject in entities {
                    
                    if let object: NSManagedObject = object as? NSManagedObject {
                        
                        context.delete(object)
                    }
                }
            } catch {
                
                aError = error
            }
            
            if aError != nil {
                
                print("STStorage: remove entities with error: \(String(describing: aError))")
            }
        })
    }
    
    func remove(object aObject: NSManagedObject) {
        
        saveAndWait(block: { context in
            
            if let obj = aObject.inContext(context) {
                
                context.delete(obj)
            }
        })
    }
    
    func remove(objects aObjects: [NSManagedObject]) {
        
        saveAndWait(block: { context in
            
            for obj in aObjects {
                
                context.delete(obj)
            }
        })
    }
}
