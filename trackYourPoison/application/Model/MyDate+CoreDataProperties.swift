//
//  MyDate+CoreDataProperties.swift
//  trackYourPoison
//
//  Created by Ines Langbauer on 15.02.20.
//  Copyright © 2020 Ines&Yvonne. All rights reserved.
//
//

import Foundation
import CoreData


extension MyDate {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<MyDate> {
        return NSFetchRequest<MyDate>(entityName: "MyDate")
    }

    @NSManaged public var dateAlk: Date?
    @NSManaged public var dateCof: Date?
    @NSManaged public var hoursAlk: Double
    @NSManaged public var hoursCof: Double

}
