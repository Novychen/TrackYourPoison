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
    
    @IBOutlet weak var sugarLabel: UILabel!
    @IBOutlet weak var alcoholLabel: UILabel!
    @IBOutlet weak var coffeineLabel: UILabel!
    @IBOutlet weak var kcalLabel: UILabel!
    
    
    @IBOutlet weak var kcalTextField: UITextField!
    @IBOutlet weak var sugarTextField: UITextField!
    @IBOutlet weak var alcoholTextField: UITextField!
    @IBOutlet weak var coffeineTextField: UITextField!
    
    @IBOutlet weak var size: UISegmentedControl!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var categoryTable: UITableView!
    @IBOutlet weak var defaultImageButton: UIButton!
    @IBOutlet weak var userImageButton: UIButton!
    
    @IBAction func pickeddefaultImage(_ sender: Any) {
        defaultImage = true
        defaultImageButton.setImage(UIImage(named: "Image_selected.png"), for: .normal)
        userImageButton.setImage(UIImage(named: "Image.png"), for: .normal)
    }
    
    
    @IBAction func pickedUserImage(_ sender: Any) {
        defaultImage = false
        defaultImageButton.setImage(UIImage(named: "Image.png"), for: .normal)
        userImageButton.setImage(UIImage(named: "Image_selected.png"), for: .normal)

        let image = UIImagePickerController()
        image.delegate = self
        image.sourceType = UIImagePickerController.SourceType.photoLibrary
        image.allowsEditing = false
        self.present(image, animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            userImageButton.setBackgroundImage(image, for: .normal)
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
        if nameTextField.text == "" {
            nameTextField.text = "food"
        }
        food.name = nameTextField.text
        food.alcohol = Double(alcoholTextField.text ?? "0") ?? 0
        food.sugar = Double(sugarTextField.text ?? "0") ?? 0
        food.coffeine = Double(coffeineTextField.text ?? "0") ?? 0
        food.kcal = Int32(kcalTextField.text ?? "0") ?? 0

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
    
    @IBAction func pickedSize(_ sender: Any) {
        
        if size.selectedSegmentIndex == 0 {
            sugarLabel.text = "in g per 100 ml"
            alcoholLabel.text = "in % per 100 ml"
            coffeineLabel.text = "in mg per 100 ml"
            kcalLabel.text = "per 100 ml"
        } else {
            sugarLabel.text = "in g per 100 g"
            alcoholLabel.text = "in % per 100 g"
            coffeineLabel.text = "in mg per 100 g"
            kcalLabel.text = "per 100 g"
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.categoryTable.isHidden = true
        
        defaultImageButton.setImage(UIImage(named: "Image_selected.png"), for: .normal)
        defaultImageButton.setBackgroundImage( UIImage(named: "softdrink.png"), for: .normal)

        categoryTable.delegate = self
        categoryTable.dataSource = self
        
        self.setupHideKeyboardOnTap()
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
        if defaultImage {
            if chosenCategory == 0 {
                defaultImageButton.setBackgroundImage( UIImage(named: "softdrink.png"), for: .normal)
                imageTitle = "softdrink.png"
            } else if chosenCategory == 1 {
                defaultImageButton.setBackgroundImage( UIImage(named: "coffee.png"), for: .normal)
                imageTitle = "coffee.png"
            } else if chosenCategory == 2 {
                defaultImageButton.setBackgroundImage( UIImage(named: "sweets.png"), for: .normal)
                imageTitle = "sweets.png"
            } else if chosenCategory == 3 {
                defaultImageButton.setBackgroundImage( UIImage(named: "alcohol.png"), for: .normal)
                imageTitle = "alcohol.png"
            } else if chosenCategory == 4 {
                defaultImageButton.setBackgroundImage( UIImage(named: "tea.png"), for: .normal)
                imageTitle = "tea.png"
            }
        }
        categoryButton.setTitle(categories[chosenCategory], for: .normal)
        self.categoryTable.isHidden = true
    }
    
}

extension NewFoodViewController {
    func setupHideKeyboardOnTap() {
        self.view.addGestureRecognizer(self.endEditingRecognizer())
        self.navigationController?.navigationBar.addGestureRecognizer(self.endEditingRecognizer())
    }
    
    private func endEditingRecognizer() -> UIGestureRecognizer {
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(self.view.endEditing(_:)))
        tap.cancelsTouchesInView = false
        return tap
    }
}
