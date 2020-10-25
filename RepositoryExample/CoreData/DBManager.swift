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
    
    private lazy var context: NSManagedObjectContext = {
        let context: NSManagedObjectContext = createDefaultContext(container: persistentContainer)
        context.mergePolicy = NSMergePolicy.overwrite
        return context
    } ()
    
    private lazy var persistentContainer: NSPersistentContainer = {
        let result = createDefaultContainer()
        return result
    } ()
    
    var defaultContext: NSManagedObjectContext {
        return context
    }
    
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
                
                print("Storage: remove entities with error: \(String(describing: aError))")
            }
        })
    }
}
