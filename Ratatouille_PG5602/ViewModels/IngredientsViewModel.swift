import Foundation
import CoreData

// @Observable
final class IngredientsViewModel: ObservableObject {
     @Published var ingredients: [IngredientModel] = []
     @Published var meals: [MealListItemModel] = []
   
    
    var onErrorHandling: ((Error) -> Void)?
    var onFetchCompleted: (() -> Void)?
    
    init() {
        self.fetchIngredientsFromAPIAndSaveToCoreData()
    }
    
    func getIngredients() -> [IngredientModel] {
        if !self.ingredients.isEmpty {
            return self.ingredients
        } else {
            return getIngredientsFromCoreData()
        }
    }
    
    func getIngredientsFromCoreData() -> [IngredientModel] {
        let context = CoreDataManager.shared.context
        let fetchRequest: NSFetchRequest<IngredientEntity> = IngredientEntity.fetchRequest()
        
        do {
            let ingredientEntities = try context.fetch(fetchRequest)
            if ingredientEntities.isEmpty {
                return []
            } else {
                let ingredientsMapped = ingredientEntities.map {
                    IngredientModel(idIngredient: $0.idIngredient ?? "", strIngredient: $0.strIngredient ?? "")
                }
            return ingredientsMapped;
        }
        } catch {
            print("Error fetching ingredients from Core Data: \(error)")
            return []
        }
    }
     
    func fetchIngredientsFromAPIAndSaveToCoreData() {
        print("Fetching ingredients from API and saves to coredata")
        self.ingredients.removeAll()
        let urlString = "https://www.themealdb.com/api/json/v1/1/list.php?i=list"
        NetworkManager.shared.fetchData(from: urlString) { [weak self] result in
            switch result {
                case .success(let data):
                do {
                    let ingredientResponse = try JSONDecoder().decode(
                        IngredientsResponse.self,
                        from: data
                    )
                    DispatchQueue.main.async {
                        self?.ingredients = ingredientResponse.meals
                        self?.saveIngredientsToCoreData()
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
    
    func fetchMeals(forIngredient ingredient: String) {
        if let fetchedMeals = getMealsFromCoreData(forIngredient: ingredient), !fetchedMeals.isEmpty {
            self.meals = fetchedMeals.map { MealListItemModel(from: $0) }
        } else {
            fetchMealsFromAPI(forIngredient: ingredient)
        }
    }
    
    func fetchMealsFromAPI(forIngredient ingredient: String) {
        let urlString = "https://www.themealdb.com/api/json/v1/1/filter.php?i=\(ingredient)"
        NetworkManager.shared.fetchData(from: urlString) { [weak self] result in
            switch result {
            case .success(let data):
                self?.parseMealData(data)
            case .failure(let error):
                self?.onErrorHandling?(error)
            }
        }
    }

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
    
    private func getMealsFromCoreData(forIngredient ingredient: String) -> [MealEntity]? {
        let context = CoreDataManager.shared.context
        let fetchRequest: NSFetchRequest<MealEntity> = MealEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "strIngredient == %@", ingredient)
        
        do {
            return try context.fetch(fetchRequest)
        } catch {
            print("Error fetching meals for ingredient: \(ingredient) from Core Data: \(error)")
            return nil
        }
    }
}

extension IngredientsViewModel {
    func saveIngredientsToCoreData() {
        print("ingredients saved to core data")
        guard ingredients.count > 0 else {
            return
        }
        
        let context = CoreDataManager.shared.context
        for ingredient in ingredients {
            let ingredientEntity = IngredientEntity(context: context)
            ingredientEntity.strIngredient = ingredient.strIngredient
        }
        do {
            try context.save()
        } catch {
            print("Error saving ingredients to Core Data: \(error)")
        }
    }

    private func deleteAllIngredients(in context: NSManagedObjectContext) {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = IngredientEntity.fetchRequest()
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)

        do {
            try context.execute(deleteRequest)
        } catch let error as NSError {
            print("Error deleting existing records: \(error), \(error.userInfo)")
        }
    }
}




