//
//  Vehicle+CoreDataClass.swift
//  LearnCoreData
//
//  Created by Maksim Nosov on 30/04/2019.
//  Copyright © 2019 Maksim Nosov. All rights reserved.
//
//

import Foundation
import CoreData

@objc(Vehicle)
public class Vehicle: AbstractVehicle {

    static func make(from json: JSON, in context: NSManagedObjectContext) -> Vehicle? {
        guard let objectId = json["url"].url?.lastPathComponent.asInt16 else { return nil }
        let object = Vehicle(entity: entity(), insertInto: context)
        
        object.created = Date.fromISO8601(json["created"].stringValue) as NSDate?
        object.edited = Date.fromISO8601(json["edited"].stringValue) as NSDate?
        
        object.filmIds = json["films"].array?.compactMap { $0.url?.lastPathComponent.asInt }
        object.name = json["name"].string
        object.id = objectId
        
        object.cargoCapacity = json["cargo_capacity"].int64 ?? -1
        object.consumables = json["consumables"].string
        object.costInCredits = json["cost_in_credits"].int64 ?? -1
        object.crew = json["crew"].int64 ?? -1
        object.length = json["length"].float ?? -1
        object.manufacturer = json["manufacturer"].string
        object.maxAtmospheringSpeed = json["max_atmosphering_speed"].int64 ?? -1
        object.model = json["model"].string
        object.passengers = json["passengers"].int64 ?? -1
        object.pilotIds = json["pilots"].array?.compactMap { $0.url?.lastPathComponent.asInt }
        object.vehicleClass = json["vehicle_class"].string
        
        object.vehicleClass = json["name"].string
        object.id = objectId
        
        debugPrint("Object created: \(type(of: self)) \(objectId)")
        
        
        
        return object
    }
}
