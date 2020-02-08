//
//  Alcohol+CoreDataProperties.swift
//  trackYourPoison
//
//  Created by Yvonne on 08.02.20.
//  Copyright © 2020 Ines&Yvonne. All rights reserved.
//
//

import Foundation
import CoreData


extension Alcohol {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Alcohol> {
        return NSFetchRequest<Alcohol>(entityName: "Alcohol")
    }

    @NSManaged public var alcohol: Double
    @NSManaged public var sugar: Double
    @NSManaged public var size: NSObject?
    @NSManaged public var name: String?
    @NSManaged public var coffeine: Double
    @NSManaged public var kcal: Int16

}
