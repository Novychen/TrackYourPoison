//
//  CoffeeData.swift
//  trackYourPoison
//
//  Created by Yvonne on 08.02.20.
//  Copyright © 2020 Ines&Yvonne. All rights reserved.
//

import Foundation
class CoffeeData {
    private var name : [String]
    private var coffeine : [Double]
    private var sugar : [Double]
    private var size : [String]
    private var kcal : [Int]
    private var image : [String]
    
    init() {
        image = ["Coffee_SB_Americano.png",
                "Coffee_SB_Latte.png",
                "Coffee_SB_Mocha.png",
                "Coffee_SB_Cappucino.png",
                "Coffee_SB_HotChocolate.png",
                "Coffee_SB_Frappuccino_Coffee.png",
                "Coffee_DD_HotChocolate.png",
                "Coffee_DD_Espresso.png",
                "Coffee_DD_Cappuccino.png",
                "Coffee_DD_Machiato.png",
                "Coffee_DD_Chai.png",
                "Coffee_McD_Cappuccino.png",
                "Coffee_McD_MochaLatta.png",
                "Coffee_McD_Latte.png",
                "Coffee_McD_Americano.png",
                "Coffee_McD_HotChoclate.png"
        ]
        
        name = ["Starbucks Caffè Americano",
                 "Starbucks Caffè Latte",
                 "Starbucks Caffè Mocha",
                 "Starbucks Cappucino",
                 "Starbucks Classic Hot Chocolate",
                 "Starbucks Coffee Frappuccino",
                 "Dunkin'n Donuts Hot Chocolate",
                 "Dunkin'n Donuts Espresso",
                 "Dunkin'n Donuts Cappuccino",
                 "Dunkin'n Donuts Macchiato",
                 "Dunkin'n Donuts Frozen Vanilla Chai",
                 "McDonalds Cappuccino",
                 "McDonalds Mocha Latte",
                 "McDonalds Latte",
                 "McDonalds Americano",
                 "McDonalds Hot Chocolate"
        ]
        
        coffeine = [59, 59, 65, 59.1, 5.9, 25.6, 3.1, 40, 40.1, 68.6, 19.3, 30, 35.3, 30, 30, 2.1]
        sugar = [0, 4.9, 8, 4.4, 8.9, 13.1, 12.6, 0, 2.4, 3.4, 13.8, 2.5, 11, 3.2, 0, 12.3]
        kcal = [4, 71, 95, 64, 103, 67, 48, 0, 29, 70, 48, 34, 80, 40, 0, 95]
        size = ["ml", "ml", "ml", "ml", "ml", "ml", "ml", "ml", "ml", "ml", "ml", "ml", "ml", "ml", "ml", "ml"]
    }
    
    public func getName() -> [String] {
        return name
    }
    
    public func getSugar() -> [Double] {
        return sugar
    }
    
    public func getCoffeine() -> [Double] {
        return coffeine
    }
    
    func getSize() -> [String] {
        return size
    }
    
    func getKcal() -> [Int] {
        return kcal
    }
    
    func getImage() -> [String] {
        return image
    }
}
