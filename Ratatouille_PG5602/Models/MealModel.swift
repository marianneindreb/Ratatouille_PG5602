import Foundation

struct MealModel: Decodable {
    var idMeal: String
    var strMeal: String
    var strDrinkAlternate: String?
    var strCategory: String
    var strArea: String
    var isArchived: Bool?
    var strInstructions: String
    var strMealThumb: String?
    var strTags: String?
    var strYoutube: String?
    var strIngredient1: String?
    var strIngredient2: String?
    var strIngredient3: String?
    var strIngredient4: String?
    var strIngredient5: String?
    var strIngredient6: String?
    var strIngredient7: String?
    var strIngredient8: String?
    var strIngredient9: String?
    var strIngredient10: String?
    var strIngredient11: String?
    var strIngredient12: String?
    var strIngredient13: String?
    var strIngredient14: String?
    var strIngredient15: String?
    var strIngredient16: String?
    var strIngredient17: String?
    var strIngredient18: String?
    var strIngredient19: String?
    var strIngredient20: String?
    var strMeasure1: String?
    var strMeasure2: String?
    var strMeasure3: String?
    var strMeasure4: String?
    var strMeasure5: String?
    var strMeasure6: String?
    var strMeasure7: String?
    var strMeasure8: String?
    var strMeasure9: String?
    var strMeasure10: String?
    var strMeasure11: String?
    var strMeasure12: String?
    var strMeasure13: String?
    var strMeasure14: String?
    var strMeasure15: String?
    var strMeasure16: String?
    var strMeasure17: String?
    var strMeasure18: String?
    var strMeasure19: String?
    var strMeasure20: String?
    var strSource: String?
    var strImageSource: String?
    var strCreativeCommonsConfirmed: String?
    var dateModified: String?
    
    static var sampleMeal: MealModel {
            MealModel(idMeal: "52772", strMeal: "Chicken TikkaMasala", strDrinkAlternate: nil, strCategory: "Chicken", strArea: "Indian", isArchived: false, strInstructions: "Del kyllingfileter i store biter.Ha yoghurt i en bolle og tilsett finhakket hvitløk, revet ingefær, sitronsaft, chilipulver, koriander, spisskummen og salt. Bland godt og legg i kyllingbitene. Sett bollen kaldt, helst over natten.Finhakk løk og hvitløk. Riv ingefær fint. Varm litt olje i en gryte og fres løk, hvitløk og ingefær på middels varme til løken begynner å bli gyllen. Tilsett, spisskummen, muskat, gurkemeie, chilipulver, garam masala, tomatpuré og hakkede tomater. Kok opp og la sausen koke noen minutter før du tilsetter fløten.Varm litt olje i en vid stekepanne med høy kant. Stek kyllingbitene i omganger til de endrer farge. Legg bitene over i sausen etter hvert. Tilsett resten av marinaden i sausen. Bland inn malte mandler. La det hele småkoke i ca. 10 minutter. Smak til med salt og mer krydder etter smak.Dryss over grovhakkede mandler og hakket frisk koriander ved servering. Vi har også pyntet med svarte sesamfrø. Server med ris, og gjerne også med nanbrød, raita og mangochutney.", strMealThumb: "https://www.themealdb.com/images/media/meals/ytuvwr1503070420.jpg",
                      strTags: nil, strYoutube: nil, strIngredient1: "løk", strIngredient2: "kylling", strIngredient3: "ris", strIngredient4: "kokosmelk", strIngredient5: nil, strIngredient6: nil, strIngredient7: nil, strIngredient8: nil, strIngredient9: nil, strIngredient10: nil, strIngredient11: nil, strIngredient12: nil, strIngredient13: nil, strIngredient14: nil, strIngredient15: nil, strIngredient16: nil, strIngredient17: nil, strIngredient18: nil, strIngredient19: nil, strIngredient20: nil, strMeasure1: "1stk", strMeasure2: "400g", strMeasure3: "3dl", strMeasure4: "3dl", strMeasure5: nil, strMeasure6: nil, strMeasure7: nil, strMeasure8: nil, strMeasure9: nil, strMeasure10: nil, strMeasure11: nil, strMeasure12: nil, strMeasure13: nil, strMeasure14: nil, strMeasure15: nil, strMeasure16: nil, strMeasure17: nil, strMeasure18: nil, strMeasure19: nil, strMeasure20: nil, strSource: nil, strImageSource: nil, strCreativeCommonsConfirmed: nil, dateModified: nil
            )
        }
    
    static let mealOne = MealModel(idMeal: "0001", strMeal: "Meal one", strDrinkAlternate: nil, strCategory: "Chicken", strArea: "Indian", isArchived: false, strInstructions: "Del kyllingfileter i store biter.Ha yoghurt i en bolle og tilsett finhakket hvitløk, revet ingefær, sitronsaft, chilipulver, koriander, spisskummen og salt. Bland godt og legg i kyllingbitene. Sett bollen kaldt, helst over natten.Finhakk løk og hvitløk. Riv ingefær fint. Varm litt olje i en gryte og fres løk, hvitløk og ingefær på middels varme til løken begynner å bli gyllen. Tilsett, spisskummen, muskat, gurkemeie, chilipulver, garam masala, tomatpuré og hakkede tomater. Kok opp og la sausen koke noen minutter før du tilsetter fløten.Varm litt olje i en vid stekepanne med høy kant. Stek kyllingbitene i omganger til de endrer farge. Legg bitene over i sausen etter hvert. Tilsett resten av marinaden i sausen. Bland inn malte mandler. La det hele småkoke i ca. 10 minutter. Smak til med salt og mer krydder etter smak.Dryss over grovhakkede mandler og hakket frisk koriander ved servering. Vi har også pyntet med svarte sesamfrø. Server med ris, og gjerne også med nanbrød, raita og mangochutney.", strMealThumb: "https://www.themealdb.com/images/media/meals/ytuvwr1503070420.jpg",
                                   strTags: nil, strYoutube: nil, strIngredient1: nil, strIngredient2: nil, strIngredient3: nil, strIngredient4: nil, strIngredient5: nil, strIngredient6: nil, strIngredient7: nil, strIngredient8: nil, strIngredient9: nil, strIngredient10: nil, strIngredient11: nil, strIngredient12: nil, strIngredient13: nil, strIngredient14: nil, strIngredient15: nil, strIngredient16: nil, strIngredient17: nil, strIngredient18: nil, strIngredient19: nil, strIngredient20: nil, strMeasure1: nil, strMeasure2: nil, strMeasure3: nil, strMeasure4: nil, strMeasure5: nil, strMeasure6: nil, strMeasure7: nil, strMeasure8: nil, strMeasure9: nil, strMeasure10: nil, strMeasure11: nil, strMeasure12: nil, strMeasure13: nil, strMeasure14: nil, strMeasure15: nil, strMeasure16: nil, strMeasure17: nil, strMeasure18: nil, strMeasure19: nil, strMeasure20: nil, strSource: nil, strImageSource: nil, strCreativeCommonsConfirmed: nil, dateModified: nil
                         )
    
    static let mealTwo = MealModel(idMeal: "0002", strMeal: "Meal two", strDrinkAlternate: nil, strCategory: "Chicken", strArea: "Indian", isArchived: false, strInstructions: "Del kyllingfileter i store biter.Ha yoghurt i en bolle og tilsett finhakket hvitløk, revet ingefær, sitronsaft, chilipulver, koriander, spisskummen og salt. Bland godt og legg i kyllingbitene. Sett bollen kaldt, helst over natten.Finhakk løk og hvitløk. Riv ingefær fint. Varm litt olje i en gryte og fres løk, hvitløk og ingefær på middels varme til løken begynner å bli gyllen. Tilsett, spisskummen, muskat, gurkemeie, chilipulver, garam masala, tomatpuré og hakkede tomater. Kok opp og la sausen koke noen minutter før du tilsetter fløten.Varm litt olje i en vid stekepanne med høy kant. Stek kyllingbitene i omganger til de endrer farge. Legg bitene over i sausen etter hvert. Tilsett resten av marinaden i sausen. Bland inn malte mandler. La det hele småkoke i ca. 10 minutter. Smak til med salt og mer krydder etter smak.Dryss over grovhakkede mandler og hakket frisk koriander ved servering. Vi har også pyntet med svarte sesamfrø. Server med ris, og gjerne også med nanbrød, raita og mangochutney.", strMealThumb: "https://www.themealdb.com/images/media/meals/ytuvwr1503070420.jpg",
                                   strTags: nil, strYoutube: nil, strIngredient1: nil, strIngredient2: nil, strIngredient3: nil, strIngredient4: nil, strIngredient5: nil, strIngredient6: nil, strIngredient7: nil, strIngredient8: nil, strIngredient9: nil, strIngredient10: nil, strIngredient11: nil, strIngredient12: nil, strIngredient13: nil, strIngredient14: nil, strIngredient15: nil, strIngredient16: nil, strIngredient17: nil, strIngredient18: nil, strIngredient19: nil, strIngredient20: nil, strMeasure1: nil, strMeasure2: nil, strMeasure3: nil, strMeasure4: nil, strMeasure5: nil, strMeasure6: nil, strMeasure7: nil, strMeasure8: nil, strMeasure9: nil, strMeasure10: nil, strMeasure11: nil, strMeasure12: nil, strMeasure13: nil, strMeasure14: nil, strMeasure15: nil, strMeasure16: nil, strMeasure17: nil, strMeasure18: nil, strMeasure19: nil, strMeasure20: nil, strSource: nil, strImageSource: nil, strCreativeCommonsConfirmed: nil, dateModified: nil
                         )
    static let mealThree = MealModel(idMeal: "0003", strMeal: "Meal three", strDrinkAlternate: nil, strCategory: "Chicken", strArea: "Indian", isArchived: false, strInstructions: "Del kyllingfileter i store biter.Ha yoghurt i en bolle og tilsett finhakket hvitløk, revet ingefær, sitronsaft, chilipulver, koriander, spisskummen og salt. Bland godt og legg i kyllingbitene. Sett bollen kaldt, helst over natten.Finhakk løk og hvitløk. Riv ingefær fint. Varm litt olje i en gryte og fres løk, hvitløk og ingefær på middels varme til løken begynner å bli gyllen. Tilsett, spisskummen, muskat, gurkemeie, chilipulver, garam masala, tomatpuré og hakkede tomater. Kok opp og la sausen koke noen minutter før du tilsetter fløten.Varm litt olje i en vid stekepanne med høy kant. Stek kyllingbitene i omganger til de endrer farge. Legg bitene over i sausen etter hvert. Tilsett resten av marinaden i sausen. Bland inn malte mandler. La det hele småkoke i ca. 10 minutter. Smak til med salt og mer krydder etter smak.Dryss over grovhakkede mandler og hakket frisk koriander ved servering. Vi har også pyntet med svarte sesamfrø. Server med ris, og gjerne også med nanbrød, raita og mangochutney.", strMealThumb: "https://www.themealdb.com/images/media/meals/ytuvwr1503070420.jpg",
                                   strTags: nil, strYoutube: nil, strIngredient1: nil, strIngredient2: nil, strIngredient3: nil, strIngredient4: nil, strIngredient5: nil, strIngredient6: nil, strIngredient7: nil, strIngredient8: nil, strIngredient9: nil, strIngredient10: nil, strIngredient11: nil, strIngredient12: nil, strIngredient13: nil, strIngredient14: nil, strIngredient15: nil, strIngredient16: nil, strIngredient17: nil, strIngredient18: nil, strIngredient19: nil, strIngredient20: nil, strMeasure1: nil, strMeasure2: nil, strMeasure3: nil, strMeasure4: nil, strMeasure5: nil, strMeasure6: nil, strMeasure7: nil, strMeasure8: nil, strMeasure9: nil, strMeasure10: nil, strMeasure11: nil, strMeasure12: nil, strMeasure13: nil, strMeasure14: nil, strMeasure15: nil, strMeasure16: nil, strMeasure17: nil, strMeasure18: nil, strMeasure19: nil, strMeasure20: nil, strSource: nil, strImageSource: nil, strCreativeCommonsConfirmed: nil, dateModified: nil
                         )
    static let savedMeals = [mealOne, mealTwo, mealThree]
}


    



extension MealModel {
    init(from entity: MealEntity) {
        idMeal = entity.idMeal ?? ""
        strMeal = entity.strMeal ?? ""
        strDrinkAlternate = entity.strDrinkAlternate
        strCategory = entity.strCategory ?? ""
        strArea = entity.strArea ?? ""
        isArchived = false
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
