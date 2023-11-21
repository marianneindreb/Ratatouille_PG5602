////
////  CategoryViewModel.swift
////  Ratatouille_PG5602
////
////  Created by Marianne Indrebø on 21/11/2023.
////
//
//import Foundation
//
//final class CategoryListViewModel: ObservableObject {
//    
//    @Published var categories: [Category] = []
//    @Published var alertItem: AlertItem?
//    
//    func getCategories() {
//        CategoryFetch.shared.getCategories { result in
//            DispatchQueue.main.async {
//                switch result {
//                case .success(let categories):
//                    self.categories = categories
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
