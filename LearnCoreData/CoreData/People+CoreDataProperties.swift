//
//  People+CoreDataProperties.swift
//  LearnCoreData
//
//  Created by Maksim Nosov on 30/04/2019.
//  Copyright © 2019 Maksim Nosov. All rights reserved.
//
//

import Foundation
import CoreData


extension People {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<People> {
        return NSFetchRequest<People>(entityName: "People")
    }

    @NSManaged public var birthYear: String?
    @NSManaged public var created: NSDate?
    @NSManaged public var edited: NSDate?
    @NSManaged public var eyeColor: String?
    @NSManaged public var filmIds: [Int]?
    @NSManaged public var gender: String?
    @NSManaged public var hairColor: String?
    @NSManaged public var height: Int16
    @NSManaged public var homeworldId: Int16
    @NSManaged public var id: Int16
    @NSManaged public var mass: Int16
    @NSManaged public var skinColor: String?
    @NSManaged public var specieIds: [Int]?
    @NSManaged public var starshipIds: [Int]?
    @NSManaged public var vehicleIds: [Int]?
    @NSManaged public var name: String?
    @NSManaged public var starships: NSSet?
    @NSManaged public var vehicles: NSSet?

}

// MARK: Generated accessors for starships
extension People {

    @objc(addStarshipsObject:)
    @NSManaged public func addToStarships(_ value: Starship)

    @objc(removeStarshipsObject:)
    @NSManaged public func removeFromStarships(_ value: Starship)

    @objc(addStarships:)
    @NSManaged public func addToStarships(_ values: NSSet)

    @objc(removeStarships:)
    @NSManaged public func removeFromStarships(_ values: NSSet)

}

// MARK: Generated accessors for vehicles
extension People {

    @objc(addVehiclesObject:)
    @NSManaged public func addToVehicles(_ value: Vehicle)

    @objc(removeVehiclesObject:)
    @NSManaged public func removeFromVehicles(_ value: Vehicle)

    @objc(addVehicles:)
    @NSManaged public func addToVehicles(_ values: NSSet)

    @objc(removeVehicles:)
    @NSManaged public func removeFromVehicles(_ values: NSSet)

}