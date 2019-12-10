//
//  RecipeSearchAPI.swift
//  RecipeSearch
//
//  Created by Margiett Gil on 12/10/19.
//  Copyright © 2019 Alex Paul. All rights reserved.
//

import Foundation

struct RecipeSearchAPI {
    static func fetchRecipe(for searchQuery: String, completion: @escaping (Result<[Recipe], AppError>)  -> ()) {
        
        let receipeEndPointURL = "https://api.edamam.com/search?q=\(searchQuery)&app_id=\(SecretKey.appId)&app_key=\(SecretKey.appKey)&from=0&to=50"
        
        guard let url = URL(string: receipeEndPointURL) else {
            completion(.failure(.badURL(receipeEndPointURL)))
            return
        }
        // this string is just a string but we need a urlString
        let request = URLRequest(url: url)
        
        NetworkHelper.shared.performDataTask(with: request) { (result) in
            switch result {
            case .failure(let appError):
                completion(.failure(.networkClientError(appError)))
            case .success(let data):
                do {
                    let searchResult = try JSONDecoder().decode(RecipeSearch.self, from: data)
                    
                    //1. TODO: use searchResults to create an array of recipes
                    //2. capture the array of recipes in the completion handler
                    
                }catch{
                    completion(.failure(.decodingError(error)))
                }
                
            }
        }
    }
}
