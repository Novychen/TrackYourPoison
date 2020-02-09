//
//  ProfileViewController.swift
//  trackYourPoison
//
//  Created by Yvonne on 14.01.20.
//  Copyright © 2020 Ines&Yvonne. All rights reserved.
//

import UIKit
import CoreData

class ProfileViewController : UITableViewController {

    var user : [Profil] = []
    

    @IBOutlet weak var userPicture: UIImageView!
    
    @IBOutlet weak var infoTable: UITableView!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        let appDelegate = (UIApplication.shared.delegate as! AppDelegate)
        let context = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<Profil>(entityName: "Profil")
         if let profil = try? context.fetch(request){
            user = profil
        }
        
       // ageField.text = "\(user[0].age)"
        tableView.reloadData()
    }
           
       override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
              return UITableView.automaticDimension
          }
          
          override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
              return 8
          }
          
          override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
              let cell = tableView.dequeueReusableCell(withIdentifier: "ProfileCell")!
             
              return cell
          }
    
}
