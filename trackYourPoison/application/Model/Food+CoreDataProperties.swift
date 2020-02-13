//
//  Food+CoreDataProperties.swift
//  trackYourPoison
//
//  Created by Yvonne on 12.02.20.
//  Copyright © 2020 Ines&Yvonne. All rights reserved.
//
//

import Foundation
import CoreData


extension Food {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Food> {
        return NSFetchRequest<Food>(entityName: "Food")
    }

    @NSManaged public var alcohol: Double
    @NSManaged public var amount: Double
    @NSManaged public var coffeine: Double
    @NSManaged public var image: String?
    @NSManaged public var kcal: Int32
    @NSManaged public var name: String?
    @NSManaged public var selected: Bool
    @NSManaged public var size: String?
    @NSManaged public var sizesAvailable: NSObject?
    @NSManaged public var sugar: Double
    @NSManaged public var type: String?

}
