//
//  SearchViewModel.swift
//  Ratatouille_PG5602
//
//  Created by Marianne Indrebø on 29/11/2023.
//

import Foundation

final class SearchViewModel {
   // @Published var ingredients: [IngredientModel] = []
    @Published var meals: [MealListItemModel] = []
    
    var onErrorHandling: ((Error) -> Void)?
    var onFetchCompleted: (() -> Void)?
    
    
    func fetchMeals(forText text: String) {
        if let fetchedMeals = getMealsFromCoreData(forText: text), !fetchedMeals.isEmpty {
            self.meals = fetchedMeals.map { MealListItemModel(from: $0) }
        } else {
            fetchMealsFromAPI(forText: text)
        }
    }
    
    func fetchMealsFromAPI(forText text: String) {
        let urlString = "https://www.themealdb.com/api/json/v1/1/search.php?s=\(text)"
        NetworkManager.shared.fetchData(from: urlString) { [weak self] result in
            switch result {
            case .success(let data):
                self?.parseMealData(data)
            case .failure(let error):
                self?.onErrorHandling?(error)
            }
        }
    }
    
    private func getMealsFromCoreData(forText text: String) -> [MealEntity]? {
        let context = CoreDataManager.shared.context
        let fetchRequest: NSFetchRequest<MealEntity> = MealEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "str == %@", ingredient)
        
        do {
            return try context.fetch(fetchRequest)
        } catch {
            print("Error fetching meals for ingredient: \(ingredient) from Core Data: \(error)")
            return nil
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
    
    // www.themealdb.com/api/json/v1/1/search.php?s=\(text)
}



 
    






