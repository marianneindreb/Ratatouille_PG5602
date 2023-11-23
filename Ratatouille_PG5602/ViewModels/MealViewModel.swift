import Foundation
import CoreData

class MealViewModel {
    private var meal: MealModel
   
    var onErrorHandling: ((Error) -> Void)?
    var onFetchCompleted: (() -> Void)?
    
    func fetchMeal(mealId: String) {
        let urlString = "https://www.themealdb.com/api/json/v1/1/lookup.php?i=\(mealId)"
        NetworkManager.shared.fetchData(from: urlString) { [weak self] result in
            switch result {
            case .success(let data):
                self?.parseMealData(data)
            case .failure(let error):
                self?.onErrorHandling?(error)
            }
        }
    }
    
    private func parseMealData(_ data: Data) {
        do {
            let mealResponse = try JSONDecoder().decode(MealResponse.self, from: data)
            self.meal = mealResponse.meal
            self.onFetchCompleted?()
        } catch {
            self.onErrorHandling?(error)
        }
    }
    
}

extension MealViewModel {
    func saveMealToCoreData() {
        let context = CoreDataManager.shared.context
        let mealEntity = MealEntity(context: context)
        mealEntity.idMeal = meal.idMeal
        mealEntity.strMeal = meal.strMeal
        mealEntity.dateModified = meal.dateModified
        mealEntity.strArea = meal.strArea
        mealEntity.strMealThumb = meal.strMealThumb
        mealEntity.strCategory = meal.strCategory
        mealEntity.strSource = meal.strSource
        mealEntity.strTags = meal.strTags
        mealEntity.strYoutube = meal.strYoutube
        mealEntity.strMeasure1 = meal.strMeasure1
        mealEntity.strMeasure2 = meal.strMeasure2
        mealEntity.strMeasure3 = meal.strMeasure3
        mealEntity.strMeasure4 = meal.strMeasure4
        mealEntity.strMeasure5 = meal.strMeasure5
        mealEntity.strMeasure6 = meal.strMeasure6
        mealEntity.strMeasure7 = meal.strMeasure7
        mealEntity.strMeasure8 = meal.strMeasure8
        mealEntity.strMeasure9 = meal.strMeasure9
        mealEntity.strMeasure10 = meal.strMeasure10
        mealEntity.strMeasure11 = meal.strMeasure11
        mealEntity.strMeasure12 = meal.strMeasure12
        mealEntity.strMeasure13 = meal.strMeasure13
        mealEntity.strMeasure14 = meal.strMeasure14
        mealEntity.strMeasure15 = meal.strMeasure15
        mealEntity.strMeasure16 = meal.strMeasure16
        mealEntity.strMeasure17 = meal.strMeasure17
        mealEntity.strMeasure18 = meal.strMeasure18
        mealEntity.strMeasure19 = meal.strMeasure19
        mealEntity.strMeasure20 = meal.strMeasure20
        mealEntity.strCreativeCommonsConfirmed = meal.strCreativeCommonsConfirmed
        mealEntity.strDrinkAlternate = meal.strDrinkAlternate
        mealEntity.strImageSource = meal.strImageSource
        mealEntity.strIngredient1 = meal.strIngredient1
        mealEntity.strIngredient2 = meal.strIngredient2
        mealEntity.strIngredient3 = meal.strIngredient3
        mealEntity.strIngredient4 = meal.strIngredient4
        mealEntity.strIngredient5 = meal.strIngredient5
        mealEntity.strIngredient6 = meal.strIngredient6
        mealEntity.strIngredient7 = meal.strIngredient7
        mealEntity.strIngredient8 = meal.strIngredient8
        mealEntity.strIngredient9 = meal.strIngredient9
        mealEntity.strIngredient10 = meal.strIngredient10
        mealEntity.strIngredient11 = meal.strIngredient11
        mealEntity.strIngredient12 = meal.strIngredient12
        mealEntity.strIngredient13 = meal.strIngredient13
        mealEntity.strIngredient14 = meal.strIngredient14
        mealEntity.strIngredient15 = meal.strIngredient15
        mealEntity.strIngredient16 = meal.strIngredient16
        mealEntity.strIngredient17 = meal.strIngredient17
        mealEntity.strIngredient18 = meal.strIngredient18
        mealEntity.strIngredient19 = meal.strIngredient19
        mealEntity.strIngredient20 = meal.strIngredient20
        mealEntity.strInstructions = meal.strInstructions
        
        
        
        
        
        CoreDataManager.shared.saveContext()
    }

    private func deleteMeal(in context: NSManagedObjectContext) {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = MealEntity.fetchRequest()
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)

        do {
            try context.execute(deleteRequest)
        } catch let error as NSError {
            print("Error deleting existing records: \(error), \(error.userInfo)")
        }
    }
}




