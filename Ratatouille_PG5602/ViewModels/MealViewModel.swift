import Foundation
import CoreData

class MealViewModel: ObservableObject {
    private var meals: MealModel?
   
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
            if let firstMeal = mealResponse.meals.first {
                self.meals = firstMeal
                self.onFetchCompleted?()
            }
        } catch {
            self.onErrorHandling?(error)
        }
    }
}

extension MealViewModel {
    func saveMealToCoreData() {
        guard let unwrappedMeal = meals else {
            return
        }
        
        let context = CoreDataManager.shared.context
        let mealEntity = MealEntity(context: context)
        mealEntity.idMeal = unwrappedMeal.idMeal
        mealEntity.strMeal = unwrappedMeal.strMeal
        mealEntity.dateModified = unwrappedMeal.dateModified
        mealEntity.strArea = unwrappedMeal.strArea
        mealEntity.strMealThumb = unwrappedMeal.strMealThumb
        mealEntity.strCategory = unwrappedMeal.strCategory
        mealEntity.strSource = unwrappedMeal.strSource
        mealEntity.strTags = unwrappedMeal.strTags
        mealEntity.strYoutube = unwrappedMeal.strYoutube
        mealEntity.strMeasure1 = unwrappedMeal.strMeasure1
        mealEntity.strMeasure2 = unwrappedMeal.strMeasure2
        mealEntity.strMeasure3 = unwrappedMeal.strMeasure3
        mealEntity.strMeasure4 = unwrappedMeal.strMeasure4
        mealEntity.strMeasure5 = unwrappedMeal.strMeasure5
        mealEntity.strMeasure6 = unwrappedMeal.strMeasure6
        mealEntity.strMeasure7 = unwrappedMeal.strMeasure7
        mealEntity.strMeasure8 = unwrappedMeal.strMeasure8
        mealEntity.strMeasure9 = unwrappedMeal.strMeasure9
        mealEntity.strMeasure10 = unwrappedMeal.strMeasure10
        mealEntity.strMeasure11 = unwrappedMeal.strMeasure11
        mealEntity.strMeasure12 = unwrappedMeal.strMeasure12
        mealEntity.strMeasure13 = unwrappedMeal.strMeasure13
        mealEntity.strMeasure14 = unwrappedMeal.strMeasure14
        mealEntity.strMeasure15 = unwrappedMeal.strMeasure15
        mealEntity.strMeasure16 = unwrappedMeal.strMeasure16
        mealEntity.strMeasure17 = unwrappedMeal.strMeasure17
        mealEntity.strMeasure18 = unwrappedMeal.strMeasure18
        mealEntity.strMeasure19 = unwrappedMeal.strMeasure19
        mealEntity.strMeasure20 = unwrappedMeal.strMeasure20
        mealEntity.strCreativeCommonsConfirmed = unwrappedMeal.strCreativeCommonsConfirmed
        mealEntity.strDrinkAlternate = unwrappedMeal.strDrinkAlternate
        mealEntity.strImageSource = unwrappedMeal.strImageSource
        mealEntity.strIngredient1 = unwrappedMeal.strIngredient1
        mealEntity.strIngredient2 = unwrappedMeal.strIngredient2
        mealEntity.strIngredient3 = unwrappedMeal.strIngredient3
        mealEntity.strIngredient4 = unwrappedMeal.strIngredient4
        mealEntity.strIngredient5 = unwrappedMeal.strIngredient5
        mealEntity.strIngredient6 = unwrappedMeal.strIngredient6
        mealEntity.strIngredient7 = unwrappedMeal.strIngredient7
        mealEntity.strIngredient8 = unwrappedMeal.strIngredient8
        mealEntity.strIngredient9 = unwrappedMeal.strIngredient9
        mealEntity.strIngredient10 = unwrappedMeal.strIngredient10
        mealEntity.strIngredient11 = unwrappedMeal.strIngredient11
        mealEntity.strIngredient12 = unwrappedMeal.strIngredient12
        mealEntity.strIngredient13 = unwrappedMeal.strIngredient13
        mealEntity.strIngredient14 = unwrappedMeal.strIngredient14
        mealEntity.strIngredient15 = unwrappedMeal.strIngredient15
        mealEntity.strIngredient16 = unwrappedMeal.strIngredient16
        mealEntity.strIngredient17 = unwrappedMeal.strIngredient17
        mealEntity.strIngredient18 = unwrappedMeal.strIngredient18
        mealEntity.strIngredient19 = unwrappedMeal.strIngredient19
        mealEntity.strIngredient20 = unwrappedMeal.strIngredient20
        mealEntity.strInstructions = unwrappedMeal.strInstructions
        
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




