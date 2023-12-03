import Foundation
import CoreData


class ArchivedMealsViewModel: ObservableObject {
    @Published var archivedMeals: [MealModel] = []
    @Published var isLoading = false
    //var meal: MealModel?
    
    func getArchivedMeals() {
        self.isLoading = true
        let context = CoreDataManager.shared.context
        let fetchRequest: NSFetchRequest<MealEntity> = MealEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "isArchived == %@", NSNumber(value: true))

        do {
            let mealsEntities = try context.fetch(fetchRequest)
            // TODO: Filter out archived.
            self.archivedMeals = mealsEntities.map {
                MealModel(from: $0)
            }
            self.isLoading = false
        } catch {
            print("Error fetching saved meals: \(error)")
        }
    }
    
    func restoreMeal(id: String) {
        let context = CoreDataManager.shared.context
        let fetchRequest: NSFetchRequest<MealEntity> = MealEntity.fetchRequest()
        let predicate = NSPredicate(format: "idMeal == %@", id)
        fetchRequest.predicate = predicate

        do {
            if let areaEntity = try context.fetch(fetchRequest).first {
                areaEntity.isArchived = false
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
            if let areaEntity = try context.fetch(fetchRequest).first {
                //TODO: Code for deleteing here
                try context.save()
                print("Deleted meal \(id)")
                getArchivedMeals()
            }
        } catch {
            print("Error deleteing meal \(id): \(error)")
        }
    }
}
