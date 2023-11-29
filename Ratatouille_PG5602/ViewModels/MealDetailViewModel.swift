import SwiftUI

@Observable
final class MealDetailViewModel {
    var meal: MealModel?
    
    init(meal: MealModel) {
        self.meal = meal
    }
    
    init(id: String) {
        fetchMeal(mealId: id)
    }
    
    func fetchMeal(mealId: String) {
        let urlString = "https://www.themealdb.com/api/json/v1/1/lookup.php?i=\(mealId)"
        NetworkManager.shared.fetchData(from: urlString) { [weak self] result in
            switch result {
            case .success(let data):
                self?.parseMealData(data)
            case .failure(let error):
                break
//                self?.onErrorHandling?(error)
            }
        }
    }
    
    private func parseMealData(_ data: Data) {
        do {
            let mealResponse = try JSONDecoder().decode(MealResponse.self, from: data)
            if let firstMeal = mealResponse.meals.first {
                self.meal = firstMeal
//                self.onFetchCompleted?()
            }
        } catch {
//            self.onErrorHandling?(error)
        }
    }
}
