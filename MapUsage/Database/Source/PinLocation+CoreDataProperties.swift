//
//  PinLocation+CoreDataProperties.swift
//  MapUsage
//
//  Created by Zachary Johnson on 9/6/20.
//  Copyright © 2020 Zachary Johnson. All rights reserved.
//
//

import Foundation
import CoreData


extension PinLocation {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<PinLocation> {
        return NSFetchRequest<PinLocation>(entityName: "PinLocation")
    }

    @NSManaged public var title: String?
    @NSManaged public var latitude: Double
    @NSManaged public var subtitle: String?
    @NSManaged public var longitude: Double

}
