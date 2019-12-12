//
//  RecipeSearchController.swift
//  RecipeSearch
//
//  Created by Alex Paul on 12/9/19.
//  Copyright © 2019 Alex Paul. All rights reserved.
//

import UIKit

class RecipeSearchController: UIViewController {
    //MARK: TODO: we need a table view
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    //MARK: TODO: We need a recipes array
    var recipes = [Recipe]() {
        //MARK: TODO on the recipes array have a didSet{} to update the table view
        didSet {
            // why do we add the dispatchQueue.main.async
            DispatchQueue.main.async { //closure
                // because it needs reference thats why we put self because we are in a clousure
                self.tableView.reloadData()
            }
            
        }
    }
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        searchBar.delegate = self
        searchRecipes(searchQuery: "cookies")
        
        // set navigation bar title
        navigationItem.title = "Recipe Search"
    }
     //MARK: TODO: recipesSearchAPI.fetchRecipes("mac and cheese") accessing data to populate recipe array example "christmas cookies"
    func searchRecipes(searchQuery: String) {
        RecipeSearchAPI.fetchRecipe(for: searchQuery, completion: { [weak self] (result) in
            switch result {
            case .failure(let appError):
                print("error \(appError)")
            case .success(let recipes):
                self?.recipes = recipes
            }
            
        })
    }
    
}
// MARK: Data Source TODO: in cdellForRow show the recipes label
// to seprate the datasource in the tableview
extension RecipeSearchController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipes.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
       guard let cell = tableView.dequeueReusableCell(withIdentifier: "recipeCell", for: indexPath) as? RecipeCellTableViewCell else {
        fatalError("could not dequeue a RecipeCell")
        }
        let selfRecipe = recipes[indexPath.row]
        cell.configureCell(for: selfRecipe)
        //cell.textLabel?.text = selfRecipe.label
        
        return cell
        }
    }
extension RecipeSearchController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 400
    }
}

//MARK: Delegate
// extensions are no require but we use them to seprate our logic, also to extend our type
extension RecipeSearchController: UISearchBarDelegate {
    // we are not going to call the text did change because it will call the api too many times since we put a 5 second limit
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        // we will use a guard let to unwrap the searchbar.text property
        //because its an optional
        
        // dismiss keyboard
        
        searchBar.resignFirstResponder()

        guard let searchText = searchBar.text else {
            print("missing search text")
            return
        }
        // what does this code do ??
        searchRecipes(searchQuery: searchText)
    }
}
