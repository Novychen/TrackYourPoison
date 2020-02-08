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
    var foodOptions = ["softdrink", "coffee", "sweets", "alcohol", "tea"]

    @IBOutlet weak var foodChoice: UIButton!
    @IBOutlet weak var foodList: UICollectionView!
    @IBOutlet weak var foodOptionTable: UITableView!
    
    @IBAction func foodChosen(_ sender: Any) {
        self.foodOptionTable.isHidden = false
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<SoftDrink>(entityName: "SoftDrink")
        if let data = try? context.fetch(request){
            self.softdrinks = data
            print(softdrinks)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        foodList.delegate = self
        foodList.dataSource = self
        
        foodOptionTable.delegate = self
        foodOptionTable.dataSource = self
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
        self.foodOptionTable.isHidden = true
    }
    
}

extension AddFoodViewController: UICollectionViewDelegate{}

extension AddFoodViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = softDrinkCell(indexPath: indexPath, collectionView: collectionView)
        
        cell.backgroundView = UIImageView(image: UIImage(named: "card.png"))
        return cell
    }
   
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return softdrinks.count
    }
    
    func softDrinkCell(indexPath : IndexPath, collectionView: UICollectionView) -> UICollectionViewCell {
        let drink = softdrinks[indexPath.row]

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DrinkCell", for: indexPath) as! DrinkCell
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
        cell.foodInfo.numberOfLines = 0
        cell.foodImage.image = UIImage(named:"drink_coca_cola_zero")
        return cell
    }
}

