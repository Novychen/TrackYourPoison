//
//  SizeViewController.swift
//  trackYourPoison
//
//  Created by Yvonne on 09.02.20.
//  Copyright © 2020 Ines&Yvonne. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class SizeViewController : UIViewController {
    
    var chosenFood : [Food] = []
   
    @IBOutlet weak var sizePopupView: UIView!
    @IBOutlet weak var sizeTable : UITableView!
   
    @IBAction func cancelButton(_ sender: Any) {
        navigationController?.popViewController(animated: true)
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func saveButton(_ sender: Any) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let date = Date()
        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: date)
        var time : String = ""
        if hour > 10 && hour < 14 {
            time = "noon"
        } else if hour > 13 {
            time = "evening"
        } else if hour < 11 {
            time = "morning"
        }
        
        for item in chosenFood.enumerated() {
            let food = NSEntityDescription.insertNewObject(forEntityName: "Consumed", into: context) as! Consumed
            food.food = item.element
            food.time = time
        }
        appDelegate.saveContext()
        
        navigationController?.popViewController(animated: true)
        dismiss(animated: true, completion: nil)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sizePopupView.layer.cornerRadius = 20
        sizePopupView.layer.masksToBounds = true

        sizeTable.layer.cornerRadius = 10
        sizeTable.layer.masksToBounds = true
        
        sizeTable.delegate = self
        sizeTable.dataSource = self
        
        self.setupHideKeyboardOnTap()
    }
}

extension SizeViewController: UITableViewDelegate{}
extension SizeViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return chosenFood.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SizeCell", for: indexPath) as! SizeCell
        cell.foodImage.image = UIImage(named: chosenFood[indexPath.row].image ?? " ")
        cell.foodName.text = chosenFood[indexPath.row].name
        
        let sizeOptions = chosenFood[indexPath.row].sizesAvailable as! [String]
        cell.sizeLabel.text = sizeOptions[0]
        
        return cell
    }
}

extension SizeViewController {
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
