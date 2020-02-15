//
//  TeaData.swift
//  trackYourPoison
//
//  Created by Yvonne on 08.02.20.
//  Copyright © 2020 Ines&Yvonne. All rights reserved.
//

import Foundation
class TeaData {
    private var name : [String]
    private var alcohol : [Double]
    private var coffeine : [Double]
    private var sugar : [Double]
    private var size : [String]
    private var kcal : [Int]
    private var image : [String]

    init() {
        name = ["Scharzer Tee", "Früchtetee", "Kräutertee", "Grüner Tee", "Weißer Tee","Jasmintee"]
        image = ["tea_tea.png", "tea_tea.png", "tea_tea.png", "tea_tea.png", "tea_tea.png","tea_tea.png"]
        alcohol = [0.0,0.0,0.0,0.0,0.0,0.0]
        coffeine = [20.0,11.0,11.0,10.6,11.80,10.60]
        sugar = [0.0,0.0,0.0,0.0,0.0,0.0]
        kcal = [0,0,0,0,0,0]
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
