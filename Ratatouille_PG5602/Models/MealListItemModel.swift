import Foundation

struct MealListItemModel: Decodable, Hashable {
    let strMeal : String
    let strMealThumb: String?
    let idMeal: String
    let isFavorited: Bool?
    
  static var sampleMealList: MealListItemModel {
      MealListItemModel(strMeal: "Chicken Alfredo Primavera", strMealThumb: "https://www.themealdb.com/images/media/meals/syqypv1486981727.jpg", idMeal: "52796", isFavorited: true)
    }
}

struct MealListItemResponse: Decodable {
    let meals: [MealListItemModel]
}



