import Foundation

struct IngredientModel: Decodable {
    let idIngredient: String
    let strIngredient: String
    var isArchived: Bool? = false
}

struct IngredientsResponse: Decodable {
    let meals: [IngredientModel]
}
