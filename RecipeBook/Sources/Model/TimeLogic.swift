//
//  TimeLogic.swift
//  RecipeBook
//
//  Created by Serik Musaev on 3/1/22.
//

import Foundation

struct TimeLogic {
    static func getLabels(from hours: Int) -> [String] {
        var result = ["Good morning!🌅", "Breakfast"]
        
        switch hours {
        case let hour where 6...11 ~= hour:
            break
        case let hour where 12...16 ~= hour:
            result = ["Good afternoon!☀️", "Lunch"]
        case let hour where 17...23 ~= hour:
            result = ["Good evening!🌇", "Dinner"]
        case let hour where 0...5 ~= hour:
            result = ["Good night!🌙", "Snacks"]
        default:
            print("Unexpected hours value")
        }
        
        return result
    }
}
