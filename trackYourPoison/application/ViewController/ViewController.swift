//
//  ViewController.swift
//  trackYourPoison
//
//  Created by Yvonne on 18.12.19.
//  Copyright © 2019 Ines&Yvonne. All rights reserved.
//

import UIKit

class ViewController: UIViewController {


    @IBOutlet weak var addButton: UIButton!
       @IBOutlet weak var camera: UIButton!
       @IBOutlet weak var listButton: UIButton!
       @IBOutlet weak var write: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

       
       @IBAction func buttonTouchded(_ sender: UIButton) {
           let x = sender.tag
           switch x{
           case 1 :
               if camera.isHidden{
                   camera.isHidden = false
                   camera.isEnabled = true
                   listButton.isHidden = false
                   listButton.isEnabled = true
                   write.isHidden = false
                   write.isEnabled = true
               }else{
                   camera.isHidden = true
                   listButton.isHidden = true
                   write.isHidden = true
                   camera.isEnabled = false
                   listButton.isEnabled = false
                   write.isEnabled = false
               }
               print("addAll")
           case 2:
            print("list")
           case 3:
             print("write")
           case 4:
             print("camera")
           default:
               print("no button")
           }

    }
}

