//
//  StringProtocol.swift
//  RecipeBook
//
//  Created by Serik Musaev on 3/27/22.
//

import Foundation

extension StringProtocol {
    var firstCapitalized: String { prefix(1).capitalized + dropFirst() }
}
