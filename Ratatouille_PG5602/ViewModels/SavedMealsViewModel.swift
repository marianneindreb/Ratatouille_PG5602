import Foundation
import CoreData


class SavedMealsViewModel: ObservableObject {
    @Published var savedMeals: [MealListItemModel] = []
    @Published var isLoading = false

    func saveMeal(_ meal: MealListItemModel) {
    let context = CoreDataManager.shared.context
       let savedMealEntity = MealEntity(context: context)

       savedMealEntity.idMeal = meal.idMeal
       savedMealEntity.strMeal = meal.strMeal

       do {
           try context.save()
           savedMeals.append(meal)
       } catch {
           print("Error saving meal: \(error)")
       }
   }
    
    func getSavedMeals() {
        isLoading = true
        let context = CoreDataManager.shared.context
        let fetchRequest: NSFetchRequest<MealEntity> = MealEntity.fetchRequest()

        do {
            let mealsEntities = try context.fetch(fetchRequest)
            self.savedMeals = mealsEntities.map { MealListItemModel(from: $0) }
            isLoading = false
        } catch {
            print("Error fetching saved meals: \(error)")
        }
    }
    
    func archiveMeal(_ mealId: String) {
       // TODO: 
        // logic, updating to core data entities
    }
}
