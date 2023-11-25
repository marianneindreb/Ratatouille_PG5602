import Foundation

struct IngredientModel: Decodable {
    let ingredientId: String
    let strIngredient: String
    let isArchived: Bool
}

struct IngredientsResponse: Decodable {
    let ingredientMeals: [IngredientModel]
}
