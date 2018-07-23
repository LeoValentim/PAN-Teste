//
//  GameEntityExtensions.swift
//  PAN Teste
//
//  Created by Mac on 22/07/2018.
//  Copyright © 2018 Leo Valentim. All rights reserved.
//

import UIKit
import CoreData

extension GameEntity {
    
    static func ToList(_ managedContext: NSManagedObjectContext) -> [GameEntity] {
        do {
            
            let pets : [GameEntity] = try managedContext.fetch(GameEntity.fetchRequest())
            
            return pets
            
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
            
            return []
        }
    }
    
}
