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
        if !user.isEmpty {
          if user[0].gender == "male"{max = 65.0}
          if user[0].gender == "female"{max = 50.0}
          
          var sugar = 0.0
          for con in food.enumerated() {
              sugar = sugar + (con.element.food!.sugar)
              
          }
    
          let percent = 100/max
          print("maxSuger \(sugar * percent)")
          return sugar * percent
        }
        return 0
      }
    
      func maxCoffiene() -> Double{
          var max = 400.0
        if !user.isEmpty {
          if user[0].age < 18{
              max = user[0].weight * 3
          }
          if user[0].pregnent {
              max = 200.0
          }
          
          var coffien = 0.0
          for con in food.enumerated() {
              coffien = coffien + (con.element.food!.coffeine)
          }
      
          let percent = 100/max
          print("maxcoiffein \(coffien * percent)")
          return coffien * percent
        }
        return 0
      }

    func maxAlkohol() -> Double{
        var max  = 18.0
        if !user.isEmpty {
        if user[0].gender == "female" {
            max = 12.0;
        }else if user[0].gender == "male"{
            max = 24.0
        }else{
            max = 18.0
        }
        var alk = 0.0
        for con in food.enumerated() {
            alk = alk + ((con.element.food!.alcohol / 100) * con.element.food!.amount)
        }

          
         
          let percent = 100/max
            print("maxAlkohol \(alk * percent)")
          return alk * percent
        }
        return 0
    }

      
           func calcCoffin() -> Double{
               var tau = 3.0
            if !user.isEmpty {
              if user[0].pill {
                   tau = tau + 12
            
               }
              if user[0].pregnent {
                   tau =  tau + 17
               }
              // if age < 15 {}
              if user[0].nikotin {
                   tau = tau / 2
               }
                    print(tau)
              var coffien = 0.0
              for con in food.enumerated() {
                print("isSelcted\(con.element.food!.selected)")
                if !con.element.food!.selected{
                    coffien = coffien + (con.element.food!.coffeine )
                    con.element.food!.selected = false
                }

              }
                if coffien == 0{ return 0 }
                let time = (log(25 / coffien) * tau) / log(0.5)
                print("time in h : \(time) !!!")
                return time

           }
            return 0
        }
        
           func calcAlkohol() -> Double{
               var liquid = 0.6
            if !user.isEmpty {
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
                
                if(user[0].weight == 0){return 0}
               let pro = alk / (user[0].weight * liquid)
              print("calcAlkohol \(pro / 0.1)")
               return pro / 0.1
            }
            return 0
        }
    
    func calcDate(time : Double) -> (days : Int , hour : Int, min : Int, sec :Int) {
        let days = Int(time) / 86400
        let daysRest = Int(time) % 86400
        
        let hours = Int(daysRest) / 3600
        let hoursRest = Int(daysRest) % 3600
        
        let minutes = Int(hoursRest) / 60
        let seconds = Int(hoursRest) % 60
        return (days,hours,minutes,seconds)
    }

    func calcDateOfHour(time : Double) -> (days : Int , hour : Int, min : Int, sec :Int) {
               let days = Int(time) / 12
               let daysRest = Int(time) % 12
               
               let hours = Int(daysRest) / 1
               let hoursRest = Int(daysRest) % 1
               
               let minutes = Int(hoursRest) * 60
               let noseconds = Int(hoursRest) * 3600
               let seconds = Int(noseconds) % 60
               return (days,hours,minutes,seconds)
           }
    

  }

