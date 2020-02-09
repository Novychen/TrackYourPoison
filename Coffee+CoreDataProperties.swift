//
//  Coffee+CoreDataProperties.swift
//  trackYourPoison
//
//  Created by Yvonne on 09.02.20.
//  Copyright © 2020 Ines&Yvonne. All rights reserved.
//
//

import Foundation
import CoreData


extension Coffee {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Coffee> {
        return NSFetchRequest<Coffee>(entityName: "Coffee")
    }

    @NSManaged public var alcohol: Double
    @NSManaged public var amount: Double
    @NSManaged public var coffeine: Double
    @NSManaged public var kcal: Int32
    @NSManaged public var name: String?
    @NSManaged public var size: String?
    @NSManaged public var sizesAvailable: NSObject?
    @NSManaged public var sugar: Double
    @NSManaged public var time: Int64
    @NSManaged public var selected: Bool

}
