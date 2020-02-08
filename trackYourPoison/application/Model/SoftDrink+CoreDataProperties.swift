//
//  SoftDrink+CoreDataProperties.swift
//  trackYourPoison
//
//  Created by Yvonne on 07.02.20.
//  Copyright © 2020 Ines&Yvonne. All rights reserved.
//
//

import Foundation
import CoreData


extension SoftDrink {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<SoftDrink> {
        return NSFetchRequest<SoftDrink>(entityName: "SoftDrink")
    }

    @NSManaged public var alcohol: Double
    @NSManaged public var coffeine: Double
    @NSManaged public var name: String?
    @NSManaged public var size: [Int]?
    @NSManaged public var sugar: Double
    @NSManaged public var kcal: Int16

}
