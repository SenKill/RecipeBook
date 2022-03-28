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
        
        NetworkService.fetchRecipes(.randomSearch(number: 10)) { result in
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
        XCTAssertEqual(self.testableData?.recipes?.count, 10)
    }
}

class RandomRecipeTests: XCTestCase {
    func testFetchRandomBreakfastRecipe() {
        let expectation = self.expectation(description: "FetchingRecipeTag")
        let tag = "breakfast"
        
        NetworkService.fetchRecipes(.randomSearch(number: 5, tags: [tag])) { (result) in
            switch result {
            case .success(let data):
                for recipe in data.recipes! {
                    XCTAssertTrue(recipe.dishTypes.contains(tag), "Recipe must contain \(tag) in dishTypes")
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
        let expectation = self.expectation(description: "FetchingTwoNetworkCalls")
        let group = DispatchGroup()
        var mealData: RecipeModel?
        var popularData: RecipeModel?
        
        group.enter()
        NetworkService.fetchRecipes(.randomSearch(number: 3)) { result in
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
        NetworkService.fetchRecipes(.randomSearch(number: 3, tags: ["Dinner"])) { result in
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
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 3, handler: nil)
    }
}

class ComplexSearchTests: XCTestCase {
    func testComplexRecipeModel() {
        let expectatiton = expectation(description: "FetchingLasagna")
        let filter = FilterParameters(cuisine: nil, diet: nil, type: nil, intolerances: [], maxCalories: nil, sort: nil)
        
        NetworkService.fetchRecipes(.searchWithFilter(filter, query: "Lasagna", number: 3)) { result in
            switch result {
            case .success(let data):
                XCTAssertNotNil(data, "Data should appear")
                XCTAssertEqual(data.results?.count, 3)
                expectatiton.fulfill()
            case .failure(let error):
                XCTFail("Error: \(error.localizedDescription)")
                expectatiton.fulfill()
            }
        }
        
        waitForExpectations(timeout: 3, handler: nil)
    }
    
    func testComplexSearchWithFilters() {
        let expecation = expectation(description: "FetchingWithFilters")
        let filter = FilterParameters(cuisine: "German", diet: nil, type: "Main course", intolerances: ["Soy"], maxCalories: nil, sort: nil)
        
        NetworkService.fetchRecipes(.searchWithFilter(filter, query: "", number: 5)) { result in
            switch result {
            case .success(let data):
                XCTAssertEqual(data.results?.count, 5)
                expecation.fulfill()
            case .failure(let error):
                XCTFail("Error: \(error.localizedDescription)")
                expecation.fulfill()
            }
        }
        
        waitForExpectations(timeout: 3, handler: nil)
    }
    
    func testComplexSearchWithCaloriesFilter() {
        let expectation = self.expectation(description: "FetchingWithCaloriesFilter")
        let maxCalories: Float = 300
        let filter = FilterParameters(cuisine: nil, diet: nil, type: nil, intolerances: [], maxCalories: Int(maxCalories), sort: nil)
        
        NetworkService.fetchRecipes(.searchWithFilter(filter, query: "", number: 3)) { result in
            switch result {
            case .success(let data):
                let recipes = data.results
                for recipe in recipes! {
                    guard let calories = recipe.nutrition?.nutrients.first,
                          calories.name == "Calories" else {
                        XCTFail("Can't find calories in nutrients")
                        expectation.fulfill()
                        return
                    }
                    
                    XCTAssertLessThanOrEqual(calories.amount, maxCalories, "Calories must be less or equal than max calories")
                }
                expectation.fulfill()
            case .failure(let error):
                XCTFail("Error: \(error.localizedDescription)")
                expectation.fulfill()
            }
        }
        
        waitForExpectations(timeout: 3, handler: nil)
    }
}

class ImageTests: XCTestCase {
    func testFetchRecipeImage() {
        let expectation = self.expectation(description: "FetchingImage")
        
        NetworkService.fetchImage(for: .recipe, with: "https://spoonacular.com/recipeImages/631890-556x370.jpg", size: nil) { (result) in
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
