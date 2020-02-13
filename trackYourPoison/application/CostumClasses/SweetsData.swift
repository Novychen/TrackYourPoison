//
//  SweetsData.swift
//  trackYourPoison
//
//  Created by Yvonne on 08.02.20.
//  Copyright © 2020 Ines&Yvonne. All rights reserved.
//

import Foundation
class SweetsData {
    private var name : [String]
    private var alcohol : [Double]
    private var coffeine : [Double]
    private var sugar : [Double]
    private var size : [[String]]
    private var kcal : [Int]
    private var image : [String]

    
    init() {
        name = ["KitKat White", "KitKat Ruby", "KitKat Matcha", "KitKat Classic",
                "Oreo", "Oreo Golden",
                "Haribo Goldbears", "Haribo Happy Cola", "Haribo Twin Snakes", "Haribo Cherries", "Haribo Frogs",
                "Mirabell Mozart ball", "Niemetz Schwedenbombe",
                "Kinder Suprise", "Twix", "Nutella"
                ]
        
        image = ["Sweets_KitKat_White.png", "Sweets_KitKat_Ruby.png", "Sweets_KitKat_Matcha.png", "Sweets_KitKat_Classic.png",
                "Sweets_Oreo_Classic.png", "Sweets_Oreo_Golden.png",
                "Sweets_Haribo_Goldbears.png", "Sweets_Haribo_happycola.png", "Sweets_Haribo_twinsnakes.png", "Sweets_Haribo_happy-cherries.png", "Sweets_Haribo_frogs.png",
                "Sweets_Mozartkugel", "Sweets_Niemetz_Schwedenbombe.png",
                "Sweets_Kinder_Überraschungsei.png", "Sweets_Twix", "Sweets_Nutella.png"
        ]
       
        alcohol = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
        coffeine = [14, 14, 14, 14, 11.8, 11.8, 0, 0, 0, 0, 0, 0, 0, 0, 7, 7]
        sugar = [50.2, 45, 42.7, 45, 35, 38, 46.6, 46.9, 42.4, 43.8, 53.28, 51.5, 54, 52.1, 49, 56.3]
        kcal = [515, 529, 536, 514, 484, 474, 333, 344, 346, 344, 333, 550, 413, 552, 493, 539]
        size = [["package", "sticks", "g"],
                ["package", "sticks", "g"],
                ["package", "sticks", "g"],
                ["package", "sticks", "g"],
                ["package", "cookies", "g"],
                ["package", "cookies", "g"],
                ["package", "pieces", "g"],
                ["package", "pieces", "g"],
                ["package", "pieces", "g"],
                ["package", "pieces", "g"],
                ["package", "pieces", "g"],
                ["pieces", "g"],
                ["pieces", "g"],
                ["pieces", "g"],
                ["pieces", "g"],
                ["glas", "g"]
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
    
    func getImage() -> [String] {
        return image
    }
}

