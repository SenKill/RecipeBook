//
//  Date.swift
//  RecipeBook
//
//  Created by Serik Musaev on 2/22/22.
//

import Foundation


extension Date {
    
    static func getHoursOnly() -> Int? {
        let currentDate = Date()
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateFormat = "HH"
        
        let result = dateFormatter.string(from: currentDate)
        return Int(result)
    }
}
