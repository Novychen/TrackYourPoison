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
    

    @IBOutlet weak var userPicture: UIImageView!
    
    @IBOutlet weak var infoTable: UITableView!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        infoTable.delegate = self
        infoTable.dataSource = self

       let appDelegate = (UIApplication.shared.delegate as! AppDelegate)
        let context = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<Profil>(entityName: "Profil")
         if let profil = try? context.fetch(request){
            user = profil
        }
    
       // ageField.text = "\(user[0].age)"
        infoTable.reloadData()
    }
    
}

extension ProfileViewController : UITableViewDelegate {
    
}
extension ProfileViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProfileCell")!
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return user.count
    }
    
    
   
    
}
