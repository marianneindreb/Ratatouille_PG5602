import Foundation
import CoreData


class ArchivedIngredientsViewModel: ObservableObject {
    @Published var archivedIngredients: [IngredientModel] = []
    @Published var isLoading = false
    
    func getArchivedIngredients() {
        self.isLoading = true
        let context = CoreDataManager.shared.context
        let fetchRequest: NSFetchRequest<IngredientEntity> = IngredientEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "isArchived == %@", NSNumber(value: true))

        do {
            let ingredientsEntities = try context.fetch(fetchRequest)
            self.archivedIngredients = ingredientsEntities.map {
                IngredientModel(idIngredient: $0.idIngredient ?? "", strIngredient: $0.strIngredient ?? "")
            }
            self.isLoading = false
        } catch {
            print("Error fetching archived ingredient: \(error)")
        }
    }
    
    func restoreIngredient(strIngredient: String) {
        let context = CoreDataManager.shared.context
        let fetchRequest: NSFetchRequest<IngredientEntity> = IngredientEntity.fetchRequest()
        let predicate = NSPredicate(format: "strIngredient == %@", strIngredient)
        fetchRequest.predicate = predicate

        do {
            if let ingredientEntity = try context.fetch(fetchRequest).first {
                ingredientEntity.isArchived = false
                try context.save()
                print("Restored ingredient \(strIngredient)")
                getArchivedIngredients()
            }
        } catch {
            print("Error restoring ingredient \(strIngredient): \(error)")
        }
    }
    
    func deleteIngredient(strIngredient: String) {
        let context = CoreDataManager.shared.context
        let fetchRequest: NSFetchRequest<IngredientEntity> = IngredientEntity.fetchRequest()
        let predicate = NSPredicate(format: "strIngredient == %@", strIngredient)
        fetchRequest.predicate = predicate

        do {
            if let ingredientEntity = try context.fetch(fetchRequest).first {
                context.delete(ingredientEntity)
                try context.save()
                print("Deleted ingredient: \(strIngredient)")
                getArchivedIngredients()
            }
        } catch {
            print("Error deleting ingredient \(strIngredient): \(error)")
        }
    }
}
