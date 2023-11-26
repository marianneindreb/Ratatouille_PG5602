import Foundation

struct MealListItemModel: Decodable, Hashable {
    let strMeal : String
    let strMealThumb: String
    let idMeal: String
}

struct MealListItemResponse: Decodable {
    let meals: [MealListItemModel]
}


