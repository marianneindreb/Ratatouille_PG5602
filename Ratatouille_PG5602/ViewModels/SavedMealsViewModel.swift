import CoreData
import Foundation

class SavedMealsViewModel: ObservableObject {
    @Published var savedMeals: [MealModel] = []
    @Published var isLoading = false

    func getSavedMeals() {
        self.isLoading = true
        let context = CoreDataManager.shared.context
        let fetchRequest: NSFetchRequest<MealEntity> = MealEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "isArchived == %@", NSNumber(value: false))

        do {
            let mealsEntities = try context.fetch(fetchRequest)
            self.savedMeals = mealsEntities.map {
                MealModel(from: $0)
            }
            self.isLoading = false
        } catch {
            print("Error fetching saved meals: \(error)")
        }
    }

    func archiveMeal(id: String) {
        let context = CoreDataManager.shared.context
        let fetchRequest: NSFetchRequest<MealEntity> = MealEntity.fetchRequest()
        let predicate = NSPredicate(format: "idMeal == %@", id)
        fetchRequest.predicate = predicate

        do {
            if let mealEntity = try context.fetch(fetchRequest).first {
                mealEntity.isArchived = true
                try context.save()
                print("Archived meal \(id)")
                self.getSavedMeals()
            }
        } catch {
            print("Error archiving meal: \(error)")
        }
    }
}
