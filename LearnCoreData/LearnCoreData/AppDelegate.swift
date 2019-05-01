//
//  AppDelegate.swift
//  LearnCoreData
//
//  Created by Maksim Nosov on 30/04/2019.
//  Copyright © 2019 Maksim Nosov. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
     
        let context = CoreDataStack.shared.makePrivateContext()
        
        SWAPI.shared.getAll(.people) { data in
            self.perform(in: context) {
                data.forEach { _ = People.make(from: $0, in: context) }
            }
        }
        
        SWAPI.shared.getAll(.planets) { data in
            self.perform(in: context) {
                data.forEach { _ = Planet.make(from: $0, in: context) }
            }
        }
        
        SWAPI.shared.getAll(.species) { data in
            self.perform(in: context) {
                data.forEach { _ = Specie.make(from: $0, in: context) }
            }
        }
        
        SWAPI.shared.getAll(.vehicles) { data in
            self.perform(in: context) {
                data.forEach { _ = Vehicle.make(from: $0, in: context) }
            }
        }
        
        return true
    }
    
    private func perform(in context: NSManagedObjectContext, closure: @escaping () -> ()) {
        context.perform {
            closure()
            
            do {
                if context.hasChanges {
                    try context.save()
                    debugPrint("Context changes saved")
                } else {
                    debugPrint("Context has no changes")
                }
            } catch {
                debugPrint(error)
            }
        }
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        CoreDataStack.shared.saveToStore()
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        CoreDataStack.shared.saveToStore()
    }
}

