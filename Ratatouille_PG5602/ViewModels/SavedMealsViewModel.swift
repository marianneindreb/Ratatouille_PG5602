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
            }.filter {
                !$0.isArchived
            }
            isLoading = false
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
               self.savedMeals = self.savedMeals.filter { $0.idMeal != id}
           }
       } catch {
           print("Error archiving meal: \(error)")
       }
      
    }
}
