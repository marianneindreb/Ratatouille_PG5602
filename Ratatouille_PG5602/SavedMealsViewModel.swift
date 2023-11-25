import Foundation
import CoreData


class SavedMealsViewModel: ObservableObject {
    @Published var savedMeals: [MealModel] = []

    func getSavedMeals() {
        let context = CoreDataManager.shared.context
        let fetchRequest: NSFetchRequest<MealEntity> = MealEntity.fetchRequest()

        do {
            let mealsEntities = try context.fetch(fetchRequest)
            self.savedMeals = mealsEntities.map { MealModel(from: $0) }
        } catch {
            print("Error fetching saved meals: \(error)")
        }
    }
    
    func archiveMeal(_ mealId: String) {
       // TODO: 
        // logic, updating to core data entities
    }
}
