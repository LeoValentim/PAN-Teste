//
//  TopGameEntity+CoreDataProperties.swift
//  
//
//  Created by Mac on 22/07/2018.
//
//

import Foundation
import CoreData


extension TopGameEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TopGameEntity> {
        return NSFetchRequest<TopGameEntity>(entityName: "TopGameEntity")
    }

    @NSManaged public var channels: Int64
    @NSManaged public var viewers: Int64
    @NSManaged public var game: GameEntity?
}
