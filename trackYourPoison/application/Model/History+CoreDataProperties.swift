//
//  History+CoreDataProperties.swift
//  trackYourPoison
//
//  Created by Yvonne on 09.02.20.
//  Copyright © 2020 Ines&Yvonne. All rights reserved.
//
//

import Foundation
import CoreData


extension History {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<History> {
        return NSFetchRequest<History>(entityName: "History")
    }

    @NSManaged public var coffee: Coffee?
    @NSManaged public var sweets: Sweets?
    @NSManaged public var alcohol: Alcohol?
    @NSManaged public var softdrinks: SoftDrink?
    @NSManaged public var tea: Tea?

}
