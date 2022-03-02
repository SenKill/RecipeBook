//
//  NetworkError.swift
//  RecipeBook
//
//  Created by Serik Musaev on 2/28/22.
//

import Foundation

enum NetworkError: LocalizedError {
    case wrongUrl
    case notFoundData
    case wrongImageType
}
