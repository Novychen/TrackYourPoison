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
     var food : [Consumed]  = []
    
    init() {
        let appDel = (UIApplication.shared.delegate as! AppDelegate)
        let context = appDel.persistentContainer.viewContext
        let request = NSFetchRequest<Profil>(entityName: "Profil")
            if let profil = try? context.fetch(request){
                 user = profil
             }
        let requestFood = NSFetchRequest<Consumed>(entityName: "Consumed")
                     if let confood = try? context.fetch(requestFood){
                          food = confood
                      }
    }
    
      func maxSugar() -> Double{
          var max = 60.0
          if user[0].gender == "male"{max = 65.0}
          if user[0].gender == "female"{max = 50.0}
          
          var sugar = 0.0
          for con in food.enumerated() {
              sugar = sugar + (con.element.food!.sugar * con.element.food!.amount)
              
          }
          let percent = max / 100
          print("maxSuger \(sugar * percent)")
          return sugar * percent
          
      }
      func maxCoffiene() -> Double{
          var max = 400.0
          if user[0].age < 18{
              max = user[0].weight * 3
          }
          if user[0].pregnent {
              max = 200.0
          }
          
          var coffien = 0.0
          for con in food.enumerated() {
              coffien = coffien + (con.element.food!.coffeine * con.element.food!.amount)
              
          }
          let percent = max / 100
          print("maxcoiffein \(coffien * percent)")
          return coffien * percent
      }
      func maxAlkohol() -> Double{
          var max  = 0.0
          if user[0].gender == "female" {
              max = 12.0;
          }else if user[0].gender == "male"{
              max = 24.0
          }else{
              max = 18.0
          }
          
          var alk = 0.0
          for con in food.enumerated() {
              alk = alk + (con.element.food!.alcohol * con.element.food!.amount)
          }
          
          
          let percent = max / 100
            print("maxAlkohol \(alk * percent)")
          return alk * percent
      }
      /*f(t) = N*e^k*t -> t = (ln(f(t)/N)/k)
            f(t) = menge des abgebauten nach der zeit t
            N = menge des eingenommen coffein in gram
            k = -0.23
            t = zeit
            @param coffien -> in mg
            */
           func calcCoffin() -> Double{
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
              var coffien = 0.0
              for con in food.enumerated() {
                if con.element.food!.selected{
                    coffien = coffien + (con.element.food!.coffeine * con.element.food!.amount)
                    con.element.food!.selected = false
                }
              
                  
              }
               let clean = log(1/2) / tau
            if coffien == 0{return 0}
              return log(25 / coffien) / clean
           }
           //gets the time until the alcohol is vanisched for the blod
           /*
            köperflüssigkeits anteil genaue berechung
            Frauen: - 2,097 + 0,1069 x Größe in cm + 0,2466 x Körpergewicht in kg
            Männer:  2,447 - 0,09516 x Alter in Jahr + 0,1074 x Größe in cm + 0,3362 x Körpergewicht
            abbau 0,1 -0,2 prommile im blut**/
           func calcAlkohol() -> Double{
               var liquid = 0.0
              if user[0].gender == "female" {
                   liquid = 0.55;
               }else if user[0].gender == "male"{
                   liquid = 0.68
               }else{
                   liquid = 0.6
               }
              var alk = 0.0
              for con in food.enumerated() {
                if con.element.food!.selected{
                  alk = alk + (con.element.food!.alcohol * con.element.food!.amount)
                    con.element.food!.selected = false
                }
              }
               let pro = alk / (user[0].weight * liquid)
              print("maxAlkohol \(pro / 0.1)")
               return pro / 0.1
         }
    
    func calcDate(time : Double) -> (days : Int , hour : Int, min : Int, sec :Int) {
        let days = Int(time) / 86400
        let daysRest = Int(time) % 86400
        
        let hours = Int(daysRest) / 3600
        let hoursRest = Int(daysRest) % 3600
        
        let minutes = Int(hoursRest) / 60
        let seconds = Int(hoursRest) % 60
        return (0,hours,minutes,seconds)
    }

  }
