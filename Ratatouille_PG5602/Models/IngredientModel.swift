import Foundation

struct IngredientModel: Decodable {
    let idIngredient: String
    let strIngredient: String
    
}

struct IngredientsResponse: Decodable {
    let meals: [IngredientModel]
}
