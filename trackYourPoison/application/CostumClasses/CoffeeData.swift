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
    private var alcohol : [Double]
    private var coffeine : [Double]
    private var sugar : [Double]
    private var size : [[String]]
    private var kcal : [Int]
    private var image : [String]
    
    init() {
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
        
        image = ["Coffee_SB_Americano",
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
        
        alcohol = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
        coffeine = [59, 59, 65, 59.1, 5.9, 25.6, 3.1, 40, 40.1, 68.6, 19.3, 30, 35.3, 30, 30, 2.1]
        sugar = [0, 4.9, 8, 4.4, 8.9, 13.1, 12.6, 0, 2.4, 3.4, 13.8, 2.5, 11, 3.2, 0, 12.3]
        kcal = [4, 71, 95, 64, 103, 67, 48, 0, 29, 70, 48, 34, 80, 40, 0, 95]
        size = [["short","tall","grande","venti"],
               ["short","tall","grande","venti"],
               ["short","tall","grande","venti"],
               ["short","tall","grande","venti"],
               ["short","tall","grande","venti"],
               ["short","tall","grande","venti"],
                ["small","medium","large"],
                ["small","medium","large"],
                ["small","medium","large"],
                ["small","medium","large"],
                ["small","medium","large"],
                ["small","medium","large"],
                ["small","medium","large"],
                ["small","medium","large"],
                ["small","medium","large"],
                ["small","medium","large"]
        ]
    }
    
    public func getName() -> [String] {
        return name
    }
    
    public func getAlcohol() -> [Double] {
        return alcohol
    }
    
    public func getSugar() -> [Double] {
        return sugar
    }
    
    public func getCoffeine() -> [Double] {
        return coffeine
    }
    
    func getSize() -> [[String]] {
        return size
    }
    
    func getKcal() -> [Int] {
        return kcal
    }
}
