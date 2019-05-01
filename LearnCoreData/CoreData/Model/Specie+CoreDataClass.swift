//
//  Specie+CoreDataClass.swift
//  LearnCoreData
//
//  Created by Maksim Nosov on 01/05/2019.
//  Copyright © 2019 Maksim Nosov. All rights reserved.
//
//

import Foundation
import CoreData

@objc(Specie)
public class Specie: NSManagedObject {

    static func make(from json: JSON, in context: NSManagedObjectContext) -> Specie? {
        guard let objectId = json["url"].url?.lastPathComponent.asInt16 else { return nil }
        let object = Specie(entity: entity(), insertInto: context)
        
        object.created = Date.fromISO8601(json["created"].stringValue) as NSDate?
        object.edited = Date.fromISO8601(json["edited"].stringValue) as NSDate?
        object.filmIds = json["films"].array?.compactMap { $0.url?.lastPathComponent.asInt }
        object.name = json["name"].string
        object.id = objectId
        
        object.averageHeight = json["average_height"].int16 ?? -1
        object.averageLifespan = json["average_lifespan"].int16 ?? -1
        object.classification = json["classificateion"].string
        object.designation = json["designation"].string
        object.eyeColors = json["eye_colors"].string?.components(separatedBy: ",")
        object.hairColors = json["hair_colors"].string?.components(separatedBy: ",")
        object.homeworldId = json["homeworld"].url?.lastPathComponent.asInt16 ?? -1
        object.language = json["language"].string
        object.eyeColors = json["eye_colors"].string?.components(separatedBy: ",")
        object.peopleids = json["people"].array?.compactMap { $0.url?.lastPathComponent.asInt }
        object.skinColors = json["skin_colors"].string?.components(separatedBy: ",")
        
        debugPrint("Object created: \(type(of: self)) \(objectId)")
        
        return object
    }
}
