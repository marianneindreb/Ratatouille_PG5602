import Foundation

struct MealListItemModel: Decodable, Hashable, Identifiable {
    var id: String {idMeal}
    
    let strMeal : String
    let strMealThumb: String?
    let idMeal: String
   // let isFavorited: Bool?
    
  static var sampleMealList: MealListItemModel {
      MealListItemModel(strMeal: "Chicken Alfredo Primavera", strMealThumb: "https://www.themealdb.com/images/media/meals/syqypv1486981727.jpg", idMeal: "52796")
    }
}

struct MealListItemResponse: Decodable {
    let meals: [MealListItemModel]
}


extension MealListItemModel {
    init(from entity: MealEntity) {
        self.idMeal = entity.idMeal ?? ""
        self.strMeal = entity.strMeal ?? ""
        self.strMealThumb = entity.strMealThumb
    }
}
