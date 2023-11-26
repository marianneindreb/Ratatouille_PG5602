import Foundation

struct MealModel: Decodable {
    let idMeal: String
    let strMeal: String
    let strDrinkAlternate: String?
    let strCategory: String
    let strArea: String
    let strInstructions: String
    let strMealThumb: String?
    let strTags: String?
    let strYoutube: String?
    let strIngredient1: String?
    let strIngredient2: String?
    let strIngredient3: String?
    let strIngredient4: String?
    let strIngredient5: String?
    let strIngredient6: String?
    let strIngredient7: String?
    let strIngredient8: String?
    let strIngredient9: String?
    let strIngredient10: String?
    let strIngredient11: String?
    let strIngredient12: String?
    let strIngredient13: String?
    let strIngredient14: String?
    let strIngredient15: String?
    let strIngredient16: String?
    let strIngredient17: String?
    let strIngredient18: String?
    let strIngredient19: String?
    let strIngredient20: String?
    let strMeasure1: String?
    let strMeasure2: String?
    let strMeasure3: String?
    let strMeasure4: String?
    let strMeasure5: String?
    let strMeasure6: String?
    let strMeasure7: String?
    let strMeasure8: String?
    let strMeasure9: String?
    let strMeasure10: String?
    let strMeasure11: String?
    let strMeasure12: String?
    let strMeasure13: String?
    let strMeasure14: String?
    let strMeasure15: String?
    let strMeasure16: String?
    let strMeasure17: String?
    let strMeasure18: String?
    let strMeasure19: String?
    let strMeasure20: String?
    let strSource: String?
    let strImageSource: String?
    let strCreativeCommonsConfirmed: String?
    let dateModified: String?
    
    static var sampleMeal: MealModel {
            MealModel(idMeal: "52772", strMeal: "Chicken TikkaMasala", strDrinkAlternate: nil, strCategory: "Chicken", strArea: "Indian", strInstructions: "Mix spices and cook chicken...", strMealThumb: "        https://www.themealdb.com/images/media/meals/ytuvwr1503070420.jpg",
                      strTags: nil, strYoutube: nil, strIngredient1: nil, strIngredient2: nil, strIngredient3: nil, strIngredient4: nil, strIngredient5: nil, strIngredient6: nil, strIngredient7: nil, strIngredient8: nil, strIngredient9: nil, strIngredient10: nil, strIngredient11: nil, strIngredient12: nil, strIngredient13: nil, strIngredient14: nil, strIngredient15: nil, strIngredient16: nil, strIngredient17: nil, strIngredient18: nil, strIngredient19: nil, strIngredient20: nil, strMeasure1: nil, strMeasure2: nil, strMeasure3: nil, strMeasure4: nil, strMeasure5: nil, strMeasure6: nil, strMeasure7: nil, strMeasure8: nil, strMeasure9: nil, strMeasure10: nil, strMeasure11: nil, strMeasure12: nil, strMeasure13: nil, strMeasure14: nil, strMeasure15: nil, strMeasure16: nil, strMeasure17: nil, strMeasure18: nil, strMeasure19: nil, strMeasure20: nil, strSource: nil, strImageSource: nil, strCreativeCommonsConfirmed: nil, dateModified: nil
            )
        }
}


    



extension MealModel {
    init(from entity: MealEntity) {
        idMeal = entity.idMeal ?? ""
        strMeal = entity.strMeal ?? ""
        strDrinkAlternate = entity.strDrinkAlternate
        strCategory = entity.strCategory ?? ""
        strArea = entity.strArea ?? ""
        strInstructions = entity.strInstructions ?? ""
        strMealThumb = entity.strMealThumb
        strTags = entity.strTags
        strYoutube = entity.strYoutube
        strIngredient1 = entity.strIngredient1
        strIngredient2 = entity.strIngredient2
        strIngredient3 = entity.strIngredient3
        strIngredient4 = entity.strIngredient4
        strIngredient5 = entity.strIngredient5
        strIngredient6 = entity.strIngredient6
        strIngredient7 = entity.strIngredient7
        strIngredient8 = entity.strIngredient8
        strIngredient9 = entity.strIngredient9
        strIngredient10 = entity.strIngredient10
        strIngredient11 = entity.strIngredient11
        strIngredient12 = entity.strIngredient12
        strIngredient13 = entity.strIngredient13
        strIngredient14 = entity.strIngredient14
        strIngredient15 = entity.strIngredient15
        strIngredient16 = entity.strIngredient16
        strIngredient17 = entity.strIngredient17
        strIngredient18 = entity.strIngredient18
        strIngredient19 = entity.strIngredient19
        strIngredient20 = entity.strIngredient20
        strMeasure1 = entity.strMeasure1
        strMeasure2 = entity.strMeasure2
        strMeasure3 = entity.strMeasure3
        strMeasure4 = entity.strMeasure4
        strMeasure5 = entity.strMeasure5
        strMeasure6 = entity.strMeasure6
        strMeasure7 = entity.strMeasure7
        strMeasure8 = entity.strMeasure8
        strMeasure9 = entity.strMeasure9
        strMeasure10 = entity.strMeasure10
        strMeasure11 = entity.strMeasure11
        strMeasure12 = entity.strMeasure12
        strMeasure13 = entity.strMeasure13
        strMeasure14 = entity.strMeasure14
        strMeasure15 = entity.strMeasure15
        strMeasure16 = entity.strMeasure16
        strMeasure17 = entity.strMeasure17
        strMeasure18 = entity.strMeasure18
        strMeasure19 = entity.strMeasure19
        strMeasure20 = entity.strMeasure20
        strSource = entity.strSource
        strImageSource = entity.strImageSource
        strCreativeCommonsConfirmed = entity.strCreativeCommonsConfirmed
        dateModified = entity.dateModified
    }
}

struct MealResponse: Decodable {
    let meals: [MealModel]
}
