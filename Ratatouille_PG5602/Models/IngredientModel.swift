//
//  IngredientModel.swift
//  Ratatouille_PG5602
//
//  Created by Marianne Indrebø on 21/11/2023.
//

import Foundation

struct IngredientModel: Decodable {
    let idMeal: String
    let strMeal: String
    let strsMealThumb: String
}

struct IngredientResponse: Decodable {
    let ingredientMeals: [IngredientModel]
}
