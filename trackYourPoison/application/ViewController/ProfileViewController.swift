//
//  ProfileViewController.swift
//  trackYourPoison
//
//  Created by Yvonne on 14.01.20.
//  Copyright © 2020 Ines&Yvonne. All rights reserved.
//

import UIKit
import CoreData

class ProfileViewController : UIViewController {

    var user : [Profil] = []
    
    @IBOutlet weak var nameField: UILabel!
    @IBOutlet weak var userPicture: UIImageView!
    @IBOutlet weak var ageField: UILabel!
    @IBOutlet weak var weightField: UILabel!
    @IBOutlet weak var genderField: UILabel!
    
    @IBOutlet weak var Label: UILabel!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

       let appDelegate = (UIApplication.shared.delegate as! AppDelegate)
       let context = appDelegate.persistentContainer.viewContext
       let request = NSFetchRequest<Profil>(entityName: "Profil")
        if let profil = try? context.fetch(request){
            user = profil
        }
        print(user[0])

        if !user.isEmpty {
            nameField.text = String("\(user[0].name!)")
            ageField.text = "\(user[0].age)"
            weightField.text = String("\(user[0].weight)")
         
            genderField.text = user[0].gender
            let nikotion = user[0].nikotin
            let pill = user[0].pill
            let preg =  user[0].pregnent
            
            if nikotion && pill && preg {
                Label.text = "You are smoking, taking the pill and pregnant"
            }  else if !nikotion && !pill && preg {
                Label.text = "You are pregnant"
            } else if !nikotion && pill && !preg {
                Label.text = "You are taking the pill"
            } else if nikotion && !pill && !preg {
                Label.text = "You are smoking"
            } else if nikotion && pill && !preg {
                Label.text = "You are smoking and taking the pill"
            } else if !nikotion && pill && preg {
                Label.text = "You are taking the pill and pregnant"
            } else if nikotion && !pill && preg {
                Label.text = "You are smoking and pregnant"
            } else { Label.text = " " }
    }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.userPicture.image = loadImageFromDiskWith(fileName: "user_profile_photo")
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


    
    
   
    

