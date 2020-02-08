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

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        let defaults = UserDefaults.standard
        let start = defaults.integer(forKey: AppDelegate.appStartCount)
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        //if (start == 1) {
        saveData(context : context)
        
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
            food.setValue(size[index], forKey: "size")
            food.setValue(kcal[index], forKey: "kcal")
        }
        
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
            food.setValue(size[index], forKey: "size")
            food.setValue(kcal[index], forKey: "kcal")
        }
        
        
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
            food.setValue(size[index], forKey: "size")
            food.setValue(kcal[index], forKey: "kcal")
        }
        
        do {
            try context.save()
            print("saved: \(drinks)")
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    
}
