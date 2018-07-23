//
//  GameEntity+CoreDataProperties.swift
//  
//
//  Created by Mac on 22/07/2018.
//
//

import Foundation
import CoreData


extension GameEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<GameEntity> {
        return NSFetchRequest<GameEntity>(entityName: "GameEntity")
    }

    @NSManaged public var id: Int64?
    @NSManaged public var box: String?
    @NSManaged public var giantbombId: Int64?
    @NSManaged public var name: String?
    @NSManaged public var popularity: Int64
    @NSManaged public var logo: String?
    @NSManaged public var topGame: TopGameEntity?

}
