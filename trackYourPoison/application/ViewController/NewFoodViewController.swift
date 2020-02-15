//
//  NewFoodViewController.swift
//  trackYourPoison
//
//  Created by Yvonne on 14.01.20.
//  Copyright © 2020 Ines&Yvonne. All rights reserved.
//

import UIKit
import CoreData

class NewFoodViewController : UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    let categories = ["softdrink", "coffee", "sweets", "alcohol", "tea"]
    var chosenCategory = 0
    var imageTitle : String = ""
    var defaultImage = true
    @IBOutlet weak var categoryButton: UIButton!
    
    @IBOutlet weak var size: UISegmentedControl!
    @IBOutlet weak var nameLabel: UITextField!
    @IBOutlet weak var categoryTable: UITableView!
    @IBOutlet weak var appImage: UIButton!
    @IBOutlet weak var camera: UIButton!
    
    @IBAction func pickeddefaultImage(_ sender: Any) {
        defaultImage = true
        appImage.setBackgroundImage(UIImage(named: "card_selected.png"), for: .normal)
        camera.setBackgroundImage(UIImage(named: "card.png"), for: .normal)
    }
    
    
    @IBAction func pickedUserImage(_ sender: Any) {
        defaultImage = false
        appImage.setBackgroundImage(UIImage(named: "card.png"), for: .normal)
        camera.setBackgroundImage(UIImage(named: "card_selected.png"), for: .normal)

        let image = UIImagePickerController()
        image.delegate = self
        image.sourceType = UIImagePickerController.SourceType.photoLibrary
        image.allowsEditing = false
        self.present(image, animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            camera.setBackgroundImage(image, for: .normal)
        } else {
            let alert = UIAlertController(title: "Error", message: "There seems to be a problem with this image. Please pick another one", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
            self.present(alert, animated: true)
        }
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func save(_ sender: Any) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
    
        let food = NSEntityDescription.insertNewObject(forEntityName: "Food", into: context) as! Food
        if nameLabel.text == "" {
            nameLabel.text = "food"
        }
        food.name = nameLabel.text
        food.alcohol = 0
        food.sugar = 0
        food.coffeine = 0
        if defaultImage {
            food.image = imageTitle
        }
        food.kcal = 0
        food.type = categories[chosenCategory]
        
        if size.selectedSegmentIndex == 0 {
            food.size = "ml"
        } else {
            food.size = "g"
        }
        
        appDelegate.saveContext()
        navigationController?.popViewController(animated: true)
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func choseCategory(_ sender: Any) {
        categoryTable.isHidden = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.categoryTable.isHidden = true
        
        appImage.setBackgroundImage(UIImage(named: "card_selected.png"), for: .normal)
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
            imageTitle = "softdrink.png"
        } else if chosenCategory == 1 {
            appImage.setBackgroundImage( UIImage(named: "coffee.png"), for: .normal)
            imageTitle = "coffee.png"
        } else if chosenCategory == 2 {
            appImage.setBackgroundImage( UIImage(named: "sweets.png"), for: .normal)
            imageTitle = "sweets.png"
        } else if chosenCategory == 3 {
            appImage.setBackgroundImage( UIImage(named: "alcohol.png"), for: .normal)
            imageTitle = "alcohol.png"
        } else if chosenCategory == 4 {
            appImage.setBackgroundImage( UIImage(named: "tea.png"), for: .normal)
            imageTitle = "tea.png"
        }
        categoryButton.setTitle(categories[chosenCategory], for: .normal)
        self.categoryTable.isHidden = true
    }
    
}
