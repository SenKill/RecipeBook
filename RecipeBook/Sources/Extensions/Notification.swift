//
//  Notification.swift
//  RecipeBook
//
//  Created by Serik Musaev on 18.04.2022.
//

import Foundation

extension Notification {
    enum UserInfoKeys {
        static let id = "id"
    }
}

extension Notification.Name {
    static var favoriteChanged: Notification.Name {
        return .init(rawValue: "Favorite.changed")
    }
}
