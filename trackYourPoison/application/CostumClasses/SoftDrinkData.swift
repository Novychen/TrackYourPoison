//
//  SoftDrinkData.swift
//  trackYourPoison
//
//  Created by Yvonne on 06.02.20.
//  Copyright © 2020 Ines&Yvonne. All rights reserved.
//

import Foundation
class SoftDrinkData {
    
    private var name : [String]
    private var coffeine : [Double]
    private var sugar : [Double]
    private var size : [[String]]
    private var kcal : [Int]
    
    init() {
        name = ["Coca-Cola Classic",
                "Coca-Cola Zero",
                "Coca-Cola Vanilla",
                "Coca-Cola Cherry", 
                "Coca-Cola Diet",
                "Coca-Cola Life",
                "Red Bull Classic",
                "Red Bull Total Zero",
                "Red Bull sugarfree",
                "MONSTER ENERGY",
                "Dr Pepper Classic",
                "Dr Pepper Zero",
                "Pepsi Cola Classic",
                "Dr Pepper Cherry",
                "Fanta Orange",
                "fritz-kola",
                "7-Up",
                "Sprite",
                "Xl Energy Drink",
                "Spider Energy Drink",
                "SPIKE Hardcore Energy"]
        
        coffeine = [9.6, 9.6, 9.6, 9.6, 13, 7.9, 32, 32, 32, 36, 11.5, 11.5, 11, 0, 10.7, 25, 0, 0, 32.6, 50.7, 73.9]
        sugar = [10.6, 0, 11.1, 10.7, 0, 4.8, 11, 0, 0, 0, 0, 11.4, 6.8, 10.3, 11.6, 11, 10.4, 5, 11, 5.9, 0]
        size = [["ml"], ["ml"], ["ml"], ["ml"],["ml"],["ml"],["ml"],["ml"],["ml"],["ml"],["ml"],["ml"], ["ml"], ["ml"],["ml"],["ml"],["ml"],["ml"],["ml"],["ml"],["ml"]]
        
        kcal = [39,0,34,36,0,25,45,0,0,47,27,1,43,28,42,42,44,39,47,25,0]
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
    
    func getSize() -> [[String]] {
        return size
    }
    
    func getKcal() -> [Int] {
        return kcal
    }
}

/*
 [150,200,250,330,500,1000,1250,1500,2000],
 [150,200,250,330,500,1000,1250,1500,2000],
 [150,200,250,330,500,1000,1250,1500,2000],
 [150,200,250,330,500,1000,1250,1500,2000],
 [150,200,250,330,500,1000,1250,1500,2000],
 [250,1000,1500,2000],
 [250, 355, 473],
 [250, 355, 473],
 [250, 355, 473],
 [330,553,500],
 [330, 500, 1000],
 [330, 500, 1000],
 [330, 500, 1000],
 [250, 330, 500, 1000, 1500, 2000],
 [330, 500, 1500, 2000],
 [200, 330, 500],
 [330],
 [330, 500, 1000, 1500, 2000],
 [250],
 [250],
 [250]*/

