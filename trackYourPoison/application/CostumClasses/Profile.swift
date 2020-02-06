//
//  Profile.swift
//  trackYourPoison
//
//  Created by Ines Langbauer on 14.01.20.
//  Copyright © 2020 Ines&Yvonne. All rights reserved.
//

import Foundation
class Profile {
    
    var name : String
    var weight : Double
    var age : Int
    var gender : Gender
    
    init(name : String, weight : Double, age : Int, gender : Gender) {
        self.name = name
        self.age = age
        self.weight = weight
        self.gender = gender
    }
    
    init() {
        self.name = ""
        self.age = 0
        self.weight = 0.0
        self.gender = .unknown
    }
}

enum Gender {
    case female
    case male
    case unknown
}

