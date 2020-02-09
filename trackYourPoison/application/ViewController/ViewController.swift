//
//  ViewController.swift
//  trackYourPoison
//
//  Created by Yvonne on 18.12.19.
//  Copyright © 2019 Ines&Yvonne. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var nameText: UITextField!
    @IBOutlet weak var weightText: UITextField!
    @IBOutlet weak var ageText: UITextField!
    
    @IBOutlet weak var smokerButton: UIButton!
    
    @IBOutlet weak var maleButton: UIButton!
    @IBOutlet weak var femaleButton: UIButton!
    
    @IBOutlet weak var pregnantButton: UIButton!
    @IBOutlet weak var pillButton: UIButton!
    
    var smoker  = false
    var male = false
    var female = false
    var pill  = false
    var preg = false
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
    }
   
    @IBAction func done(_ sender: Any) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let profil = Profil(context: context)
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
    }
    
    @IBAction func buttonTouchded(_ sender: UIButton) {
        let x = sender.tag
        switch x{
        case 1 : if (!smoker){smoker = true
            }else{
                smoker = false
            }
        case 2:print("male")
            if(!male && !female){
                print("male")
                male = true
                pillButton.isHidden = true
                pregnantButton.isHidden = true
                pillButton.isEnabled = false
                pregnantButton.isEnabled = false
            }else if(!male && female){
                male = true
                female = false
                pillButton.isHidden = true
                pregnantButton.isHidden = true
                pillButton.isEnabled = false
                pregnantButton.isEnabled = false
            }
        case 3:print("female")
            if(!male && !female){
            female = true
            pillButton.isHidden = false
            pregnantButton.isHidden = false
            pillButton.isEnabled = true
            pregnantButton.isEnabled = true
        }else if(male && !female){
            female = true
            pillButton.isHidden = false
            pregnantButton.isHidden = false
            pillButton.isEnabled = true
            pregnantButton.isEnabled = true
            male = false
        }
        case 4:
            if(!pill){ pill = true
            }else{
                pill = false
            }
        case 5:
           if (!preg){preg = true
            }else{
                preg = false
            }
            
        default:
        print("no button")
            
        }
    }
    
   
}

