import Foundation
import CoreData


class ArchivedMealsViewModel: ObservableObject {
    @Published var archivedMeals: [MealModel] = []
    @Published var isLoading = false
    
    func getArchivedMeals() {
        self.isLoading = true
        let context = CoreDataManager.shared.context
        let fetchRequest: NSFetchRequest<MealEntity> = MealEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "isArchived == %@", NSNumber(value: true))
        
        do {
            let mealsEntities = try context.fetch(fetchRequest)
            self.archivedMeals = mealsEntities.map {
                MealModel(from: $0)
            }
            self.isLoading = false
        } catch {
            print("Error fetching archived meals: \(error)")
        }
    }
    
    func restoreMeal(id: String) {
        let context = CoreDataManager.shared.context
        let fetchRequest: NSFetchRequest<MealEntity> = MealEntity.fetchRequest()
        let predicate = NSPredicate(format: "idMeal == %@", id)
        fetchRequest.predicate = predicate
        
        do {
            if let mealEntity = try context.fetch(fetchRequest).first {
                mealEntity.isArchived = false
                try context.save()
                print("Restored meal \(id)")
                getArchivedMeals()
            }
        } catch {
            print("Error restoring meal \(id): \(error)")
        }
    }
    
    func deleteMeal(id: String) {
        let context = CoreDataManager.shared.context
        let fetchRequest: NSFetchRequest<MealEntity> = MealEntity.fetchRequest()
        let predicate = NSPredicate(format: "idMeal == %@", id)
        fetchRequest.predicate = predicate
        
        do {
            if let mealEntity = try context.fetch(fetchRequest).first {
                context.delete(mealEntity)
                try context.save()
                print("Deleted meal \(id)")
                getArchivedMeals()
            }
        } catch {
            print("Error deleting meal \(id): \(error)")
        }
    }
}
