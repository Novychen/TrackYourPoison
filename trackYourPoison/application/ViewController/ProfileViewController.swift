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
        
    @IBOutlet weak var userPicture: UIImageView!
    
    @IBOutlet weak var infoTable: UITableView!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<Profil>(entityName: "Profil")
        if let profil = try? context.fetch(request){
            print(profil)
        }
    }
}
