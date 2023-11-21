////
////  MealListViewModel.swift
////  Ratatouille_PG5602
////
////  Created by Marianne Indrebø on 18/11/2023.
////
//
//import Foundation
//
//final class MealListViewModel: ObservableObject {
//    
//    @Published var meals: [Meal] = []
//    @Published var alertItem: AlertItem?
//    
//    func getMeals() {
//        NetworkManager.shared.getMeals { result in
//            DispatchQueue.main.async {
//                switch result {
//                case .success(let meals):
//                    self.meals = meals
//                case .failure(let error):
//                    switch error {
//                    case .invalidURL:
//                        self.alertItem = AlertContext.invalidURL
//                    case .invalidResponse:
//                        self.alertItem = AlertContext.invalidResponse
//                    case .InvalidData:
//                        self.alertItem = AlertContext.invalidData
//                    case .unableToComplete:
//                        self.alertItem = AlertContext.unableToComplete
//                    }
//                }
//            }
//        }
//    }
//}
