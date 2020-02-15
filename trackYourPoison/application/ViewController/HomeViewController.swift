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
    
    var date : [MyDate] = []
    var savedData = false
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
        if (start == 1 && !savedData) {
            saveData(context : context)
            appDelegate.saveContext()
            savedData = true
        }
        let request = NSFetchRequest<MyDate>(entityName: "MyDate")
                if let num = try? context.fetch(request){
                   date = num
               }
        let userCalendar = Calendar.current
               let mydate = Date()
               let components = userCalendar.dateComponents([.hour, .minute, .month, .year, .day, .second], from: mydate)
        _ = userCalendar.date(from: components)!
        if date.isEmpty{
            let dateNew = MyDate(context: context)
            
            dateNew.hoursAlk = setAlkoholTimer(alkohol: 0.0)
            dateNew.hoursCof = setCoffieneTimer(coffiene : 0.0)
            dateNew.dateAlk = eventDate
            dateNew.dateCof = eventDateCoffiene
            
        }else{
            eventDate = date[0].dateAlk!
            eventDateCoffiene = date[0].dateCof!
            date[0].hoursCof = setCoffieneTimer(coffiene :  date[0].hoursCof)
            date[0].dateCof = eventDateCoffiene
            date[0].hoursAlk = setAlkoholTimer(alkohol: date[0].hoursAlk)
            date[0].dateAlk = eventDate
        }
             appDelegate.saveContext()
        print("*********************")
        print(eventDate)
        print(eventDateCoffiene)
        print("*********************")
        
        let calc = Calculator()
        maxSuger.text = String("\( calc.maxSugar().rounded())%")
        maxAlkohol.text = String("\( calc.maxAlkohol().rounded())%")
        maxCoffiene.text = String("\( calc.maxCoffiene().rounded())%")

                timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(UpdateTime), userInfo: nil, repeats: true) // Repeat "func Update() " every second and update the label

               }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let defaults = UserDefaults.standard
        let start = defaults.integer(forKey: AppDelegate.appStartCount)
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        if (start == 1 && !savedData) {
            saveData(context : context)
            appDelegate.saveContext()
            savedData = true
        }
    }
    
    func saveData(context : NSManagedObjectContext) {
       
        let drinks = SoftDrinkData()
        let sweets = SweetsData()
        let coffee = CoffeeData()
        let alcohol = AlcoholData()
        let tea = TeaData()

        var name = drinks.getName()
        var coffeine = drinks.getCoffeine()
        var sugar = drinks.getSugar()
        var size = drinks.getSize()
        var kcal = drinks.getKcal()
        var image = drinks.getImage()
        
        for (index, _) in name.enumerated(){
            let food = NSEntityDescription.insertNewObject(forEntityName: "Food", into: context) as! Food
            food.name = name[index]
            food.sugar = sugar[index]
            food.coffeine = coffeine[index]
            food.size = size[index]
            food.kcal = Int32(kcal[index])
            food.image = image[index]
            food.type = "softdrink"
        }
        
        name = sweets.getName()
        coffeine = sweets.getCoffeine()
        sugar = sweets.getSugar()
        var alcoholValue = sweets.getAlcohol()
        size = sweets.getSize()
        kcal = sweets.getKcal()
        image = sweets.getImage()
    
        for (index, _) in name.enumerated(){
            let food = NSEntityDescription.insertNewObject(forEntityName: "Food", into: context) as! Food
            food.name = name[index]
            food.sugar = sugar[index]
            food.coffeine = coffeine[index]
            food.alcohol = alcoholValue[index]
            food.size = size[index]
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
            food.size = size[index]
            food.kcal = Int32(kcal[index])
            food.image = image[index]
            food.type = "coffee"
        }
        
        name = alcohol.getName()
        coffeine = alcohol.getCoffeine()
        sugar = alcohol.getSugar()
        size = alcohol.getSize()
        kcal = alcohol.getKcal()
        image = alcohol.getImage()
        alcoholValue = alcohol.getAlcohol()

        for (index, _) in name.enumerated(){
            let food = NSEntityDescription.insertNewObject(forEntityName: "Food", into: context) as! Food
            food.name = name[index]
            food.sugar = sugar[index]
            food.coffeine = coffeine[index]
            food.alcohol = alcoholValue[index]
            food.size = size[index]
            food.kcal = Int32(kcal[index])
            food.image = image[index]
            food.type = "alcohol"
        }
        
        name = tea.getName()
        coffeine = tea.getCoffeine()
        sugar = tea.getSugar()
        size = tea.getSize()
        kcal = tea.getKcal()
        image = tea.getImage()
        
        for (index, _) in name.enumerated(){
            let food = NSEntityDescription.insertNewObject(forEntityName: "Food", into: context) as! Food
            food.name = name[index]
            food.sugar = sugar[index]
            food.coffeine = coffeine[index]
            food.size = size[index]
            food.kcal = Int32(kcal[index])
            food.image = image[index]
            food.type = "tea"
        }
        
        do {
            try context.save()
            print("saved data")
        } catch let error as NSError { print("Could not save. \(error), \(error.userInfo)") }
    
       }
    
    @objc func UpdateTime() {
         let userCalendar = Calendar.current

         let date = Date()
         let components = userCalendar.dateComponents([.hour, .minute, .month, .year, .day, .second], from: date)
         let currentDate = userCalendar.date(from: components)!


         let timeLeftAkl = userCalendar.dateComponents([.day, .hour, .minute, .second], from: currentDate, to: eventDate)
        let timeLeftCof = userCalendar.dateComponents([.day, .hour, .minute, .second], from: currentDate, to: eventDateCoffiene)

        alcoholTimer.text = "\(timeLeftAkl.day!):\(timeLeftAkl.hour!): \(timeLeftAkl.minute!): \(timeLeftAkl.second!)"
        coffeineTimer.text = "\(timeLeftCof.day!):\(timeLeftCof.hour!): \(timeLeftCof.minute!): \(timeLeftCof.second!)"

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
    func setAlkoholTimer(alkohol : Double) -> Double{
        let calc = Calculator()
        let userCalendar = Calendar.current
        let date = Date()
        let components = userCalendar.dateComponents([.hour, .minute, .month, .year, .day, .second], from: date)
        let currentDate = userCalendar.date(from: components)!
        var time =  userCalendar.dateComponents([.hour, .minute, .month, .year, .day, .second], from: currentDate)
  
        var eventDateComponents = DateComponents()
        let hours = calc.calcAlkohol()
        if hours == 0.0 {
            eventDate = currentDate
            return 0.0
        }
        if alkohol != hours{
                   if currentDate < eventDate{
                       time =  userCalendar.dateComponents([.hour, .minute, .month, .year, .day, .second], from: eventDate)}
                   if(hours > alkohol){
                       let test = calc.calcDateOfHour(time: hours - alkohol)
                       eventDateComponents.year = time.year
                       eventDateComponents.month = time.month
                       eventDateComponents.day = Int(time.day!) + test.days
                       eventDateComponents.hour = Int(time.hour!) + test.hour
                       eventDateComponents.minute = Int(time.minute!) + test.min
                       eventDateComponents.second = Int(time.second!) + test.sec
                       eventDateComponents.timeZone = TimeZone(abbreviation: "GMT+1")
                       eventDate = userCalendar.date(from: eventDateComponents)!
                   }else{
                       let test = calc.calcDateOfHour(time: alkohol - hours)
                       eventDateComponents.year = time.year
                       eventDateComponents.month = time.month
                       eventDateComponents.day = Int(time.day!) - test.days
                       eventDateComponents.hour = Int(time.hour!) - test.hour
                       eventDateComponents.minute = Int(time.minute!) - test.min
                       eventDateComponents.second = Int(time.second!) - test.sec
                       eventDateComponents.timeZone = TimeZone(abbreviation: "GMT+1")
                       eventDate = userCalendar.date(from: eventDateComponents)!
                   }
                   print("AlkoholTimerSet!!\(eventDateCoffiene)")
                   return hours
               }else{
                   print("AlkoholTimerSet remains !!")
                   return alkohol
               }
    
    }

    
   

    func setCoffieneTimer(coffiene : Double) -> Double {
        let calc = Calculator()
        let userCalendar = Calendar.current
        let date = Date()
        let components = userCalendar.dateComponents([.hour, .minute, .month, .year, .day, .second], from: date)
        let currentDate = userCalendar.date(from: components)!
        var time =  userCalendar.dateComponents([.hour, .minute, .month, .year, .day, .second], from: currentDate)
        var eventDateComponents = DateComponents()
        let hours = calc.calcCoffin()
        if hours == 0.0 {
                  eventDateCoffiene = currentDate
                  return 0.0
              }
        if coffiene != hours{
            if currentDate < eventDateCoffiene{
                time =  userCalendar.dateComponents([.hour, .minute, .month, .year, .day, .second], from: eventDateCoffiene)}
            if(hours > coffiene){
                let test = calc.calcDateOfHour(time: hours - coffiene)
                eventDateComponents.year = time.year
                eventDateComponents.month = time.month
                eventDateComponents.day = Int(time.day!) + test.days
                eventDateComponents.hour = Int(time.hour!) + test.hour
                eventDateComponents.minute = Int(time.minute!) + test.min
                eventDateComponents.second = Int(time.second!) + test.sec
                eventDateComponents.timeZone = TimeZone(abbreviation: "GMT+1")
                eventDateCoffiene = userCalendar.date(from: eventDateComponents)!
            }else{
                let test = calc.calcDateOfHour(time: coffiene - hours)
                eventDateComponents.year = time.year
                eventDateComponents.month = time.month
                eventDateComponents.day = Int(time.day!) - test.days
                eventDateComponents.hour = Int(time.hour!) - test.hour
                eventDateComponents.minute = Int(time.minute!) - test.min
                eventDateComponents.second = Int(time.second!) - test.sec
                eventDateComponents.timeZone = TimeZone(abbreviation: "GMT+1")
                eventDateCoffiene = userCalendar.date(from: eventDateComponents)!
            }
            print("CoffieneTimerSet!!\(eventDateCoffiene)")
            return hours
        }else{
            print("CoffieneTimerSet remains !!")
            return coffiene
        }
        
    }
    
}
