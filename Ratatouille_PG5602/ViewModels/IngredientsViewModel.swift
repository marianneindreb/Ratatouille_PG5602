import Foundation
import CoreData

class IngredientsViewModel {
    private var ingredients: [IngredientModel] = []
   
    
    var onErrorHandling: ((Error) -> Void)?
    var onFetchCompleted: (() -> Void)?
    
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
    
    private func parseIngredientData(_ data: Data) {
        do {
            let ingredientResponse = try JSONDecoder().decode(IngredientsResponse.self, from: data)
            self.ingredients = ingredientResponse.ingredientMeals
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
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = CategoryEntity.fetchRequest()
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)

        do {
            try context.execute(deleteRequest)
        } catch let error as NSError {
            print("Error deleting existing records: \(error), \(error.userInfo)")
        }
    }
}




