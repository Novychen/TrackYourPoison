//
//  HomeViewController.swift
//  trackYourPoison
//
//  Created by Yvonne on 14.01.20.
//  Copyright © 2020 Ines&Yvonne. All rights reserved.
//

import UIKit
import CoreData

class HomeViewController : UIViewController {

    @IBOutlet weak var TimerTable: UITableView!
    @IBOutlet weak var alcoholTimer: UILabel!
    @IBOutlet weak var coffeineTimer: UILabel!
    var timer : Timer!

    @IBOutlet weak var maxSuger: UILabel!
    
    @IBOutlet weak var maxAlkohol: UILabel!
    
    @IBOutlet weak var maxCoffiene: UILabel!
    
    var eventDate : Date = Date()
    var eventDateCoffiene : Date = Date()
     
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        let defaults = UserDefaults.standard
        let start = defaults.integer(forKey: AppDelegate.appStartCount)
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        if (start == 1) {
            saveData(context : context)
            appDelegate.saveContext()
        }
        
        setAlkoholTimer()
        setCoffieneTimer()
        
        
        

        let calc = Calculator()
        maxSuger.text = String("\( calc.maxSugar().rounded())%")
        maxAlkohol.text = String("\( calc.maxAlkohol().rounded())%")
        maxCoffiene.text = String("\( calc.maxCoffiene().rounded())%")
                timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(UpdateTime), userInfo: nil, repeats: true) // Repeat "func Update() " every second and update the label

        
       }
    
    func saveData(context : NSManagedObjectContext) {
       
        let drinks = SoftDrinkData()
        let sweets = SweetsData()
        let coffee = CoffeeData()
        
        var name = drinks.getName()
        var coffeine = drinks.getCoffeine()
        var sugar = drinks.getSugar()
        var size = drinks.getSize()
        var kcal = drinks.getKcal()
        
        for (index, _) in name.enumerated(){
            let food = NSEntityDescription.insertNewObject(forEntityName: "Food", into: context) as! Food
            food.name = name[index]
            food.sugar = sugar[index]
            food.coffeine = coffeine[index]
            food.sizesAvailable = size[index] as NSObject
            food.kcal = Int32(kcal[index])
            food.type = "softDrink"
        }
        
        name = sweets.getName()
        coffeine = sweets.getCoffeine()
        sugar = sweets.getSugar()
        var alcohol = sweets.getAlcohol()
        size = sweets.getSize()
        kcal = sweets.getKcal()
        var image = sweets.getImage()
    
        for (index, _) in name.enumerated(){
             let food = NSEntityDescription.insertNewObject(forEntityName: "Food", into: context) as! Food
            food.name = name[index]
            food.sugar = sugar[index]
            food.coffeine = coffeine[index]
            food.alcohol = alcohol[index]
            food.sizesAvailable = size[index] as NSObject
            food.kcal = Int32(kcal[index])
            food.image = image[index]
            food.type = "sweets"
        }
        
        name = coffee.getName()
        coffeine = coffee.getCoffeine()
        sugar = coffee.getSugar()
        size = coffee.getSize()
        kcal = coffee.getKcal()
        image = coffee.getImage()
        
        for (index, _) in name.enumerated(){
             let food = NSEntityDescription.insertNewObject(forEntityName: "Food", into: context) as! Food
            food.name = name[index]
            food.sugar = sugar[index]
            food.coffeine = coffeine[index]
            food.sizesAvailable = size[index] as NSObject
            food.kcal = Int32(kcal[index])
            food.image = image[index]
            food.type = "coffee"
        }
        
        do {
            try context.save()
            print("saved data")
        } catch let error as NSError { print("Could not save. \(error), \(error.userInfo)") }
    
       }
    
    
    
    
    @objc func UpdateTime() {
         let userCalendar = Calendar.current
         // Set Current Date
         let date = Date()
         let components = userCalendar.dateComponents([.hour, .minute, .month, .year, .day, .second], from: date)
         let currentDate = userCalendar.date(from: components)!

        //print("current date\(currentDate)")
        
         // Set Event Date
//         var eventDateComponents = DateComponents()
//         eventDateComponents.year = 2020
//         eventDateComponents.month = 02
//         eventDateComponents.day = 16
//        eventDateComponents.hour = 00
//         eventDateComponents.minute = 00
//        eventDateComponents.second = 00
//         eventDateComponents.timeZone = TimeZone(abbreviation: "GMT+1")
         
         // Convert eventDateComponents to the user's calendar
        
         
         // Change the seconds to days, hours, minutes and seconds
         let timeLeftAkl = userCalendar.dateComponents([.day, .hour, .minute, .second], from: currentDate, to: eventDate)
        let timeLeftCof = userCalendar.dateComponents([.day, .hour, .minute, .second], from: currentDate, to: eventDateCoffiene)
         // Display Countdown
        alcoholTimer.text = "\(timeLeftAkl.hour!): \(timeLeftAkl.minute!): \(timeLeftAkl.second!)"
         coffeineTimer.text = "\(timeLeftCof.hour!): \(timeLeftCof.minute!): \(timeLeftCof.second!)"
         // Show diffrent text when the event has passed
         endEvent(currentdate: currentDate)
        
     }
     
     func endEvent(currentdate: Date) {
         if currentdate >= eventDate {
            alcoholTimer.text = "end!!"
         }
        if currentdate >= eventDateCoffiene {
            coffeineTimer.text = "end!!"
        }
        
        if currentdate >= eventDate && currentdate >= eventDateCoffiene{
            print("timer invalitdate")
            timer.invalidate()
        }
     }
    func setAlkoholTimer(){
        let calc = Calculator()
        let userCalendar = Calendar.current
               let date = Date()
               let components = userCalendar.dateComponents([.hour, .minute, .month, .year, .day, .second], from: date)
               let currentDate = userCalendar.date(from: components)!
               let time =  userCalendar.dateComponents([.hour, .minute, .month, .year, .day, .second], from: currentDate)
               if currentDate <= eventDate {
                    let time =  userCalendar.dateComponents([.hour, .minute, .month, .year, .day, .second], from: eventDate)
               }
               var eventDateComponents = DateComponents()
              let test = calc.calcDateOfHour(time: calc.calcAlkohol())
               eventDateComponents.year = time.year
               eventDateComponents.month = time.month
               eventDateComponents.day = Int(time.day!) + test.days
               eventDateComponents.hour = Int(time.hour!) + test.hour
               eventDateComponents.minute = Int(time.minute!) + test.min
               eventDateComponents.second = Int(time.second!) + test.sec
               eventDateComponents.timeZone = TimeZone(abbreviation: "GMT+1")
               eventDate = userCalendar.date(from: eventDateComponents)!
        print("ALKOHOLTimerSet!!\(eventDate)")
               }
    func setCoffieneTimer() {
        let calc = Calculator()
        let userCalendar = Calendar.current
        let date = Date()
        let components = userCalendar.dateComponents([.hour, .minute, .month, .year, .day, .second], from: date)
        let currentDate = userCalendar.date(from: components)!
        let time =  userCalendar.dateComponents([.hour, .minute, .month, .year, .day, .second], from: currentDate)
        if currentDate <= eventDateCoffiene {
               let time =  userCalendar.dateComponents([.hour, .minute, .month, .year, .day, .second], from: eventDateCoffiene)
        }
        var eventDateComponents = DateComponents()

        let test = calc.calcDateOfHour(time: calc.calcCoffin())
        eventDateComponents.year = time.year
        eventDateComponents.month = time.month
        eventDateComponents.day = Int(time.day!) + test.days
        eventDateComponents.hour = Int(time.hour!) + test.hour
        eventDateComponents.minute = Int(time.minute!) + test.min
        eventDateComponents.second = Int(time.second!) + test.sec
        eventDateComponents.timeZone = TimeZone(abbreviation: "GMT+1")
        eventDateCoffiene = userCalendar.date(from: eventDateComponents)!
        print("CoffieneTimerSet!!\(eventDateCoffiene)")
    }
    
}
