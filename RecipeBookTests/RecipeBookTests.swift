//
//  RecipeBookTests.swift
//  RecipeBookTests
//
//  Created by Serik Musaev on 2/13/22.
//

import XCTest
@testable import RecipeBook

class RecipeBookTests: XCTestCase {

    func testGetRecipes() {
        let recipes = NetworkService.getRecipes()
        
        XCTAssertNotEqual(recipes.count, 0)
    }
}
