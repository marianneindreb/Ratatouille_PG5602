import SwiftUI

@Observable
final class MealDetailViewModel {
    var meal: MealModel?
    
    init(meal: MealModel) {
        self.meal = meal
    }
    
    init(id: String) {
        fetchMeal(mealId: id)
    }
    
    init(){}
    
    func fetchAndSaveMeal(id: String){
        self.fetchMeal(mealId: id, onCompletion: self.saveMeal)
    }
    
    func fetchMeal(mealId: String, onCompletion: (() -> Void)? = nil) {
        print("Fetching meal \(mealId)")
        let urlString = "https://www.themealdb.com/api/json/v1/1/lookup.php?i=\(mealId)"
        NetworkManager.shared.fetchData(from: urlString) { [weak self] result in
            switch result {
            case .success(let data):
                self?.parseMealDataAndSetVariable(data)
                onCompletion?()
            case .failure(_):
                print("Something went wrong fetching meal with mealId \(mealId)")
                break
            }
        }
    }
    
    func saveMeal(){
        if let meal = self.meal {
           let context = CoreDataManager.shared.context
           let savedMealEntity = MealEntity(context: context)

           savedMealEntity.idMeal = meal.idMeal
           savedMealEntity.strMeal = meal.strMeal
           savedMealEntity.strMealThumb = meal.strMealThumb
            savedMealEntity.strDrinkAlternate = meal.strDrinkAlternate
            savedMealEntity.strCategory = meal.strCategory
            savedMealEntity.strInstructions = meal.strInstructions
            savedMealEntity.strTags = meal.strTags
            savedMealEntity.strArea = meal.strArea
            savedMealEntity.strYoutube = meal.strYoutube
            savedMealEntity.strIngredient1 = meal.strIngredient1
            savedMealEntity.strIngredient2 = meal.strIngredient2
            savedMealEntity.strIngredient3 = meal.strIngredient3
            savedMealEntity.strIngredient4 = meal.strIngredient4
            savedMealEntity.strIngredient5 = meal.strIngredient5
            savedMealEntity.strIngredient6 = meal.strIngredient6
            savedMealEntity.strIngredient7 = meal.strIngredient7
            savedMealEntity.strIngredient8 = meal.strIngredient8
            savedMealEntity.strIngredient9 = meal.strIngredient9
            savedMealEntity.strIngredient10 = meal.strIngredient10
            savedMealEntity.strIngredient11 = meal.strIngredient11
            savedMealEntity.strIngredient12 = meal.strIngredient12
            savedMealEntity.strIngredient13 = meal.strIngredient13
            savedMealEntity.strIngredient14 = meal.strIngredient14
            savedMealEntity.strIngredient15 = meal.strIngredient15
            savedMealEntity.strIngredient16 = meal.strIngredient16
            savedMealEntity.strIngredient17 = meal.strIngredient17
            savedMealEntity.strIngredient18 = meal.strIngredient18
            savedMealEntity.strIngredient19 = meal.strIngredient19
            savedMealEntity.strIngredient20 = meal.strIngredient20
            savedMealEntity.strMeasure1 = meal.strMeasure1
            savedMealEntity.strMeasure2 = meal.strMeasure2
            savedMealEntity.strMeasure3 = meal.strMeasure3
            savedMealEntity.strMeasure4 = meal.strMeasure4
            savedMealEntity.strMeasure5 = meal.strMeasure5
            savedMealEntity.strMeasure6 = meal.strMeasure6
            savedMealEntity.strMeasure7 = meal.strMeasure7
            savedMealEntity.strMeasure8 = meal.strMeasure8
            savedMealEntity.strMeasure9 = meal.strMeasure9
            savedMealEntity.strMeasure10 = meal.strMeasure10
            savedMealEntity.strMeasure11 = meal.strMeasure11
            savedMealEntity.strMeasure12 = meal.strMeasure12
            savedMealEntity.strMeasure13 = meal.strMeasure13
            savedMealEntity.strMeasure14 = meal.strMeasure14
            savedMealEntity.strMeasure15 = meal.strMeasure15
            savedMealEntity.strMeasure16 = meal.strMeasure16
            savedMealEntity.strMeasure17 = meal.strMeasure17
            savedMealEntity.strMeasure18 = meal.strMeasure18
            savedMealEntity.strMeasure19 = meal.strMeasure19
            savedMealEntity.strMeasure20 = meal.strMeasure20
            savedMealEntity.strSource = meal.strSource
            savedMealEntity.strImageSource = meal.strImageSource
            savedMealEntity.strCreativeCommonsConfirmed = meal.strCreativeCommonsConfirmed
            savedMealEntity.dateModified = meal.dateModified
            
           do {
               try context.save()
           } catch {
               print("Error saving meal: \(error)")
           }
        }
    }
    
    private func parseMealDataAndSetVariable(_ data: Data) {
        do {
            let mealResponse = try JSONDecoder().decode(MealResponse.self, from: data)
            if let firstMeal = mealResponse.meals.first {
                self.meal = firstMeal
            }
        } catch {
            print("Error parsing meal: \(error)")
        }
    }
}
