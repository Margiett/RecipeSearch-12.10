//
//  RecipeSearchAPITests.swift
//  RecipeSearchTests
//
//  Created by Alex Paul on 12/9/19.
//  Copyright © 2019 Alex Paul. All rights reserved.
//

import XCTest
@testable import RecipeSearch

class RecipeSearchAPITests: XCTestCase {
    
    func testSearchChristmasCookies() {
        // this is the async test
        //this is not a uni test because of the 5 seconds wait time.
        
        //arrange
        // convert string to a url friendly string
        let searchQuery = "christmas cookies" .addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
        // this is not url friendly need to change the space
        
        // by adding .addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) made the string url friendly
        
        let exp = XCTestExpectation(description: "searches found")
        
        let receipeEndPointURL = "https://api.edamam.com/search?q=\(searchQuery)&app_id=\(SecretKey.appId)&app_key=\(SecretKey.appKey)&from=0&to=50"
        
        // this string is just a string but we need a urlString
        let request = URLRequest(url: URL(string: receipeEndPointURL)!)
        // act
        NetworkHelper.shared.performDataTask(with: request) { (result) in
            switch result {
            case .failure(let appError):
                XCTFail("appError: \(appError)")
            case .success(let data):
                
                exp.fulfill()
                // tell the test it is a successful run to assert
                // assert
                XCTAssertGreaterThan(data.count, 8000000, "data should be greater than \(data.count)")
            }
        }
        // tell it to wait for 5 seconds for data if it doesnt then the test fail
        wait(for: [exp], timeout: 5.0)
    }
//TODO:  write an asynchronous test to validata you do get back 50 receipes for the 

}
