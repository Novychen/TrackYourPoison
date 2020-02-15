//
//  NewUserViewController.swift
//  trackYourPoison
//
//  Created by Yvonne on 15.02.20.
//  Copyright © 2020 Ines&Yvonne. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class NewUserViewController : UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate{
    
    var isSmoker = false
    var takesPill = false
    var isPregnant = false
    
    @IBOutlet weak var pillLabel: UILabel!
    @IBOutlet weak var pregnantLabel: UILabel!
    
    @IBOutlet weak var userImage : UIImageView!
    @IBOutlet weak var userName : UITextField!
    @IBOutlet weak var userWeight : UITextField!
    @IBOutlet weak var userAge : UITextField!

    @IBOutlet weak var gender : UISegmentedControl!
    @IBOutlet weak var smoke : UISegmentedControl!
    @IBOutlet weak var pill : UISegmentedControl!
    @IBOutlet weak var pregnant : UISegmentedControl!

    @IBAction func selectedGender (_ sender: Any) {
        let pickedGender = gender.selectedSegmentIndex
        if pickedGender != 1 {
            pill.isHidden = false
            pillLabel.isHidden = false
            pregnant.isHidden = false
            pregnantLabel.isHidden = false
        } else {
            pill.isHidden = true
            pillLabel.isHidden = true
            pregnant.isHidden = true
            pregnantLabel.isHidden = true
        }
    }
    
    @IBAction func pickedSmoke(_ sender: Any) {
        let pickedSmoker = smoke.selectedSegmentIndex
        if pickedSmoker == 1 {
            isSmoker = true
        } else {
            isSmoker = false
        }
    }
    
    @IBAction func pickedPill(_ sender: Any) {
        let pickedPill = pill.selectedSegmentIndex
        if pickedPill == 1 {
            takesPill = true
        } else {
            takesPill = false
        }
    }
    
    @IBAction func pickedPregnant(_ sender: Any) {
        let pickedPregnant = pregnant.selectedSegmentIndex
        if pickedPregnant == 1 {
            isPregnant = true
        } else {
            isPregnant = false
        }
    }
    
    @IBAction func pickImage (_ sender: Any) {
        let image = UIImagePickerController()
        image.delegate = self
        image.sourceType = UIImagePickerController.SourceType.photoLibrary
        image.allowsEditing = false
        self.present(image, animated: true)
    }
    
    @IBAction func done (_ sender: Any) {

        if userName.text != "" && userWeight.text != "" && userAge.text != "" {
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let context = appDelegate.persistentContainer.viewContext
            let profil = NSEntityDescription.insertNewObject(forEntityName: "Profil", into: context) as! Profil
            profil.name = userName.text
            profil.nikotin = isSmoker
            profil.pill = takesPill
            profil.pregnent = isPregnant
            let pickedGender = gender.selectedSegmentIndex
            if pickedGender == 0 {
                profil.gender = "female"
            }else if pickedGender == 1 {
                profil.gender = "male"
            }else{
                profil.gender = "unknown"
            }
            profil.age = Int64(userAge.text ?? " ") ?? 0
            profil.weight = Double(userWeight.text!) ?? 0
            appDelegate.saveContext()
            
            saveImage(imageName: "user_profile_photo", image:  userImage.image ?? UIImage(named : "replacment.jpeg")!)
            
            navigationController?.popViewController(animated: true)
            dismiss(animated: true, completion: nil)
            
            let storyboard = UIStoryboard(name: "Main", bundle: nil) 
            let viewController : UITabBarController = storyboard.instantiateViewController(withIdentifier: "TabBarController") as! TabBarController
            self.present(viewController, animated: true, completion: nil)
        } else {
            let alert = UIAlertController(title: "Error", message: "Please enter your data", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
            self.present(alert, animated: true)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupHideKeyboardOnTap()

    }
    
    func saveImage(imageName: String, image: UIImage) {
        
        guard let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return }
        
        let fileName = imageName
        let fileURL = documentsDirectory.appendingPathComponent(fileName)
        guard let data = image.jpegData(compressionQuality: 1) else { return }
        
        //Checks if file exists, removes it if so.
        if FileManager.default.fileExists(atPath: fileURL.path) {
            do {
                try FileManager.default.removeItem(atPath: fileURL.path)
                print("Removed old image")
            } catch let removeError {
                print("couldn't remove file at path", removeError)
            }
        }
        
        do {
            try data.write(to: fileURL)
        } catch let error {
            print("error saving file with error", error)
        }
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {

            userImage.image = image
        } else {
            let alert = UIAlertController(title: "Error", message: "There seems to be a problem with this image. Please pick another one", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
            self.present(alert, animated: true)
        }
        self.dismiss(animated: true, completion: nil)
    }
}

extension NewUserViewController {
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
