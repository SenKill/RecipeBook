//
//  FilterParameter.swift
//  RecipeBook
//
//  Created by Serik Musaev on 3/21/22.
//

import Foundation

struct FilterParameters {
    var cuisine: String?
    var diet: String?
    var type: String?
    var intolerances: [String]
    var maxCalories: Int?
    
    init(cuisine: String?, diet: String?, type: String?, intolerances: [String], maxCalories: Int?) {
        self.cuisine = cuisine
        self.diet = diet
        self.type = type
        self.intolerances = intolerances
        self.maxCalories = maxCalories
    }
    
    init() {
        cuisine = nil
        diet = nil
        type = nil
        intolerances = []
        maxCalories = nil
    }
}
