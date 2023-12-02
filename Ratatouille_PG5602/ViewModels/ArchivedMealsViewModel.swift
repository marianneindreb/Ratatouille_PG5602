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
}
