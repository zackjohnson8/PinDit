//
//  Database.swift
//  PinDit
//
//  Created by Zachary Johnson on 9/20/20.
//  Copyright © 2020 Zachary Johnson. All rights reserved.
//

import Foundation
import CoreData

class Database
{
    static let shared = Database()
    static private var myAnnotations = [PinLocation]()
    
    private init(){}
    
    static func GetPinData() -> [PinLocation]
    {
        return myAnnotations
    }
    
    static func SetPinData(_ newPin: PinLocation)
    {
        myAnnotations.append(newPin)
        PersistanceService.context.insert(newPin)
        PersistanceService.saveContext()
    }
    
    static func FetchAllPersistantData()
    {
        let fetchRequest: NSFetchRequest<PinLocation> = PinLocation.fetchRequest()
        do{
            let persistantPinLocations = try PersistanceService.context.fetch(fetchRequest)
            myAnnotations.append(contentsOf: persistantPinLocations)
        }catch
        {
            print("Failed to load pin data")
        }
    }
    
    static func DeletePinData(_ deletePins: [PinLocation])
    {
        
    }
    
    static func DeletePinData(_ deletePin: PinLocation)
    {
        
    }
}
