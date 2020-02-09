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
        
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
        
        //if (start == 1) {
            let drinkEntity = NSEntityDescription.entity(forEntityName: "SoftDrink", in: context)

            let drinks = SoftDrinkData()
            let name = drinks.getName()
            let coffeine = drinks.getCoffeine()
            let sugar = drinks.getSugar()
            let alcohol = drinks.getAlcohol()
            let size = drinks.getSize()
            let kcal = drinks.getKcal()
          
            
            
            for (index, _) in name.enumerated(){
                let drink = NSManagedObject(entity: drinkEntity!, insertInto: context)
                drink.setValue(name[index], forKey: "name")
                drink.setValue(sugar[index], forKey: "sugar")
                drink.setValue(coffeine[index], forKey: "coffeine")
                drink.setValue(alcohol[index], forKey: "alcohol")
                drink.setValue(size[index], forKey: "size")
                drink.setValue(kcal[index], forKey: "kcal")
            }
            do {
                try context.save()
                print("saved: \(drinks)")
            } catch let error as NSError {
                print("Could not save. \(error), \(error.userInfo)")
            }
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
