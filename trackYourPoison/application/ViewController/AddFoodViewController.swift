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
    
    @IBAction func selectFood(_ sender: UIButton) {
    }
    @IBOutlet weak var foodList: UICollectionView!
    
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
    }
    
}

extension AddFoodViewController: UICollectionViewDelegate{}

extension AddFoodViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
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
        
        
        let View = UIView()
        View.backgroundColor=UIColor(patternImage:UIImage(named:"card.png")!)
        cell.backgroundView=View
        
        return cell
    }
   
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return softdrinks.count
    }
}

