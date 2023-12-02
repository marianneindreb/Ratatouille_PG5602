import Foundation
import CoreData


class ArchiveViewModel: ObservableObject {
    @Published var archivedMeals: [MealModel] = []
    @Published var isLoading = false
    //var meal: MealModel?
    
    func getArchivedMeals() {
        isLoading = true
        let context = CoreDataManager.shared.context
        let fetchRequest: NSFetchRequest<MealEntity> = MealEntity.fetchRequest()

        do {
            let mealsEntities = try context.fetch(fetchRequest)
            //TODO: Filter out archived.
            self.archivedMeals = mealsEntities.map {
                MealModel(from: $0)
            }.filter {
                $0.isArchived == true
            }
            isLoading = false
        } catch {
            print("Error fetching archived meals: \(error)")
        }
    }
}
