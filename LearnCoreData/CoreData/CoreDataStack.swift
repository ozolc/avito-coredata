//
//  CoreDataStack.swift
//  LearnCoreData
//
//  Created by Maksim Nosov on 30/04/2019.
//  Copyright © 2019 Maksim Nosov. All rights reserved.
//

import CoreData

final class CoreDataStack {
    
    private(set) static var shared: CoreDataStack = {
        return CoreDataStack()
    }()
    
    private let storeIsReady = DispatchGroup()
    
    private let modelName: String
    private let storeName: String
    
    lazy var mainContext: NSManagedObjectContext = {
        self.storeIsReady.wait()
        
        return DispatchQueue.anywayOnMain {
            let context = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
            context.mergePolicy = NSMergePolicy.mergeByPropertyObjectTrump
            context.persistentStoreCoordinator = self.coordinator
            return context
        }
    }()
    
    private lazy var coordinator: NSPersistentStoreCoordinator = {
        NSPersistentStoreCoordinator(managedObjectModel: self.objectModel)
    }()
    
    private lazy var objectModel: NSManagedObjectModel = {
        guard let model = NSManagedObjectModel(contentsOf: self.objectModelUrl) else {
            fatalError("Error initializing mom from \(self.modelName)")
        }
        
        return model
    }()
    
    private lazy var objectModelUrl: URL = {
        guard let url = Bundle.main.url(forResource: self.modelName, withExtension: "momd") else {
            fatalError("Error loading model from bundle")
        }
        
        return url
    }()
    
    private lazy var documentsUrl: URL = {
        guard let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).last else {
            fatalError("Unable to resolve document directory")
        }
        
        return url
    }()
    
    init(modelName: String = "LearnCoreData", storeName: String = "LearnCoreData.sqlite"){
        self.modelName = modelName
        self.storeName = storeName
        registerStore()
    }
    
    func makePrivateContext() -> NSManagedObjectContext {
        storeIsReady.wait()
        
        let context = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
        context.parent = mainContext
        return context
    }
    
    func saveToStore() {
        storeIsReady.wait()
        
        DispatchQueue.anywayOnMain {
            guard mainContext.hasChanges else {
                debugPrint("Data has not changes")
                return
            }
            do {
                try mainContext.save()
                debugPrint("Data succesfully save to store")
            } catch {
                debugPrint("Data nos saved to store with error \(error)")
            }
        }
    }
    
    private func registerStore() {
        storeIsReady.enter()
        
        DispatchQueue.global(qos: .background).async {
            let storeUrl = self.documentsUrl.appendingPathComponent(self.storeName)
            
            do {
                try self.coordinator.addPersistentStore(
                    ofType: NSSQLiteStoreType,
                    configurationName: nil,
                    at: storeUrl,
                    options: nil
                )
                
                self.storeIsReady.leave()
            } catch {
                fatalError("Error create store: \(error)")
            }
        }
    }
}
