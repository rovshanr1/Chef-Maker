//
//  IngredientImageExtension.swift
//  Chef Maker
//
//  Created by Rovshan Rasulov on 29.04.25.
//

import Foundation

extension Ingredient {
    var imageUrl: URL? {
        guard let image = self.image, !image.isEmpty else { return nil }
        return URL(string: "https://spoonacular.com/cdn/ingredients_500x500/\(image)")
    }
}
