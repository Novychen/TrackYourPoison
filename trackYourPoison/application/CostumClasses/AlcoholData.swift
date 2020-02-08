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
    private var size : [[String]]
    private var kcal : [Int]
    
    init() {
        name = []
        alcohol = []
        coffeine = []
        sugar = []
        kcal = []
        size = [[]]
        
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
