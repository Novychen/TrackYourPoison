//
//  AddFoodViewController.swift
//  trackYourPoison
//
//  Created by Yvonne on 14.01.20.
//  Copyright © 2020 Ines&Yvonne. All rights reserved.
//

import UIKit
import CoreData

class AddFoodViewController : UIViewController {
    
    var softdrinks : [SoftDrink] = []
    var food : Food = Food()
    var foodChosen : Int = 0

    var foodOptions = ["softdrink", "coffee", "sweets", "alcohol", "tea"]
    
    @IBOutlet weak var foodChoice: UIButton!
    @IBOutlet weak var foodList: UICollectionView!
    @IBOutlet weak var foodOptionTable: UITableView!
    
    @IBAction func foodChosen(_ sender: Any) {
        self.foodOptionTable.isHidden = false
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        requestData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        foodList.delegate = self
        foodList.dataSource = self
        
        foodOptionTable.delegate = self
        foodOptionTable.dataSource = self
    }
    
    func requestData() {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        switch foodChosen {
        case 0:
            let request = NSFetchRequest<SoftDrink>(entityName: "SoftDrink")
            if let data = try? context.fetch(request){
                self.food.softdrinks = data
            }
        case 1:
            let request = NSFetchRequest<Coffee>(entityName: "Coffee")
            if let data = try? context.fetch(request){
                self.food.coffee = data
            }
        case 2:
            let request = NSFetchRequest<Sweets>(entityName: "Sweets")
            if let data = try? context.fetch(request){
                self.food.sweets = data
            }
        case 3:
            let request = NSFetchRequest<Alcohol>(entityName: "Alcohol")
            if let data = try? context.fetch(request){
                self.food.alcohol = data
            }
        case 4:
            let request = NSFetchRequest<Tea>(entityName: "Tea")
            if let data = try? context.fetch(request){
                self.food.tea = data
            }
        default:
            print("No such entity available")
        }
    }
}

extension AddFoodViewController: UITableViewDelegate{}
extension AddFoodViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return foodOptions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let food = foodOptions[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "foodOptionCell", for: indexPath)
        cell.textLabel?.text = food
        return cell
    }
    
    func tableView(_ tableView: UITableView, didHighlightRowAt indexPath: IndexPath) {
        let cell = foodOptionTable.cellForRow(at: indexPath)
        foodChoice.setTitle(cell?.textLabel?.text, for: .normal)
        foodChosen = indexPath.row
        requestData()
        self.foodOptionTable.isHidden = true
    }
    
}

extension AddFoodViewController: UICollectionViewDelegate{}

extension AddFoodViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = setFoodCell(indexPath: indexPath, collectionView: collectionView)
        cell.backgroundView = UIImageView(image: UIImage(named: "card.png"))
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch foodChosen {
        case 0:
            return food.softdrinks.count
        case 1:
            return food.coffee.count
        case 2:
            return food.sweets.count
        case 3:
            return food.alcohol.count
        case 4:
            return food.tea.count
        default:
            return 0
        }
    }

    func setFoodCell(indexPath : IndexPath, collectionView: UICollectionView) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FoodCell", for: indexPath) as! FoodCell
        if(foodChosen == 0) { setDrinkCell(cell: cell, indexPath: indexPath) }
        else if (foodChosen == 1) { setCoffeeCell(cell: cell, indexPath: indexPath) }
        else if (foodChosen == 2) { setSweetsCell(cell: cell, indexPath: indexPath) }

        cell.foodInfo.numberOfLines = 0
        cell.foodName.numberOfLines = 0
        cell.foodImage.image = UIImage(named:"drink_coca_cola_zero")
        return cell
    }
    
    func setDrinkCell(cell : FoodCell, indexPath : IndexPath) {
        let drink = food.softdrinks[indexPath.row]
        cell.foodName.text = drink.name
        let sugar = drink.sugar
        let coffeine = drink.coffeine
        let kcal = drink.kcal
        
        if(sugar == 0 && coffeine != 0){
            cell.foodInfo.text = "per 100 ml \(kcal) kcal with \(coffeine) mg coffeine"
        } else if (sugar != 0 && coffeine != 0){
            cell.foodInfo.text = "per 100 ml \(kcal) kcal with \(sugar) g sugar & \(coffeine) mg coffeine"
        } else if (sugar != 0 && coffeine == 0) {
            cell.foodInfo.text = "per 100 ml \(kcal) kcal with \(sugar) g sugar"
        } else {
            cell.foodInfo.text = "per 100 ml \(kcal) kcal with no sugar"
        }
    }
    
    func setCoffeeCell(cell : FoodCell, indexPath : IndexPath) {
        let drink = food.coffee[indexPath.row]
        cell.foodName.text = drink.name
        let sugar = drink.sugar
        let coffeine = drink.coffeine
        let kcal = drink.kcal
        
        if(sugar == 0 && coffeine != 0){
            cell.foodInfo.text = "per 100 ml \(kcal) kcal with \(coffeine) mg coffeine"
        } else if (sugar != 0 && coffeine != 0){
            cell.foodInfo.text = "per 100 ml \(kcal) kcal with \(sugar) g sugar & \(coffeine) mg coffeine"
        } else if (sugar != 0 && coffeine == 0) {
            cell.foodInfo.text = "per 100 ml \(kcal) kcal with \(sugar) g sugar"
        } else {
            cell.foodInfo.text = "per 100 ml \(kcal) kcal with no coffeine"
        }
    }
    
    func setSweetsCell(cell : FoodCell, indexPath : IndexPath){
        let drink = food.sweets[indexPath.row]
        cell.foodName.text = drink.name
        let sugar = drink.sugar
        let coffeine = drink.coffeine
        let kcal = drink.kcal
        
        if(sugar == 0 && coffeine != 0){
            cell.foodInfo.text = "per 100 g \(kcal) kcal with \(coffeine) mg coffeine"
        } else if (sugar != 0 && coffeine != 0){
            cell.foodInfo.text = "per 100 g \(kcal) kcal with \(sugar) g sugar & \(coffeine) mg coffeine"
        } else if (sugar != 0 && coffeine == 0) {
            cell.foodInfo.text = "per 100 g \(kcal) kcal with \(sugar) g sugar"
        } else {
            cell.foodInfo.text = "per 100 g \(kcal) kcal with no sugar"
        }
    }
    
}
