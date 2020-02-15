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

    
    @IBOutlet weak var maleButton: UIButton!
    @IBOutlet weak var femaleButton: UIButton!
    
    @IBOutlet weak var pillLabel: UILabel!
    
    @IBOutlet weak var pregnantLable: UILabel!
    
    @IBOutlet weak var smokerSegment: UISegmentedControl!
    @IBOutlet weak var pillSegment: UISegmentedControl!
    @IBOutlet weak var pregnantSegmet: UISegmentedControl!
    
    
    
    var smoker  = false
    var male = false
    var female = false
    var pill  = false
    var preg = false
    override func viewDidLoad() {
        super.viewDidLoad()
        let appDelegate = (UIApplication.shared.delegate as! AppDelegate)
               let context = appDelegate.persistentContainer.viewContext
               let request = NSFetchRequest<Profil>(entityName: "Profil")
                if let profil = try? context.fetch(request){
                   pro = profil
               }

    }

   
    @IBAction func done(_ sender: Any) {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let profil = Profil(context: context)
        
        if pro.isEmpty{
            profil.name = nameText.text
                 print("name : \(profil.name)")
                 profil.nikotin = smoker
                 print("smoker : \(profil.nikotin)")
                 profil.pill = pill
                 print("pill : \(profil.pill)")
                 profil.pregnent = preg
                 print("preg : \(profil.pregnent)")
                 if(male){
                     profil.gender = "male"
                 }else if(female){
                     profil.gender = "female"
                 }else{
                     profil.gender = "unknown"
                 }
                 print("gender : \(profil.gender)")
                 profil.age = Int64(ageText.text ?? " ") ?? 0
                 print("age : \(profil.age)")
                 profil.weight = Double(weightText.text!) ?? 0
                 print("weight : \(profil.weight)")
                 print("Data Saved")
                
                 appDelegate.saveContext()
                 navigationController?.popViewController(animated: true)
        }else{
           
            pro[0].name = nameText.text
            print("name : \(pro[0].name )")
            pro[0].nikotin = smoker
            print("smoker : \(pro[0].nikotin)")
            pro[0].pill = pill
            print("pill : \(pro[0].pill)")
            pro[0].pregnent = preg
            print("preg : \(pro[0].pregnent)")
            if(male){
                pro[0].gender = "male"
            }else if(female){
                pro[0].gender = "female"
            }else{
                pro[0].gender = "unknown"
            }
            print("gender : \(pro[0].gender)")
            pro[0].age = Int64(ageText.text ?? " ") ?? 0
            print("age : \(pro[0].age)")
            pro[0].weight = Double(weightText.text!) ?? 0
            print("weight : \(pro[0].weight)")
            print("Data Saved")
            appDelegate.saveContext()
            navigationController?.popViewController(animated: true)
        }
     
    }
    @IBAction func segmentTouched(_ sender: UISegmentedControl) {
         let x = sender.tag
        switch x{
        case 0: if (!smoker){smoker = true
        }else{
            smoker = false
        }
        case 1:
            if(!pill){ pill = true
            }else{
                pill = false
            }
        case 2:
            if (!preg){preg = true
            }else{
                preg = false
            }
        default : print("Unknown Segment")
        }
        
    }
    
    @IBAction func buttonTouchded(_ sender: UIButton) {
        let x = sender.tag
        switch x{
        case 2:print("male")
            if(!male && !female){
                print("male")
                male = true
                pillLabel.isHidden = true
                pillLabel.isHidden = true
   
                pillSegment.isHidden = true
                pregnantSegmet.isHidden = true
                pillSegment.isEnabled = false
                pregnantSegmet.isEnabled = false
                
                
            }else if(!male && female){
                male = true
                female = false
                pillLabel.isHidden = true
                pregnantLable.isHidden = true

                
                pillSegment.isHidden = true
                pregnantSegmet.isHidden = true
                pillSegment.isEnabled = false
                pregnantSegmet.isEnabled = false
            }
        case 3:print("female")
            if(!male && !female){
                female = true
                pillLabel.isHidden = false
                pregnantLable.isHidden = false

                pillSegment.isHidden = false
                pregnantSegmet.isHidden = false
                pillSegment.isEnabled = true
                pregnantSegmet.isEnabled = true
                
                
                
        }else if(male && !female){
                female = true
                pillLabel.isHidden = false
                pregnantLable.isHidden = false

                male = false
                pillSegment.isHidden = false
                pregnantSegmet.isHidden = false
                pillSegment.isEnabled = true
                pregnantSegmet.isEnabled = true
        }
   
            
        default:
        print("no button")
            
        }
    }
    
   
}

