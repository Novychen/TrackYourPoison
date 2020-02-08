//
//  Tea+CoreDataProperties.swift
//  trackYourPoison
//
//  Created by Yvonne on 08.02.20.
//  Copyright © 2020 Ines&Yvonne. All rights reserved.
//
//

import Foundation
import CoreData


extension Tea {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Tea> {
        return NSFetchRequest<Tea>(entityName: "Tea")
    }

    @NSManaged public var sugar: Double
    @NSManaged public var coffeine: Double
    @NSManaged public var alcohol: Double
    @NSManaged public var size: NSObject?
    @NSManaged public var kcal: Int16
    @NSManaged public var name: String?

}
