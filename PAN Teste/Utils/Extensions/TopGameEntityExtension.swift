//
//  TopGameEntityExtension.swift
//  PAN Teste
//
//  Created by Mac on 22/07/2018.
//  Copyright © 2018 Leo Valentim. All rights reserved.
//

import UIKit
import CoreData

extension TopGameEntity {
    
    static func ToList(_ managedContext: NSManagedObjectContext) -> [TopGameEntity] {
        do {
            let pets : [TopGameEntity] = try managedContext.fetch(TopGameEntity.fetchRequest())
            
            return pets
            
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
            
            return []
        }
    }
}
