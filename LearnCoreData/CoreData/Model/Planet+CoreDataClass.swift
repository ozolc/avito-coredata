//
//  Planet+CoreDataClass.swift
//  LearnCoreData
//
//  Created by Maksim Nosov on 01/05/2019.
//  Copyright © 2019 Maksim Nosov. All rights reserved.
//
//

import Foundation
import CoreData

@objc(Planet)
public class Planet: NSManagedObject {
    
    static func make(from json: JSON, in context: NSManagedObjectContext) -> Planet? {
        guard let objectId = json["url"].url?.lastPathComponent.asInt16 else { return nil }
        let object = Planet(entity: entity(), insertInto: context)
        
        object.created = Date.fromISO8601(json["created"].stringValue) as NSDate?
        object.edited = Date.fromISO8601(json["edited"].stringValue) as NSDate?
        object.filmIds = json["films"].array?.compactMap { $0.url?.lastPathComponent.asInt }
        object.residentIds = json["residents"].array?.compactMap { $0.url?.lastPathComponent.asInt }
        object.name = json["name"].string
        object.id = objectId
        
        object.climate = json["climate"].string
        object.diameter = json["diameter"].int32 ?? -1
        object.gravity = json["gravity"].string
        object.orbitalPeriod = json["orbital_period"].int16 ?? -1
        object.population = json["population"].int64 ?? -1
        object.rotationPeriod = json["rotation_period"].url?.lastPathComponent.asInt16 ?? -1
        object.surfaceWater = json["surface_water"].int16 ?? -1
        object.terrain = json["skin_color"].string
        
        debugPrint("Object created: \(type(of: self)) \(objectId)")
        
        return object
    }
}
