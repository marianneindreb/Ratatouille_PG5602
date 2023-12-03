import Foundation
import CoreData


class ArchivedCategoriesViewModel: ObservableObject {
    @Published var archivedCategories: [CategoryModel] = []
    @Published var isLoading = false
    
    func getArchivedCategories() {
        self.isLoading = true
        let context = CoreDataManager.shared.context
        let fetchRequest: NSFetchRequest<CategoryEntity> = CategoryEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "isArchived == %@", NSNumber(value: true))

        do {
            let categoriesEntities = try context.fetch(fetchRequest)
            self.archivedCategories = categoriesEntities.map {
                CategoryModel(strCategory: $0.strCategory ?? "")
            }
            self.isLoading = false
        } catch {
            print("Error fetching archived category: \(error)")
        }
    }
    
    func restoreCategory(strCategory: String) {
        let context = CoreDataManager.shared.context
        let fetchRequest: NSFetchRequest<CategoryEntity> = CategoryEntity.fetchRequest()
        let predicate = NSPredicate(format: "strCategory == %@", strCategory)
        fetchRequest.predicate = predicate

        do {
            if let categoriesEntities = try context.fetch(fetchRequest).first {
                categoriesEntities.isArchived = false
                try context.save()
                print("Restored category \(strCategory)")
                getArchivedCategories()
            }
        } catch {
            print("Error restoring category \(strCategory): \(error)")
        }
    }
    
    func deleteCategory(strCategory: String) {
        let context = CoreDataManager.shared.context
        let fetchRequest: NSFetchRequest<CategoryEntity> = CategoryEntity.fetchRequest()
        let predicate = NSPredicate(format: "strCategory == %@", strCategory)
        fetchRequest.predicate = predicate

        do {
            if let categoriesEntity = try context.fetch(fetchRequest).first {
                context.delete(categoriesEntity)
                try context.save()
                print("Deleted category: \(strCategory)")
                getArchivedCategories()
            }
        } catch {
            print("Error deleting category \(strCategory): \(error)")
        }
    }
}
