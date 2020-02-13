//
//  SizeCell.swift
//  trackYourPoison
//
//  Created by Yvonne on 08.02.20.
//  Copyright © 2020 Ines&Yvonne. All rights reserved.
//

import Foundation
import UIKit
class SizeCell : UITableViewCell {
    
    @IBOutlet weak var foodName: UILabel!
    @IBOutlet weak var amount: UITextField!
    @IBOutlet weak var foodImage: UIImageView!
    @IBOutlet weak var sizeLabel: UILabel!
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.cornerRadius = 10
        self.layer.masksToBounds = true
    }
}
