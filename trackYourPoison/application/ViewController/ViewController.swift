//
//  ViewController.swift
//  trackYourPoison
//
//  Created by Yvonne on 18.12.19.
//  Copyright © 2019 Ines&Yvonne. All rights reserved.
//

import UIKit

import CoreData
class ViewController: UIViewController {
   
    var pro : [Profil] = []
    @IBOutlet weak var nameText: UITextField!
    @IBOutlet weak var weightText: UITextField!
    @IBOutlet weak var ageText: UITextField!
    
    @IBOutlet weak var pillLabel: UILabel!
    @IBOutlet weak var pregnantLable: UILabel!
    
    @IBOutlet weak var smokerSegment: UISegmentedControl!
    @IBOutlet weak var pillSegment: UISegmentedControl!
    @IBOutlet weak var pregnantSegment: UISegmentedControl!
    @IBOutlet weak var genderSegment: UISegmentedControl!
    
    var smoker = false
    var pill = false
    var preg = false
    
    override func viewDidLoad() {
       super.viewDidLoad()
       self.setupHideKeyboardOnTap()
       let appDelegate = (UIApplication.shared.delegate as! AppDelegate)
       let context = appDelegate.persistentContainer.viewContext
       let request = NSFetchRequest<Profil>(entityName: "Profil")
        if let profil = try? context.fetch(request){
           pro = profil
       }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if !pro.isEmpty {
            setUserUp(profil: pro [0])
        }
    }

    func setUserUp(profil: Profil) {
        let user : Profil = pro[0]
       
        nameText.text = user.name
        weightText.text = "\(user.weight)"
        ageText.text = "\(user.age)"
        if user.gender != "male" {
            pregnantLable.isHidden = false
            pregnantSegment.isHidden = false
            pillLabel.isHidden = false
            pillSegment.isHidden = false
        } else {
            pregnantLable.isHidden = true
            pregnantSegment.isHidden = true
            pillLabel.isHidden = true
            pillSegment.isHidden = true
        }
    }
    
    @IBAction func done(_ sender: Any) {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let profil = Profil(context: context)
        
        if pro.isEmpty{
            profil.name = nameText.text
            profil.nikotin = smoker
            profil.pill = pill
            profil.pregnent = preg
            let pickedGender = genderSegment.selectedSegmentIndex
            if pickedGender == 0 {
                profil.gender = "female"
            }else if pickedGender == 1 {
                profil.gender = "male"
            }else{
                profil.gender = "unknown"
            }
            profil.age = Int64(ageText.text ?? " ") ?? 0
            profil.weight = Double(weightText.text!) ?? 0
            appDelegate.saveContext()
        } else {
            pro[0].name = nameText.text
            pro[0].age = Int64(ageText.text ?? "0") ?? 0
            pro[0].weight = Double(weightText.text ?? "0") ?? 0
            pro[0].nikotin = smoker
            pro[0].pill = pill
            pro[0].pregnent = preg
            let pickedGender = genderSegment.selectedSegmentIndex
            if pickedGender == 0 {
                pro[0].gender = "female"
            }else if pickedGender == 1 {
                pro[0].gender = "male"
            }else{
                pro[0].gender = "unknown"
            }
            appDelegate.saveContext()
        }
        navigationController?.popViewController(animated: true)
    }
    @IBAction func segmentTouched(_ sender: UISegmentedControl) {
         let x = sender.tag
        switch x{
            case 0:
                if !smoker { smoker = true }
                else { smoker = false }
            case 1:
                if !pill { pill = true }
                else { pill = false }
            case 2:
                if !preg { preg = true }
                else { preg = false }
            case 3 :
                if genderSegment.selectedSegmentIndex != 1 {
                    pregnantLable.isHidden = false
                    pregnantSegment.isHidden = false
                    pillLabel.isHidden = false
                    pillSegment.isHidden = false
                } else {
                    pregnantLable.isHidden = true
                    pregnantSegment.isHidden = true
                    pillLabel.isHidden = true
                    pillSegment.isHidden = true
                    pill = false
                    preg = false
            }
            default : print("Unknown Segment")
        }
        
    }
    
}

extension ViewController {
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

