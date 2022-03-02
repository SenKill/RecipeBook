//
//  RecipeBookTests.swift
//  RecipeBookTests
//
//  Created by Serik Musaev on 2/13/22.
//

import XCTest
@testable import RecipeBook

class RecipeDataTests: XCTestCase {
    
    var testableData: RecipeModel?
    var error: (Error?)
    
    override func setUp() {
        super.setUp()
        
        let expectation = self.expectation(description: "GettingRecipes")
        
        NetworkService.fetchRecipes(.search(for: .random, count: 10)) { result in
            switch result {
            case .success(let data):
                self.testableData = data
                
            case .failure(let error):
                self.error = error
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
    
    func testGetRecipesDifferentCount() {
        
        let expectation = self.expectation(description: "TestingDifferentRecipesCount")
        
        NetworkService.fetchRecipes(.search(for: .random, count: 5)) { result in
            switch result {
            case .success(let data):
                XCTAssertEqual(data.recipes.count, 5)
                expectation.fulfill()
            case .failure(let error):
                XCTAssertNotNil(error, "Error should appear")
                expectation.fulfill()
            }
        }
        
        waitForExpectations(timeout: 3, handler: nil)
    }
}


class FetchImageTests: XCTestCase {
    func testFetchRecipeImage() {
        
        let expectation = self.expectation(description: "FetchingImage")
        
        NetworkService.fetchImage(for: .recipe,
                                  from: "https://spoonacular.com/recipeImages/631890-556x370.jpg",
                                  size: nil) { (result) in
            switch result {
            case .success(let data):
                XCTAssert(true)
                expectation.fulfill()
            case .failure(let error):
                XCTAssertNotNil(error, "Error should appear")
                expectation.fulfill()
            }
        }
        
        waitForExpectations(timeout: 2, handler: nil)
    }
}
