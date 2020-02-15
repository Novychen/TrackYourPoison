//
//  ProfileViewController.swift
//  trackYourPoison
//
//  Created by Yvonne on 14.01.20.
//  Copyright © 2020 Ines&Yvonne. All rights reserved.
//

import UIKit
import CoreData

class ProfileViewController : ViewController {

    var user : [Profil] = []
    
    @IBOutlet weak var nameField: UILabel!
    @IBOutlet weak var userPicture: UIImageView!
    @IBOutlet weak var ageField: UILabel!
    @IBOutlet weak var weightField: UILabel!
    @IBOutlet weak var genderField: UILabel!
    @IBOutlet weak var smokerField: UILabel!
    @IBOutlet weak var pillField: UILabel!
    @IBOutlet weak var pregant: UILabel!
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

       let appDelegate = (UIApplication.shared.delegate as! AppDelegate)
        let context = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<Profil>(entityName: "Profil")
         if let profil = try? context.fetch(request){
            user = profil
            print(user)
        }
        if !user.isEmpty{
            nameField.text = String("\(user[0].name!)")
            ageField.text = "\(user[0].age)"
            weightField.text = String("\(user[0].weight)")
         
            genderField.text = user[0].gender
            if user[0].nikotin {
                smokerField.isHidden = false
              }else{smokerField.isHidden = true}
            if user[0].pill {
                pillField.isHidden = false
            }else{pillField.isHidden = true}
            if user[0].pregnent {
                pregant.isHidden = false
            }else{pregant.isHidden = true}
        }
    }
    
    override func viewDidLoad() {
        userPicture.image = loadImageFromDiskWith(fileName: "user_profile_photo")
    }
    
    func loadImageFromDiskWith(fileName: String) -> UIImage? {
        
        let documentDirectory = FileManager.SearchPathDirectory.documentDirectory
        
        let userDomainMask = FileManager.SearchPathDomainMask.userDomainMask
        let paths = NSSearchPathForDirectoriesInDomains(documentDirectory, userDomainMask, true)
        
        if let dirPath = paths.first {
            let imageUrl = URL(fileURLWithPath: dirPath).appendingPathComponent(fileName)
            let image = UIImage(contentsOfFile: imageUrl.path)
            return image
            
        }
        
        return nil
    }
    
}


    
    
   
    

