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
    case wrongStatusCode
}

extension NetworkError {
    var localizedDescription: String {
        switch self {
        case .wrongUrl:
            return NSLocalizedString("Invalid url was entered", comment: "")
        case .notFoundData:
            return NSLocalizedString("Cannot find any data from network call", comment: "")
        case .wrongImageType:
            return NSLocalizedString("Undefined image type was find while fetching image", comment: "")
        case .wrongStatusCode:
            return NSLocalizedString("Wrong status code response", comment: "")
        }
    }
}
