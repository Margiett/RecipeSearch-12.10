//
//  RecipeCellTableViewCell.swift
//  RecipeSearch
//
//  Created by Margiett Gil on 12/12/19.
//  Copyright © 2019 Alex Paul. All rights reserved.
//

import UIKit

class RecipeCellTableViewCell: UITableViewCell {
    @IBOutlet weak var recipeImageView: UIImageView!
    @IBOutlet weak var recipeLabel: UILabel!
    
    func configureCell(for recipe: Recipe) {
        recipeLabel.text = recipe.label
        
        
        //set image for recipe
        
        // user a capture list example [weak self] or [unowned self]
        // to break strng (retain) reference cycles
        recipeImageView.getImage(with: recipe.image) { [weak self](result) in
            switch result {
            case . failure:
                DispatchQueue.main.async {
                    self?.recipeImageView.image = UIImage(systemName: "exclamationmark.triangle")
                }
            case .success(let image):
                // what thread are we on? global() background
                // we always use the dispatchqueue.main.async to view it in a different thread 
                DispatchQueue.main.async {
                // this make the pictures pop up on the phone !!
                    self?.recipeImageView.image = image
                }
            }
            
        }
        
    }
    
}
