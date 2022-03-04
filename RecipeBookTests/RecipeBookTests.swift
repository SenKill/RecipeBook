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
        // Initializing data for testing methods below
        let expectation = self.expectation(description: "GettingRecipes")
        
        NetworkService.fetchRecipes(.search(for: .random, count: 10, tags: [])) { result in
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
}

class RandomRecipeTests: XCTestCase {
    func testFetchRandomBreakfastRecipe() {
        let expectation = self.expectation(description: "FetchingRecipeTag")
        
        NetworkService.fetchRecipes(.search(for: .random, count: 5, tags: ["Breakfast"])) { (result) in
            switch result {
            case .success(let data):
                for recipe in data.recipes {
                    XCTAssertTrue(recipe.dishTypes.contains("Breakfast"), "Recipe must contain breakfast in dishTypes")
                }
                expectation.fulfill()
            case .failure:
                XCTFail()
                expectation.fulfill()
            }
        }
        
        waitForExpectations(timeout: 3, handler: nil)
    }
    
    func testTwoNetworkCalls() {
        let group = DispatchGroup()
        var mealData: RecipeModel?
        var popularData: RecipeModel?
        
        group.enter()
        NetworkService.fetchRecipes(.search(for: .random, count: 3, tags: [])) { result in
            switch result {
            case .success(let data):
                mealData = data
                group.leave()
            case .failure:
                XCTFail("Error shouldn't appear")
                group.leave()
            }
        }
        
        group.enter()
        NetworkService.fetchRecipes(.search(for: .random, count: 3, tags: ["Dinner"])) { result in
            switch result {
            case .success(let data):
                popularData = data
                group.leave()
            case .failure:
                XCTFail("Error shouldn't appear")
                group.leave()
            }
        }
        
        group.notify(queue: DispatchQueue.main) {
            print("Complete network calls")
            XCTAssertNotNil(mealData, "Meal Data shouldn't be nil")
            XCTAssertNotNil(popularData, "Popular Data shouldn't be nil")
        }
    }
}

class ImageTests: XCTestCase {
    func testFetchRecipeImage() {
        
        let expectation = self.expectation(description: "FetchingImage")
        
        NetworkService.fetchImage(for: .recipe,
                                  from: "https://spoonacular.com/recipeImages/631890-556x370.jpg",
                                  size: nil) { (result) in
            switch result {
            case .success:
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
