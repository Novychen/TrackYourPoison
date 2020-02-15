//
//  AlcoholData.swift
//  trackYourPoison
//
//  Created by Yvonne on 08.02.20.
//  Copyright © 2020 Ines&Yvonne. All rights reserved.
//

import Foundation
class AlcoholData {
    private var name : [String]
    private var alcohol : [Double]
    private var coffeine : [Double]
    private var sugar : [Double]
    private var size : [String]
    private var kcal : [Int]
    private var image : [String]

    init() {
        image = ["Alcohol_Freistädter.png","Alcohol_Gösser.png","Alcohol_stiegl.png", "Alcohol_weißwein.png","Alcohol_rotwein.png","Alcohol_kornschnaps.png"]
        name = ["Freistädter Bier","Gösser","Stiegl", "Weißwein","Rotwein","Snaps Korn"]
        alcohol = [4.4, 5.2, 5.1, 13, 12, 32]
        coffeine = [0.0, 0.0, 0.0, 0.0, 0.0, 0.0]
        sugar = [0.0, 0.0, 0.0,1.0, 0.6, 0.0]
        kcal = [48 , 43, 43, 68 , 80, 215]
        size = ["ml","ml","ml","ml","ml","ml"]
        
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
    
    func getSize() -> [String] {
        return size
    }
    
    func getKcal() -> [Int] {
        return kcal
    }
    
    public func getImage() -> [String] {
        return image
    }
}
