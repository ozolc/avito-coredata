//
//  AbstractVehicle+CoreDataProperties.swift
//  LearnCoreData
//
//  Created by Maksim Nosov on 01/05/2019.
//  Copyright © 2019 Maksim Nosov. All rights reserved.
//
//

import Foundation
import CoreData


extension AbstractVehicle {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<AbstractVehicle> {
        return NSFetchRequest<AbstractVehicle>(entityName: "AbstractVehicle")
    }

    @NSManaged public var cargoCapacity: Int64
    @NSManaged public var consumables: String?
    @NSManaged public var costInCredits: Int64
    @NSManaged public var created: NSDate?
    @NSManaged public var crew: Int64
    @NSManaged public var edited: NSDate?
    @NSManaged public var filmIds: [Int]?
    @NSManaged public var id: Int16
    @NSManaged public var length: Float
    @NSManaged public var manufacturer: String?
    @NSManaged public var maxAtmospheringSpeed: Int64
    @NSManaged public var model: String?
    @NSManaged public var name: String?
    @NSManaged public var passengers: Int64
    @NSManaged public var pilotIds: [Int]?

}
