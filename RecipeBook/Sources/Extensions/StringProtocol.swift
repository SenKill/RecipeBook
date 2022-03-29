//
//  StringProtocol.swift
//  RecipeBook
//
//  Created by Serik Musaev on 3/27/22.
//

import Foundation

extension StringProtocol {
    var firstCapitalized: String { prefix(1).capitalized + dropFirst() }
    func changeImageSize(to size: ImageSizes) -> String {
        let imageName = self.dropLast(11)
        let finalString = imageName + size.rawValue + ".jpg"
        return finalString
    }
}
