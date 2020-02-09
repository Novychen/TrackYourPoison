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
    var timer : Timer?
    var timealc = 10000.0
    var timecof = 20000.0
    
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
         timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
        
       }
    
    func saveData(context : NSManagedObjectContext) {
        let drinkEntity = NSEntityDescription.entity(forEntityName: "SoftDrink", in: context)
        let sweetsEntity = NSEntityDescription.entity(forEntityName: "Sweets", in: context)
        let coffeeEntity = NSEntityDescription.entity(forEntityName: "Coffee", in: context)
        let alcoholEntity = NSEntityDescription.entity(forEntityName: "Alcohol", in: context)
        let teaEntity = NSEntityDescription.entity(forEntityName: "Tea", in: context)

        let drinks = SoftDrinkData()
        let sweets = SweetsData()
        let coffee = CoffeeData()
        
        var name = drinks.getName()
        var coffeine = drinks.getCoffeine()
        var sugar = drinks.getSugar()
        var alcohol = drinks.getAlcohol()
        var size = drinks.getSize()
        var kcal = drinks.getKcal()
        
        for (index, _) in name.enumerated(){
            let food = NSManagedObject(entity: drinkEntity!, insertInto: context)
            food.setValue(name[index], forKey: "name")
            food.setValue(sugar[index], forKey: "sugar")
            food.setValue(coffeine[index], forKey: "coffeine")
            food.setValue(alcohol[index], forKey: "alcohol")
            food.setValue(size[index], forKey: "sizesAvailable")
            food.setValue(kcal[index], forKey: "kcal")
        }
        
        do {
            try context.save()
            print("saved data")
        } catch let error as NSError { print("Could not save. \(error), \(error.userInfo)") }
        
        
        name = sweets.getName()
        coffeine = sweets.getCoffeine()
        sugar = sweets.getSugar()
        alcohol = sweets.getAlcohol()
        size = sweets.getSize()
        kcal = sweets.getKcal()
        
        for (index, _) in name.enumerated(){
            let food = NSManagedObject(entity: sweetsEntity!, insertInto: context)
            food.setValue(name[index], forKey: "name")
            food.setValue(sugar[index], forKey: "sugar")
            food.setValue(coffeine[index], forKey: "coffeine")
            food.setValue(alcohol[index], forKey: "alcohol")
            food.setValue(size[index], forKey: "sizesAvailable")
            food.setValue(kcal[index], forKey: "kcal")
        }
        do {
            try context.save()
            print("saved data")
        } catch let error as NSError { print("Could not save. \(error), \(error.userInfo)") }
        
        coffeine = coffee.getCoffeine()
        sugar = coffee.getSugar()
        alcohol = coffee.getAlcohol()
        size = coffee.getSize()
        kcal = coffee.getKcal()
        
        for (index, _) in name.enumerated(){
            let food = NSManagedObject(entity: coffeeEntity!, insertInto: context)
            food.setValue(name[index], forKey: "name")
            food.setValue(sugar[index], forKey: "sugar")
            food.setValue(coffeine[index], forKey: "coffeine")
            food.setValue(alcohol[index], forKey: "alcohol")
            food.setValue(size[index], forKey: "sizesAvailable")
            food.setValue(kcal[index], forKey: "kcal")
        }
        
        do {
            try context.save()
            print("saved data")
        } catch let error as NSError { print("Could not save. \(error), \(error.userInfo)") }
    
       }
    
    /*timer to string*/
    func timeString(time:TimeInterval) -> String {
        let hours = Int(time) / 3600
        let minutes = Int(time) / 60 % 60
        let seconds = Int(time) % 60
        return String("\(hours):\(minutes):\(seconds)" )
    }
    @objc func updateTimer(){
        timealc -= 1
        timecof -= 1
        alcoholTimer.text = timeString(time: timealc)
        coffeineTimer.text = timeString(time: timecof)
    }
}
