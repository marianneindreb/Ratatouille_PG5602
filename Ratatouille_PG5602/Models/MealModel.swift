//
//  MealModel.swift
//  Ratatouille_PG5602
//
//  Created by Marianne Indrebø on 18/11/2023.
//

import Foundation

struct Meal: Decodable {
    let idMeal: String
    let strMeal: String
    let strCategory: String
    let strArea: String
    let strInstructions: String
    let strImageSource: [String]?
}

struct MealResponse: Decodable {
    let meals: [Meal]
}

struct MockData {
    static let sampleMeal = Meal(idMeal: "0001", strMeal: "Test Meal", strCategory: "Vegetarian", strArea: "Norway", strInstructions: "This is sample instructions", strImageSource: [""])
    
    static let meals = [sampleMeal, sampleMeal, sampleMeal, sampleMeal]
}
