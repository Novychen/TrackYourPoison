//
//  Profil+CoreDataProperties.swift
//  trackYourPoison
//
//  Created by Yvonne on 10.02.20.
//  Copyright © 2020 Ines&Yvonne. All rights reserved.
//
//

import Foundation
import CoreData


extension Profil {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Profil> {
        return NSFetchRequest<Profil>(entityName: "Profil")
    }

    @NSManaged public var age: Int64
    @NSManaged public var gender: String?
    @NSManaged public var name: String?
    @NSManaged public var nikotin: Bool
    @NSManaged public var pill: Bool
    @NSManaged public var pregnent: Bool
    @NSManaged public var weight: Double

}
