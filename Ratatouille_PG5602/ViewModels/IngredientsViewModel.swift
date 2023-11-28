import Foundation
import CoreData

class IngredientsViewModel: ObservableObject {
     @Published var ingredients: [IngredientModel] = []
     @Published var meals: [MealListItemModel] = []
   
    
    var onErrorHandling: ((Error) -> Void)?
    var onFetchCompleted: (() -> Void)?
    
    init() {
        getIngredientsFromCoreDataIfNeeded()
    }
    
    func getIngredientsFromCoreDataIfNeeded() {
           let context = CoreDataManager.shared.context
           let fetchRequest: NSFetchRequest<IngredientEntity> = IngredientEntity.fetchRequest()

           do {
               let ingredientEntities = try context.fetch(fetchRequest)
               if ingredientEntities.isEmpty {
                   fetchIngredients()
               } else {
                   self.ingredients = ingredientEntities.map {
                       IngredientModel(idIngredient: $0.idIngredient ?? "", strIngredient: $0.strIngredient ?? "")}
               }
           } catch {
               print("Error fetching ingredients from Core Data: \(error)")
           }
       }
    
    
    
    func fetchIngredients() {
        let urlString = "https://www.themealdb.com/api/json/v1/1/list.php?i=list"
        NetworkManager.shared.fetchData(from: urlString) { [weak self] result in
            switch result {
            case .success(let data):
                self?.parseIngredientData(data)
            case .failure(let error):
                self?.onErrorHandling?(error)
            }
        }
    }
    
    func fetchMeals(forIngredient ingredient: String) {
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
    
    func getIngredientsFromCoreData() {
        print("Fetching ingredients from core data")
        self.ingredients.removeAll()
            let context = CoreDataManager.shared.context
            let fetchRequest: NSFetchRequest<IngredientEntity> = IngredientEntity.fetchRequest()

            do {
                let ingredientEntities = try context.fetch(fetchRequest)
                self.ingredients.removeAll()
                self.ingredients = ingredientEntities.map { IngredientModel(idIngredient: $0.idIngredient ?? "", strIngredient: $0.strIngredient ?? "")}
            } catch {
                print("Error fetching ingredients from Core Data: \(error)")
            }
        }
    
    private func parseIngredientData(_ data: Data) {
        do {
            let ingredientResponse = try JSONDecoder().decode(IngredientsResponse.self, from: data)
            self.ingredients = ingredientResponse.meals
            self.onFetchCompleted?()
        } catch {
            self.onErrorHandling?(error)
        }
    }
    
    var numberOfIngredients: Int {
        return ingredients.count
    }
    
    func ingredient(at index: Int) -> IngredientModel? {
        guard index >= 0 && index < ingredients.count else {
            return nil
        }
        return ingredients[index]
    }
    
}

extension IngredientsViewModel {
    func saveIngredientsToCoreData() {
        guard ingredients.count > 0 else {
            return
        }
        
        let context = CoreDataManager.shared.context
        for ingredient in ingredients {
            let ingredientEntity = IngredientEntity(context: context)
            ingredientEntity.strIngredient = ingredient.strIngredient
        }
        CoreDataManager.shared.saveContext()
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




