import Foundation
import CoreData

class CategoriesViewModel: ObservableObject {
    @Published var categories: [CategoryModel] = []
    @Published var meals: [MealListItemModel] = []
    
    var onErrorHandling: ((Error) -> Void)?
    var onFetchCompleted: (() -> Void)?
    
    init() {
    }
    
    func getCategories() -> [CategoryModel] {
        if !self.categories.isEmpty {
            return self.categories
        } else {
            return getCategoriesFromCoreData()
        }
    }
    func getCategoriesFromCoreData() -> [CategoryModel] {
        let context = CoreDataManager.shared.context
        let fetchRequest: NSFetchRequest<CategoryEntity> = CategoryEntity.fetchRequest()

        do {
            let categoryEntities = try context.fetch(fetchRequest)
            if categoryEntities.isEmpty {
                return []
            } else {
               let categoriesMapped = categoryEntities.map {
                    CategoryModel(idCategory: $0.idCategory ?? "",
                                  strCategory: $0.strCategory ?? "",
                                  strCategoryThumb: $0.strCategoryThumb ?? "",
                                  strCategoryDescription: $0.strCategoryDescription ?? "")
                }
                return categoriesMapped;
            }
        } catch {
            print("Error fetching categories from Core Data: \(error)")
            return []
        }
    }
    
    func fetchCategoriesFromAPIAndSaveToCoreData() {
        print("Fetching categories from API and saves to coredata")
        self.categories.removeAll()
        let urlString = "https://www.themealdb.com/api/json/v1/1/list.php?c=list"
        NetworkManager.shared.fetchData(from: urlString) { [weak self] result in
            switch result {
                case .success(let data):
                    self?.categories.removeAll()
                do {
                    let categoryResponse = try JSONDecoder().decode(
                        CategoriesResponse.self,
                        from: data
                    )
                    DispatchQueue.main.async {
                        self?.categories = categoryResponse.categories
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
            fetchMealsFromAPI(forCategory: category)
        }
    }
    
    
    private func fetchMealsFromAPI(forCategory category: String) {
        let urlString = "https://www.themealdb.com/api/json/v1/1/filter.php?c=\(category)"
        NetworkManager.shared.fetchData(from: urlString) { [weak self] result in
            switch result {
            case .success(let data):
                self?.parseMealData(data)
            case .failure(let error):
                self?.onErrorHandling?(error)
            }
        }
    }
    
    //    func fetchMeals(forCategory category: String) {
    //          let urlString = "https://www.themealdb.com/api/json/v1/1/filter.php?c=\(category)"
    //        NetworkManager.shared.fetchData(from: urlString) { [weak self] result in
    //                    switch result {
    //                    case .success(let data):
    //                        self?.parseMealData(data)
    //                    case .failure(let error):
    //                        self?.onErrorHandling?(error)
    //              }
    //          }
    //      }
    
    private func parseMealData(_ data: Data) {
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
            print("Error fetching meals for category \(category) from Core Data: \(error)")
            return nil
        }
    }
    
    //    private func parseCategoryData(_ data: Data) {
    //        do {
    //            let categoryResponse = try JSONDecoder().decode(CategoriesResponse.self, from: data)
    //            self.categories = categoryResponse.categories
    //            self.onFetchCompleted?()
    //        } catch {
    //            self.onErrorHandling?(error)
    //        }
    //    }
    //
    //    var numberOfCategories: Int {
    //        return categories.count
    //    }
    //
    //    func category(at index: Int) -> CategoryModel? {
    //        guard index >= 0 && index < categories.count else {
    //            return nil
    //        }
    //        return categories[index]
    //    }
    //}
}
    
    extension CategoriesViewModel {
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
    
}






