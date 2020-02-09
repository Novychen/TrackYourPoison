//
//  Calculator.swift
//  trackYourPoison
//
//  Created by Ines Langbauer on 06.02.20.
//  Copyright © 2020 Ines&Yvonne. All rights reserved.
//
import UIKit
import CoreData

class Calculator {
    
    var user : [Profil] = []
    
    init() {
        let appDel = (UIApplication.shared.delegate as! AppDelegate)
        let context = appDel.persistentContainer.viewContext
        let request = NSFetchRequest<Profil>(entityName: "Profil")
            if let profil = try? context.fetch(request){
                 user = profil
             }
    }
  
    /*f(t) = N*e^k*t -> t = (ln(f(t)/N)/k)
          f(t) = menge des abgebauten nach der zeit t
          N = menge des eingenommen coffein in gram
          k = -0.23
          t = zeit
          @param coffien -> in mg
          */
         func calcCoffin( coffien : Double) -> Double{
             var tau = 3.0
            if user[0].pill {
                 tau = tau + 10
             }
            if user[0].pregnent {
                 tau =  tau + 17
             }
            // if age < 15 {}
            if user[0].nikotin {
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
            if user[0].gender == "female" {
                 liquid = 0.55;
             }else if user[0].gender == "male"{
                 liquid = 0.68
             }else{
                 liquid = 0.6
             }
             let pro = (level * num) / (user[0].weight * liquid)
             return pro / 0.1
       }

}

