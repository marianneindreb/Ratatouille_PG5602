import Foundation
import CoreData

class CategoriesViewModel {
    private var categories: [CategoryModel] = []
   
    var onErrorHandling: ((Error) -> Void)?
    var onFetchCompleted: (() -> Void)?
    
    func fetchCategories() {
        let urlString = "https://www.themealdb.com/api/json/v1/1/categories.php"
        NetworkManager.shared.fetchData(from: urlString) { [weak self] result in
            switch result {
            case .success(let data):
                self?.parseCategoryData(data)
            case .failure(let error):
                self?.onErrorHandling?(error)
            }
        }
    }
    
    private func parseCategoryData(_ data: Data) {
        do {
            let categoryResponse = try JSONDecoder().decode(CategoriesResponse.self, from: data)
            self.categories = categoryResponse.categories
            self.onFetchCompleted?()
        } catch {
            self.onErrorHandling?(error)
        }
    }
    
    var numberOfCategories: Int {
        return categories.count
    }
    
    func category(at index: Int) -> CategoryModel? {
        guard index >= 0 && index < categories.count else {
            return nil
        }
        return categories[index]
    }
    
    func saveCategoriesToCoreData() {
        guard categories.count > 0 else {
            return
        }
        
        let context = CoreDataManager.shared.context
        for category in categories {
            
            let categoryEntity = CategoryEntity(context: context)
            categoryEntity.strCategory = category.strCategory
            categoryEntity.idCategory = category.idCategory
            categoryEntity.strCategoryThumb = category.strCategoryThumb
            categoryEntity.strCategoryDescription = category.strCategoryDescription
        }
        CoreDataManager.shared.saveContext()
    }

    private func deleteAllCategories(in context: NSManagedObjectContext) {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = CategoryEntity.fetchRequest()
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)

        do {
            try context.execute(deleteRequest)
        } catch let error as NSError {
            print("Error deleting existing records: \(error), \(error.userInfo)")
        }
    }
    
}






