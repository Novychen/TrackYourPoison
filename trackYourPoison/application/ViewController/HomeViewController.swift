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
