//
//  RecipeBookTests.swift
//  RecipeBookTests
//
//  Created by Serik Musaev on 2/13/22.
//

import XCTest
@testable import RecipeBook

class RecipeBookTests: XCTestCase {
    
    var testableData: RecipeModel?
    var error: (Error?)
    
    override func setUp() {
        super.setUp()
        
        let expectation = self.expectation(description: "GettingRecipes")
        
        NetworkService.getRecipes(.search(for: .random, count: 10)) { result in
            switch result {
            case .success(let data):
                self.testableData = data
                break
                
            case .failure(let error):
                self.error = error
                break
            }
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 3, handler: nil)
    }
    
    override func tearDown() {
        testableData = nil
        error = nil
        super.tearDown()
    }
    
    func testGetRecipesNotNil() {
        XCTAssertNotNil(self.testableData, "Data should not be nil")
        XCTAssertNil(self.error, "Error should not appear")
    }
    
    func testGetRecipesCount() {
        XCTAssertEqual(self.testableData?.recipes.count, 10)
    }
    /*
    func testGetRecipesDifferentCount() {
        NetworkService.getRecipes(.search(for: .random, count: 5)) { result in
            switch result {
            case .success(let data):
                print(data.recipes.count)
                XCTAssertEqual(data.recipes.count, 5)
                
            case .failure(let error):
                XCTAssertNotNil(error, "Error should appear")
                break
            }
        }
    }*/
}
