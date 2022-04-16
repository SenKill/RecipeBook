//
//  UserDefaults.swift
//  RecipeBook
//
//  Created by Serik Musaev on 16.04.2022.
//

import Foundation

extension UserDefaults {
    static let keys = Keys()
}

struct Keys {
    let isUserReady: String = "isUserReady"
    let favorites: String = "favorites"
}
