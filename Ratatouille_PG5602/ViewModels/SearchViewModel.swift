//
//  SearchViewModel.swift
//  Ratatouille_PG5602
//
//  Created by Marianne Indrebø on 01/12/2023.
//

import Foundation
import SwiftUI

final class SearchViewModel: ObservableObject {
    @Published var meals: [MealModel] = []
    @Published var meal: [MealListItemModel] = []

    init() {}

    func fetchSearchResult(_ namePhrase: String) {
        print("Fetching search result...")
        let urlString = "https://www.themealdb.com/api/json/v1/1/search.php?s=\(namePhrase)"
        NetworkManager.shared.fetchData(from: urlString) { [weak self] result in
            switch result {
                case .success(let data):
                    do {
                        let mealResponse = try JSONDecoder().decode(
                            MealResponse.self,
                            from: data
                        )
                        DispatchQueue.main.async {
                            self?.meals = mealResponse.meals
                        }
                    } catch {
                        DispatchQueue.main.async {
                            print("Something went wrong decoding search response for phrase \(namePhrase)")
                        }
                    }
                case .failure(let error):
                    print("Something went wrong fetching search response for phrase \(namePhrase): \(error)")
            }
        }
    }
}
