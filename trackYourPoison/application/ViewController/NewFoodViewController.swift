//
//  NewFoodViewController.swift
//  trackYourPoison
//
//  Created by Yvonne on 14.01.20.
//  Copyright © 2020 Ines&Yvonne. All rights reserved.
//

import UIKit

class NewFoodViewController : UIViewController {
    
    let categories = ["softdrink", "coffee", "sweets", "alcohol", "tea"]
    var chosenCategory = 0
    
    @IBOutlet weak var categoryButton: UIButton!
    
    @IBOutlet weak var size: UISegmentedControl!
    @IBOutlet weak var nameLabel: UITextField!
    @IBOutlet weak var categoryTable: UITableView!
    @IBOutlet weak var appImage: UIButton!
    @IBOutlet weak var camera: UIButton!
    
    @IBAction func choseCategory(_ sender: Any) {
        categoryTable.isHidden = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
         self.categoryTable.isHidden = true
        
        categoryTable.delegate = self
        categoryTable.dataSource = self
    }
}

extension NewFoodViewController: UITableViewDelegate{}
extension NewFoodViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let category = categories[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        cell.textLabel?.text = category
        return cell
    }
    
    func tableView(_ tableView: UITableView, didHighlightRowAt indexPath: IndexPath) {
        if(chosenCategory != indexPath.row){
            chosenCategory = indexPath.row
        }
        if chosenCategory == 0 {
            appImage.setBackgroundImage( UIImage(named: "softdrink.png"), for: .normal)
        } else if chosenCategory == 1 {
            appImage.setBackgroundImage( UIImage(named: "coffee.png"), for: .normal)
        } else if chosenCategory == 2 {
            appImage.setBackgroundImage( UIImage(named: "sweets.png"), for: .normal)
        } else if chosenCategory == 3 {
            appImage.setBackgroundImage( UIImage(named: "alcohol.png"), for: .normal)
        } else if chosenCategory == 4 {
            appImage.setBackgroundImage( UIImage(named: "tea.png"), for: .normal)
        }
        categoryButton.setTitle(categories[chosenCategory], for: .normal)
        self.categoryTable.isHidden = true
    }
    
}
