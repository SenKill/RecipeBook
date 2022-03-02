//
//  RecipeModel.swift
//  RecipeBook
//
//  Created by Serik Musaev on 2/14/22.
//

import Foundation

struct RecipeModel: Codable {
    let recipes: [Recipe]
}

struct Recipe: Codable {
    let vegetarian: Bool
    let vegan: Bool
    let glutenFree: Bool
    let dairyFree: Bool
    let veryHealthy: Bool
    let cheap: Bool
    let veryPopular: Bool
    let sustainable: Bool
    let weightWatcherSmartPoints: Int
    let gaps: String
    let lowFodmap: Bool
    let aggregateLikes: Int
    let spoonacularScore: Int
    let healthScore: Int
    let creditsText: String?
    let license: String?
    let sourceName: String?
    let pricePerServing: Float
    let extendedIngredients: [Ingridient]
    let id: Int
    let title: String
    let readyInMinutes: Int
    let servings: Int
    let sourceUrl: String
    let image: String?
    let imageType: String?
    let summary: String
    let cuisines: [String]
    let dishTypes: [String]
    let diets: [String]
    let occasions: [String]
    let instructions: String
    let analyzedInstructions: [Instruction]
}

struct Ingridient: Codable {
    let id: Int?
    let aisle: String?
    let image: String?
    let consistency: String?
    let name: String
    let nameClean: String?
    let original: String?
    let originalName: String?
    let amount: Float?
    let unit: String?
    // Not sure about these properties
    let meta: [String]?
    let measures: Measure?
}

struct Measure: Codable {
    let us: MeasureInfo
    let metric: MeasureInfo
}

struct MeasureInfo: Codable {
    let amount: Float
    let unitShort: String
    let unitLong: String
}

struct Instruction: Codable {
    let name: String
    let steps: [InstuctionStep]
}

struct InstuctionStep: Codable {
    let number: Int
    let step: String
    let ingredients: [Ingridient]
    let equipment: [Equipment]
    let length: Length?
}

struct Equipment: Codable {
    let id: Int
    let name: String
    let localizedName: String
    let image: String
}

struct Length: Codable {
    let number: Int
    let unit: String
}
