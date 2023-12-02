import Foundation
import CoreData


class SavedMealsViewModel: ObservableObject {
    @Published var savedMeals: [MealModel] = []
    @Published var isLoading = false
    
    func getSavedMeals() {
        isLoading = true
        let context = CoreDataManager.shared.context
        let fetchRequest: NSFetchRequest<MealEntity> = MealEntity.fetchRequest()

        do {
            let mealsEntities = try context.fetch(fetchRequest)
            //TODO: Filter out archived.
            self.savedMeals = mealsEntities.map {
                MealModel(from: $0)
            }
            isLoading = false
        } catch {
            print("Error fetching saved meals: \(error)")
        }
    }
    
    func archiveMeal() {
       // TODO: 
        // logic, updating to core data entities
    }
}
