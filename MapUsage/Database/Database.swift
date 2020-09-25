//
//  Database.swift
//  MapUsage
//
//  Created by Zachary Johnson on 9/20/20.
//  Copyright © 2020 Zachary Johnson. All rights reserved.
//

import Foundation

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
    }
    
    static func SetPinData(_ newPins: [PinLocation])
    {
        myAnnotations = newPins
    }
}
