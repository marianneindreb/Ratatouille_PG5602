import CoreData
import Foundation
import SwiftUI

// @Observable
final class CategoriesViewModel: ObservableObject {
    @Published var categories: [CategoryModel] = []
    @Published var meals: [MealListItemModel] = []
    @Published var searchText = ""
    @Published var editingCategory: String? = nil
    
    enum LoadFrom {
        case API
        case coreData
    }
    
    var onErrorHandling: ((Error) -> Void)?
    var onFetchCompleted: (() -> Void)?
    
    init(loadFrom: LoadFrom? = .API) {
        if loadFrom == LoadFrom.API {
            self.fetchCategoriesFromAPIAndSaveToCoreData()
        } else {
            self.loadCategoriesFromCoreData()
        }
    }
    
    func saveEditedCategory(originalName: String, newName: String) {
        let context = CoreDataManager.shared.context
        let fetchRequest: NSFetchRequest<CategoryEntity> = CategoryEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "strCategory == %@", originalName)
        
        do {
            if let categoryEntity = try context.fetch(fetchRequest).first {
                categoryEntity.strCategory = newName
                
                try context.save()
                print("Category name updated from \(originalName) to \(newName)")
                
                self.loadCategoriesFromCoreData()
            }
        } catch {
            print("Error updating ingredient: \(error)")
        }
    }
    
    func loadCategoriesFromCoreData() {
        self.categories = self.getCategoriesFromCoreData()
    }
    
    var filteredCategories: [CategoryModel] {
            if searchText.isEmpty {
                return categories
            } else {
                return categories.filter { $0.strCategory.lowercased().contains(searchText.lowercased()) }
            }
        }
    
    func getCategories() -> [CategoryModel] {
        if !self.categories.isEmpty {
            return self.categories
        } else {
            return self.getCategoriesFromCoreData()
        }
    }
    
    func getCategoriesFromCoreData() -> [CategoryModel] {
        let context = CoreDataManager.shared.context
        let fetchRequest: NSFetchRequest<CategoryEntity> = CategoryEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "isArchived == %@", NSNumber(value: false))
        
        do {
            let categoryEntities = try context.fetch(fetchRequest)
            if categoryEntities.isEmpty {
                return []
            } else {
                let categoriesMapped = categoryEntities.map {
                    CategoryModel(strCategory: $0.strCategory ?? "", isArchived: $0.isArchived)
                }
                return categoriesMapped
            }
        } catch {
            print("Error fetching categories from Core Data: \(error)")
            return []
        }
    }
    
    func fetchCategoriesFromAPIAndSaveToCoreData() {
        print("Fetching categories from API and saving to coredata")
        self.categories.removeAll()
        let urlString = "https://www.themealdb.com/api/json/v1/1/list.php?c=list"
        NetworkManager.shared.fetchData(from: urlString) { [weak self] result in
            switch result {
            case .success(let data):
                do {
                    let categoryResponse = try JSONDecoder().decode(
                        CategoriesResponse.self,
                        from: data
                    )
                    DispatchQueue.main.async {
                        self?.categories = categoryResponse.meals
                        self?.saveCategoriesToCoreData()
                    }
                } catch {
                    DispatchQueue.main.async {
                        self?.onErrorHandling?(error)
                    }
                }
            case .failure(let error):
                self?.onErrorHandling?(error)
            }
        }
    }
    
    func fetchMeals(forCategory category: String) {
        if let fetchedMeals = getMealsFromCoreData(forCategory: category), !fetchedMeals.isEmpty {
            self.meals = fetchedMeals.map { MealListItemModel(from: $0) }
        } else {
            self.fetchMealsFromAPI(forCategory: category)
        }
    }
    
    func fetchMealsFromAPI(forCategory category: String) {
        let urlString = "https://www.themealdb.com/api/json/v1/1/filter.php?c=\(category)"
        NetworkManager.shared.fetchData(from: urlString) { [weak self] result in
            switch result {
            case .success(let data):
                self?.parseMealDataAndSetVariable(data)
            case .failure(let error):
                self?.onErrorHandling?(error)
            }
        }
    }
    
    private func parseMealDataAndSetVariable(_ data: Data) {
        do {
            let mealResponse = try JSONDecoder().decode(MealListItemResponse.self, from: data)
            DispatchQueue.main.async {
                self.meals = mealResponse.meals
                self.onFetchCompleted?()
            }
        } catch {
            DispatchQueue.main.async {
                self.onErrorHandling?(error)
            }
        }
    }
    
    private func getMealsFromCoreData(forCategory category: String) -> [MealEntity]? {
        let context = CoreDataManager.shared.context
        let fetchRequest: NSFetchRequest<MealEntity> = MealEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "strCategory == %@", category)
        
        do {
            return try context.fetch(fetchRequest)
        } catch {
            print("Error fetching meals for category: \(category) from Core Data: \(error)")
            return nil
        }
    }
    
    func archiveCategory(strCategory: String) {
        let context = CoreDataManager.shared.context
        let fetchRequest: NSFetchRequest<CategoryEntity> = CategoryEntity.fetchRequest()
        let predicate = NSPredicate(format: "strCategory == %@", strCategory)
        fetchRequest.predicate = predicate

        do {
            if let categoryEntity = try context.fetch(fetchRequest).first {
                categoryEntity.isArchived = true
                try context.save()
                print("Archived category \(strCategory)")
                self.loadCategoriesFromCoreData()
            }
        } catch {
            print("Error archiving category \(strCategory): \(error)")
        }
    }
    
    func restoreCategory(strCategory: String) {
        let context = CoreDataManager.shared.context
        let fetchRequest: NSFetchRequest<CategoryEntity> = CategoryEntity.fetchRequest()
        let predicate = NSPredicate(format: "strCategory == %@", strCategory)
        fetchRequest.predicate = predicate

        do {
            if let categoryEntity = try context.fetch(fetchRequest).first {
                categoryEntity.isArchived = false
                try context.save()
                print("Restored category \(strCategory)")
                self.loadCategoriesFromCoreData()
            }
        } catch {
            print("Error restoring category \(strCategory): \(error)")
        }
    }
    
    func updateCategory(strCategory: String, newName: String) {
        let context = CoreDataManager.shared.context
        let fetchRequest: NSFetchRequest<CategoryEntity> = CategoryEntity.fetchRequest()
        let predicate = NSPredicate(format: "strCategory == %@", strCategory)
        fetchRequest.predicate = predicate

        do {
            if let categoryEntity = try context.fetch(fetchRequest).first {
                categoryEntity.strCategory = newName
               
                try context.save()
                print("Updated category from \(strCategory) to \(newName)")
                self.loadCategoriesFromCoreData()
            }
        } catch {
            print("Error updating category name \(strCategory) to \(newName): \(error)")
        }
    }
}
    
extension CategoriesViewModel {
    func saveCategoriesToCoreData() {
        guard self.categories.count > 0 else {
            return
        }
            
            let context = CoreDataManager.shared.context
            for category in categories {
                let categoryEntity = CategoryEntity(context: context)
                categoryEntity.strCategory = category.strCategory
                categoryEntity.isArchived = false
            }
            do {
                try context.save()
            } catch {
                print("Error saving categories to Core Data: \(error)")
            }
        }
    
    private func deleteAllCategories(in context: NSManagedObjectContext) {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = CategoryEntity.fetchRequest()
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)

        do {
            try context.execute(deleteRequest)
        } catch let error as NSError {
            print("Error deleting existing categories: \(error), \(error.userInfo)")
        }
    }
    
    func createNewCategory(named name: String) {
        let context = CoreDataManager.shared.context
    
        let newCategory = CategoryEntity(context: context)
        newCategory.strCategory = name
        newCategory.isArchived = false
        
        do {
            try context.save()
            print("New category '\(name)' created successfully.")
            self.loadCategoriesFromCoreData()
        } catch {
            print("Error creating new category \(name): \(error)")
        }
    }
}
