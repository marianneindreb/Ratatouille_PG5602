import Foundation

struct IngredientModel: Decodable, Hashable {
    let idIngredient: String
    let strIngredient: String
    var isArchived: Bool? = false
}

struct IngredientsResponse: Decodable {
    let meals: [IngredientModel]
}
