//
//  [String].swift
//  RecipeBook
//
//  Created by Serik Musaev on 3/22/22.
//

import Foundation

extension Array where Element == String {
    func convertStringArrayToString() -> String {
        let array = self
        
        var finalString: String = ""
        for string in array {
            if string != array.last {
                finalString += string.lowercased() + ","
            } else {
                finalString += string.lowercased()
            }
        }
        return finalString
    }
}
