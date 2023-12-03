import Foundation
import CoreData

// @Observable
final class IngredientsViewModel: ObservableObject {
    @Published var ingredients: [IngredientModel] = []
    @Published var meals: [MealListItemModel] = []
    @Published var searchText = ""
    
    enum LoadFrom {
        case API
        case coreData
    }
    
    var onErrorHandling: ((Error) -> Void)?
    var onFetchCompleted: (() -> Void)?
    
    init() {
        self.fetchIngredientsFromAPIAndSaveToCoreData()
    }
    
    init(loadFrom: LoadFrom? = .API) {
        if loadFrom == LoadFrom.API {
            self.fetchIngredientsFromAPIAndSaveToCoreData()
        } else {
            self.loadIngredientsFromCoreData()
        }
    }
    
    //søke etter ingredienser i settings -> Rediger ingredienser
    var filteredIngredients: [IngredientModel] {
            if searchText.isEmpty {
                return ingredients
            } else {
                return ingredients.filter { $0.strIngredient.lowercased().contains(searchText.lowercased()) }
            }
        }
    
    func loadIngredientsFromCoreData(){
        self.ingredients = getIngredientsFromCoreData()
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
        fetchRequest.predicate = NSPredicate(format: "isArchived == %@", NSNumber(value: false))
        
        do {
            let ingredientEntities = try context.fetch(fetchRequest)
            if ingredientEntities.isEmpty {
                return []
            } else {
                let ingredientsMapped = ingredientEntities.map {
                    IngredientModel(idIngredient: $0.idIngredient ?? "", strIngredient: $0.strIngredient ?? "", isArchived: $0.isArchived)
                }
                return ingredientsMapped;
            }
        } catch {
            print("Error fetching ingredients from Core Data: \(error)")
            return []
        }
    }
    
    func fetchIngredientsFromAPIAndSaveToCoreData() {
        print("Fetching ingredients from API and saving to coredata")
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
                        let uniqueIngredients = ingredientResponse.meals.removingDuplicates()
                               self?.ingredients = uniqueIngredients
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
    
    func archiveIngredient(idIngredient: String) {
        let context = CoreDataManager.shared.context
        let fetchRequest: NSFetchRequest<IngredientEntity> = IngredientEntity.fetchRequest()
        let predicate = NSPredicate(format: "idIngredient == %@", idIngredient)
        fetchRequest.predicate = predicate
        
        do {
            if let ingredientEntity = try context.fetch(fetchRequest).first {
                ingredientEntity.isArchived = true
                try context.save()
                print("Archived ingredient \(idIngredient)")
                self.loadIngredientsFromCoreData()
            }
        } catch {
            print("Error archiving ingredient with id \(idIngredient): \(error)")
        }
    }
    
    func restoreIngredient(idIngredient: String) {
        let context = CoreDataManager.shared.context
        let fetchRequest: NSFetchRequest<IngredientEntity> = IngredientEntity.fetchRequest()
        let predicate = NSPredicate(format: "idIngredient == %@", idIngredient)
        fetchRequest.predicate = predicate
        
        do {
            if let ingredientEntity = try context.fetch(fetchRequest).first {
                ingredientEntity.isArchived = false
                try context.save()
                print("Restored ingredient with id \(idIngredient)")
                self.loadIngredientsFromCoreData()
            }
        } catch {
            print("Error restoring ingredient with id \(idIngredient): \(error)")
        }
    }
    
    func updateIngredient(idIngredient: String, newName: String){
        let context = CoreDataManager.shared.context
        let fetchRequest: NSFetchRequest<IngredientEntity> = IngredientEntity.fetchRequest()
        let predicate = NSPredicate(format: "idIngredient == %@", idIngredient)
        fetchRequest.predicate = predicate
        
        do {
            if let ingredientEntity = try context.fetch(fetchRequest).first {
                let oldName = ingredientEntity.strIngredient
                ingredientEntity.strIngredient = newName
                
                try context.save()
                print("Updated ingredient name from \(String(describing: oldName)) to \(newName)")
                self.loadIngredientsFromCoreData()
            }
        } catch {
            print("Error updating ingredient name \(idIngredient) to \(newName): \(error)")
        }
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
            ingredientEntity.idIngredient = ingredient.idIngredient
            ingredientEntity.strIngredient = ingredient.strIngredient
            ingredientEntity.isArchived = false
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
    
    func createNewIngredient(named name: String) {
        let context = CoreDataManager.shared.context
    
        let newIngredient = IngredientEntity(context: context)
        newIngredient.strIngredient = name
        newIngredient.idIngredient = UUID().uuidString
        newIngredient.isArchived = false
        
        do {
            try context.save()
            print("New ingredient '\(name)' created successfully.")
            loadIngredientsFromCoreData()
        } catch {
            print("Error creating new ingredient \(name): \(error)")
        }
    }
}





