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
    var intolerances: [String]
    
    init(cuisine: String?, diet: String?, intolerances: [String]) {
        self.cuisine = cuisine
        self.diet = diet
        self.intolerances = intolerances
    }
    
    init() {
        cuisine = nil
        diet = nil
        intolerances = []
    }
}
