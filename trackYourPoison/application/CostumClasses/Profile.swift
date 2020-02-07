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
    var pill : Bool
    var pregnant : Bool
    var zigaretts : Bool
    
    init(name : String, weight : Double, age : Int, gender : Gender) {
        self.name = name
        self.age = age
        self.weight = weight
        self.gender = gender
        self.pill = false
        self.pregnant = false
        self.zigaretts = false
    }
    
    init() {
        self.name = ""
        self.age = 0
        self.weight = 0.0
        self.gender = .unknown
        self.pill = false
        self.pregnant = false
        self.zigaretts = false
    }
    /*f(t) = N*e^k*t -> t = (ln(f(t)/N)/k)
     f(t) = menge des abgebauten nach der zeit t
     N = menge des eingenommen coffein in gram
     k = -0.23
     t = zeit
     @param coffien -> in mg
     **/
    func calcCoffin( coffien : Double) -> Double{
        var tau = 3.0
        if pill {
            tau = tau + 10
        }
        if pregnant {
            tau =  tau + 17
        }
        if age < 15 {
            
        }
        if zigaretts {
            tau = tau / 2
        }
        let clean = log(1/2) / tau
       return 0.5 + log(0.025 / coffien) / clean
    }
    func calcSugar(){}
    //gets the time until the alcohol is vanisched for the blod
    /*
     köperflüssigkeits anteil genaue berechung
     Frauen: - 2,097 + 0,1069 x Größe in cm + 0,2466 x Körpergewicht in kg
     Männer:  2,447 - 0,09516 x Alter in Jahr + 0,1074 x Größe in cm + 0,3362 x Körpergewicht
     abbau 0,1 -0,2 prommile im blut**/
    func calcAlkohol(level : Double, num : Double) -> Double{
        var liquid = 0.0
        if gender == .female {
            liquid = 0.55;
        }else if gender == .male{
            liquid = 0.68
        }else{
            liquid = 0.6
        }
        let pro = (level * num) / (weight * liquid)
        return pro / 0.1
        
    }
}

enum Gender {
    case female
    case male
    case unknown
}

