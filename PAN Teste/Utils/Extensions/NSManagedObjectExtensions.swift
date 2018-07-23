//
//  NSManagedObjectExtensions.swift
//  PAN Teste
//
//  Created by Mac on 22/07/2018.
//  Copyright © 2018 Leo Valentim. All rights reserved.
//

import UIKit
import CoreData

extension NSManagedObject {
    static var managedContext: NSManagedObjectContext? {
        get {
            guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
                    return nil
            }
            return appDelegate.persistentContainer.viewContext
        }
    }
    
    static func saveChanges(changes: (_ managedContext: NSManagedObjectContext) -> Void) -> Bool{
        guard let managedContext = NSManagedObject.managedContext else {
                return false
        }
        
        do {
            
            changes(managedContext)
            
            try managedContext.save()
            return true
            
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
            return false
        }
    }
}
