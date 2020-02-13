//
//  Consumed+CoreDataProperties.swift
//  trackYourPoison
//
//  Created by Yvonne on 12.02.20.
//  Copyright © 2020 Ines&Yvonne. All rights reserved.
//
//

import Foundation
import CoreData


extension Consumed {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Consumed> {
        return NSFetchRequest<Consumed>(entityName: "Consumed")
    }

    @NSManaged public var time: String?
    @NSManaged public var food: Food?

}
