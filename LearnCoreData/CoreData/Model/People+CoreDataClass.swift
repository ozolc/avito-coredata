//
//  People+CoreDataClass.swift
//  LearnCoreData
//
//  Created by Maksim Nosov on 30/04/2019.
//  Copyright © 2019 Maksim Nosov. All rights reserved.
//
//

import Foundation
import CoreData

@objc(People)
public class People: NSManagedObject {
    
    static func make(from json: JSON, in context: NSManagedObjectContext) -> People? {
        guard let objectId = json["url"].url?.lastPathComponent.asInt16 else { return nil }
        let object = People(entity: entity(), insertInto: context)
        
        object.created = Date.fromISO8601(json["created"].stringValue) as NSDate?
        object.edited = Date.fromISO8601(json["edited"].stringValue) as NSDate?
        object.filmIds = json["films"].array?.compactMap { $0.url?.lastPathComponent.asInt }
        object.name = json["name"].string
        object.id = objectId
        
        object.birthYear = json["birth_year"].string
        object.eyeColor = json["eye_color"].string
        object.gender = json["gender"].string
        object.hairColor = json["hair_color"].string
        object.height = json["height"].int16 ?? -1
        object.homeworldId = json["homeworld"].url?.lastPathComponent.asInt16 ?? -1
        object.mass = json["mass"].int16 ?? -1
        object.skinColor = json["skin_color"].string
        object.specieIds = json["species"].array?.compactMap { $0.url?.lastPathComponent.asInt }
        object.starshipIds = json["starships"].array?.compactMap { $0.url?.lastPathComponent.asInt }
        object.vehicleIds = json["vehicles"].array?.compactMap { $0.url?.lastPathComponent.asInt }
        
        debugPrint("Object created: \(type(of: self)) \(objectId)")
        
        return object
    }
}
