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
    
    var food : [Food] = []
    var selectedFood : [Food] = []
    var softdrinkList : [Food] = []
    var coffeeList : [Food] = []
    var sweetsList : [Food] = []
    var alcoholList : [Food] = []
    var teaList : [Food] = []

    var foodChosen : Int = 0
    var foodOptions = ["softdrink", "coffee", "sweets", "alcohol", "tea"]
    
    final let SOFTDRINK = 0
    final let CAFFEE = 1
    final let SWEETS = 2
    final let ALCOHOL = 3
    final let TEA = 4
    
    @IBOutlet weak var foodChoice: UIButton!
    @IBOutlet weak var foodList: UICollectionView!
    @IBOutlet weak var foodOptionTable: UITableView!
    @IBOutlet weak var saveButton: UIBarButtonItem!
  
    @IBAction func foodChosen(_ sender: Any) {
        self.foodOptionTable.isHidden = false
    }
    
    @IBAction func diselectAll(_ sender: Any) {
        for x in selectedFood {
            x.selected = false
        }
        selectedFood.removeAll()
        foodList.reloadData()
    }
    
    @IBAction func deleteFood(_ sender: Any) {
        
        // Alert Dialog
        if selectedFood.isEmpty {
            let alert = UIAlertController(title: "Warning", message: "There is no data selected", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
            self.present(alert, animated: true)
        } else {
            let alert = UIAlertController(title: "About to delete data", message: "Are you sure you want to delete this data permanently?", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: nil))
            alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { action in self.deleteData() }))
            self.present(alert, animated: true)
        }
    }
    
    @IBAction func saveFood(_ sender: Any) {
        self.performSegue(withIdentifier: "SizeSegue", sender: self)
    }
    
    func deleteData() {
        // Removing the selected Cells
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<Food>(entityName: "Food")
        if let items = try? context.fetch(request) {
            for x in items.enumerated() {
                for y in selectedFood.enumerated() {
                    if x.element.name == y.element.name {
                        context.delete(x.element)
                        selectedFood.remove(at: y.offset)
                        food.remove(at: x.offset)
                        appDelegate.saveContext()
                    }
                }
            }
        }
        selectedFood.removeAll()
        softdrinkList.removeAll()
        coffeeList.removeAll()
        sweetsList.removeAll()
        alcoholList.removeAll()
        teaList.removeAll()
        
        for x in food.enumerated() {
            if x.element.type == "softdrink" { softdrinkList.append(x.element) }
            else if x.element.type == "coffee" { coffeeList.append(x.element) }
            else if x.element.type == "sweets" { sweetsList.append(x.element) }
            else if x.element.type == "tea" { teaList.append(x.element) }
            else if x.element.type == "alcohol" { alcoholList.append(x.element) }
        }
        foodList.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "SizeSegue" {
            if let detailsVC = segue.destination as? SizeViewController {
                    detailsVC.chosenFood = selectedFood
            }
        }
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        deleteAll()
        foodList.allowsMultipleSelection = true
        requestData()
        foodList.reloadData()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        deleteAll()
        
    }
    
    func deleteAll() {
        food.removeAll()
        for x in selectedFood {
            x.selected = false
        }
        selectedFood.removeAll()
        softdrinkList.removeAll()
        coffeeList.removeAll()
        sweetsList.removeAll()
        alcoholList.removeAll()
        teaList.removeAll()
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

        let request = NSFetchRequest<Food>(entityName: "Food")
        let sortDescriptor = NSSortDescriptor(key: "name", ascending: true)
        request.sortDescriptors = [sortDescriptor]
        if let data = try? context.fetch(request){
            self.food = data
        }
        
        for x in food.enumerated() {
            if x.element.type == "softdrink" { softdrinkList.append(x.element) }
            else if x.element.type == "coffee" { coffeeList.append(x.element) }
            else if x.element.type == "sweets" { sweetsList.append(x.element) }
            else if x.element.type == "tea" { teaList.append(x.element) }
            else if x.element.type == "alcohol" { alcoholList.append(x.element) }
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
        if(foodChosen != indexPath.row){
            foodChosen = indexPath.row
            foodList.reloadData()
        }
        self.foodOptionTable.isHidden = true
    }
    
}

extension AddFoodViewController: UICollectionViewDelegate{}

extension AddFoodViewController: UICollectionViewDataSource {
    

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = setFoodCell(indexPath: indexPath, collectionView: collectionView)
        return cell
    }

   
    func collectionView(_ collectionView: UICollectionView, didHighlightItemAt indexPath: IndexPath) {
        var cell = foodList.cellForItem(at: indexPath) as! FoodCell
        cell = setSelected(cell: cell, indexPath: indexPath)
    }
    
    /*
     * Sets the "selected" status for each category 
     */
    func setSelected(cell : FoodCell, indexPath : IndexPath) -> FoodCell{
        
        switch foodChosen {
            case SOFTDRINK:
                let drink = softdrinkList[indexPath.row]
                if !drink.selected {
                    drink.selected = true
                    cell.backgroundView = UIImageView(image: UIImage(named: "card_selected.png"))
                    selectedFood.append(drink)
                } else {
                    drink.selected = false
                    cell.backgroundView = UIImageView(image: UIImage(named: "card.png"))
                    if let index = selectedFood.firstIndex(of: drink) {
                        selectedFood.remove(at: index)
                    }
                }
            case CAFFEE:
                let coffee = coffeeList[indexPath.row]
                if !coffee.selected {
                    coffee.selected = true
                    cell.backgroundView = UIImageView(image: UIImage(named: "card_selected.png"))
                    selectedFood.append(coffee)
                } else {
                    coffee.selected = false
                    cell.backgroundView = UIImageView(image: UIImage(named: "card.png"))
                    if let index = selectedFood.firstIndex(of: coffee) {
                       selectedFood.remove(at: index)
                    }
                    print(coffee.image)
                }
            case SWEETS:
                let sweets = sweetsList[indexPath.row]
                if !sweets.selected {
                    sweets.selected = true
                    cell.backgroundView = UIImageView(image: UIImage(named: "card_selected.png"))
                    selectedFood.append(sweets)
                } else {
                    sweets.selected = false
                    cell.backgroundView = UIImageView(image: UIImage(named: "card.png"))
                    if let index = selectedFood.firstIndex(of: sweets) {
                       selectedFood.remove(at: index)
                    }
                }
            case ALCOHOL:
                let alcohol = alcoholList[indexPath.row]
                if !alcohol.selected {
                    alcohol.selected = true
                    cell.backgroundView = UIImageView(image: UIImage(named: "card_selected.png"))
                    selectedFood.append(alcohol)
                } else {
                    alcohol.selected = false
                    cell.backgroundView = UIImageView(image: UIImage(named: "card.png"))
                    if let index = selectedFood.firstIndex(of: alcohol) {
                        selectedFood.remove(at: index)
                    }
                }
            case TEA:
                let tea = teaList[indexPath.row]
                if !tea.selected {
                    tea.selected = true
                    cell.backgroundView = UIImageView(image: UIImage(named: "card_selected.png"))
                    selectedFood.append(tea)
                } else {
                    tea.selected = false
                    cell.backgroundView = UIImageView(image: UIImage(named: "card.png"))
                    if let index = selectedFood.firstIndex(of: tea) {
                       selectedFood.remove(at: index)
                    }
                }
            default:
                print("Unkown type")
            }
        return cell
    }

    /*
     * Returns the number of cells that will be displayed (changes as the category changes)
     */
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            switch foodChosen {
                case SOFTDRINK:
                    return softdrinkList.count
                case CAFFEE:
                    return coffeeList.count
                case SWEETS:
                    return sweetsList.count
                case ALCOHOL:
                    return alcoholList.count
                case TEA:
                    return teaList.count
                default:
                    return 0
            }
    }

    /*
     * Sets up a FoodCell and choose the coresponding content
     */
    func setFoodCell(indexPath : IndexPath, collectionView: UICollectionView) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FoodCell", for: indexPath) as! FoodCell
        if foodChosen == 0 { setDrinkCell(cell: cell, indexPath: indexPath) }
        else if foodChosen == 1 { setCoffeeCell(cell: cell, indexPath: indexPath) }
        else if foodChosen == 2 { setSweetsCell(cell: cell, indexPath: indexPath) }
        
        cell.foodInfo.numberOfLines = 0
        cell.foodName.numberOfLines = 0
        return cell
    }
    
   
    /*
     * Sets up a FoodCell with a SoftDrink
     */
    func setDrinkCell(cell : FoodCell, indexPath : IndexPath) {
        let drink = softdrinkList[indexPath.row]
        cell.foodName.text = drink.name
        let sugar = drink.sugar
        let coffeine = drink.coffeine
        let kcal = drink.kcal
        
        if sugar == 0 && coffeine != 0 {
            cell.foodInfo.text = "per 100 ml \(kcal) kcal with \(coffeine) mg coffeine"
        } else if sugar != 0 && coffeine != 0 {
            cell.foodInfo.text = "per 100 ml \(kcal) kcal with \(sugar) g sugar & \(coffeine) mg coffeine"
        } else if sugar != 0 && coffeine == 0 {
            cell.foodInfo.text = "per 100 ml \(kcal) kcal with \(sugar) g sugar"
        } else {
            cell.foodInfo.text = "per 100 ml \(kcal) kcal with no sugar"
        }
        if drink.selected {
            cell.backgroundView = UIImageView(image: UIImage(named: "card_selected.png"))
        } else {
            cell.backgroundView = UIImageView(image: UIImage(named: "card.png"))
        }
        cell.foodImage.image = UIImage(named: drink.image ?? " ")
    }
    
    /*
     * Sets up a FoodCell with a Coffee
     */
    func setCoffeeCell(cell : FoodCell, indexPath : IndexPath) {
        
        let drink = coffeeList[indexPath.row]
        cell.foodName.text = drink.name
        let sugar = drink.sugar
        let coffeine = drink.coffeine
        let kcal = drink.kcal

        if sugar == 0 && coffeine != 0 {
            cell.foodInfo.text = "per 100 ml \(kcal) kcal with \(coffeine) mg coffeine"
        } else if sugar != 0 && coffeine != 0{
            cell.foodInfo.text = "per 100 ml \(kcal) kcal with \(sugar) g sugar & \(coffeine) mg coffeine"
        } else if sugar != 0 && coffeine == 0 {
            cell.foodInfo.text = "per 100 ml \(kcal) kcal with \(sugar) g sugar"
        } else {
            cell.foodInfo.text = "per 100 ml \(kcal) kcal with no coffeine"
        }
        if drink.selected {
            cell.backgroundView = UIImageView(image: UIImage(named: "card_selected.png"))
        } else {
            cell.backgroundView = UIImageView(image: UIImage(named: "card.png"))
        }
        cell.foodImage.image = UIImage(named: drink.image ?? " ")
    }
    
    /*
     * Sets up a FoodCell with a Sweet
     */
    func setSweetsCell(cell : FoodCell, indexPath : IndexPath){
        let drink = sweetsList[indexPath.row]
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
        if drink.selected {
            cell.backgroundView = UIImageView(image: UIImage(named: "card_selected.png"))
        } else {
            cell.backgroundView = UIImageView(image: UIImage(named: "card.png"))
        }
        cell.foodImage.image = UIImage(named: drink.image ?? " ")
    }
}
