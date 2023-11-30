import Foundation


final class MealViewModel: ObservableObject {
    @Published var meals: [MealListItemModel] = []
    
    var onErrorHandling: ((Error) -> Void)?
    var onFetchCompleted: (([MealListItemModel]) -> Void)?
    
    func fetchMeals() async throws {
        let urlString = "https://www.themealdb.com/api/json/v1/1/search.php?s=Chicken"
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
            self.onFetchCompleted?(mealResponse.meals)
        } catch {
            self.onErrorHandling?(error)
        }
    }
}

