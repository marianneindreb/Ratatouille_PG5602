import SwiftUI
import CoreData

//@Observable
final class MealDetailViewModel: ObservableObject {
   @Published var meal: MealModel?
    
    init(meal: MealModel) {
        self.meal = meal
    }
    
    init(id: String) {
        self.fetchMeal(mealId: id)
    }
    
    init() {}
    
    func fetchAndSaveMeal(id: String) {
        self.fetchMeal(mealId: id, onCompletion: self.saveMeal)
    }
    
    func updateMeal(mealId: String, title: String, description: String, imageUrl: String, ingredients: [String]) {
        let context = CoreDataManager.shared.context
        let fetchRequest: NSFetchRequest<MealEntity> = MealEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "idMeal == %@", mealId)

        do {
            if let mealEntity = try context.fetch(fetchRequest).first {
                mealEntity.strMeal = title
                mealEntity.strInstructions = description
                mealEntity.strMealThumb = imageUrl
                
                mealEntity.strIngredient1 = ingredients.count > 0 ? ingredients[0] : nil
                mealEntity.strIngredient2 = ingredients.count > 1 ? ingredients[1] : nil
                mealEntity.strIngredient3 = ingredients.count > 2 ? ingredients[2] : nil
                mealEntity.strIngredient4 = ingredients.count > 3 ? ingredients[3] : nil
                mealEntity.strIngredient5 = ingredients.count > 4 ? ingredients[4] : nil
                mealEntity.strIngredient6 = ingredients.count > 5 ? ingredients[5] : nil
                mealEntity.strIngredient7 = ingredients.count > 6 ? ingredients[6] : nil
                mealEntity.strIngredient8 = ingredients.count > 7 ? ingredients[7] : nil
                mealEntity.strIngredient9 = ingredients.count > 8 ? ingredients[8] : nil
                mealEntity.strIngredient10 = ingredients.count > 9 ? ingredients[9] : nil
                mealEntity.strIngredient11 = ingredients.count > 10 ? ingredients[10] : nil
                mealEntity.strIngredient12 = ingredients.count > 11 ? ingredients[11] : nil
                mealEntity.strIngredient13 = ingredients.count > 12 ? ingredients[12] : nil
                mealEntity.strIngredient14 = ingredients.count > 13 ? ingredients[13] : nil
                mealEntity.strIngredient15 = ingredients.count > 14 ? ingredients[14] : nil
                mealEntity.strIngredient16 = ingredients.count > 15 ? ingredients[15] : nil
                mealEntity.strIngredient17 = ingredients.count > 16 ? ingredients[16] : nil
                mealEntity.strIngredient18 = ingredients.count > 17 ? ingredients[17] : nil
                mealEntity.strIngredient19 = ingredients.count > 18 ? ingredients[18] : nil
                mealEntity.strIngredient20 = ingredients.count > 19 ? ingredients[19] : nil

                try context.save()
                print("Meal updated successfully")
            } else {
                print("Meal not found in Core Data")
            }
        } catch {
            print("Error updating meal: \(error)")
        }
    }
    
    func fetchMeal(mealId: String, onCompletion: (() -> Void)? = nil) {
        print("Fetching meal \(mealId)")
        let urlString = "https://www.themealdb.com/api/json/v1/1/lookup.php?i=\(mealId)"
        NetworkManager.shared.fetchData(from: urlString) { [weak self] result in
            switch result {
            case .success(let data):
                self?.parseMealDataAndSetVariable(data)
                onCompletion?()
            case .failure:
                print("Something went wrong fetching meal with mealId \(mealId)")
            }
        }
    }
    func loadMealFromCoreData(id: String){
        self.meal = getMealFromCoreData(id: id)
    }
    
    func getMealFromCoreData(id: String) -> MealModel? {
        let context = CoreDataManager.shared.context
        let fetchRequest: NSFetchRequest<MealEntity> = MealEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "isArchived == %@", NSNumber(value: false))
        
        do {
            let mealEntity = try context.fetch(fetchRequest)
            if mealEntity.isEmpty {
                print("Meal with mealId \(id) not found in Core Data")
            } else {
                let mealMapped = mealEntity.first.map {
                    MealModel(from: $0)
                }
                return mealMapped!
            }
        } catch {
            print("Error getting meal with id \(id) from Core Data: \(error)")
            return nil
        }
        return nil
    }

    
    func saveMeal() {
        if let meal = self.meal {
            let context = CoreDataManager.shared.context
            let savedMealEntity = MealEntity(context: context)
            // TODO: ikke lagre måltid om identisk (ikke endret av bruker) allerede eksisterer i databasen.
            savedMealEntity.idMeal = meal.idMeal
            savedMealEntity.strMeal = meal.strMeal
            savedMealEntity.strMealThumb = meal.strMealThumb
            savedMealEntity.isArchived = false
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
