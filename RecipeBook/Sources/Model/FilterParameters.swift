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
    var query: String?
    var intolerances: [String]
    
    init(cuisine: String?, diet: String?, type: String?, intolerances: [String]) {
        self.cuisine = cuisine
        self.diet = diet
        self.type = type
        self.intolerances = intolerances
    }
    
    init() {
        cuisine = nil
        diet = nil
        type = nil
        intolerances = []
    }
}
