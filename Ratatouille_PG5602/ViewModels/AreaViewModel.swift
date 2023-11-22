//
//  MealListViewModel.swift
//  Ratatouille_PG5602
//
//  Created by Marianne Indrebø on 18/11/2023.
//

import Foundation

final class AreaViewModel: ObservableObject {
    
    @Published var area: [AreaModel] = []
    @Published var alertItem: AlertItem?
    
    func getArea(area: String) {
        NetworkManager.shared.getAreas(area: area) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let area):
                    self.area = area
                case .failure(let error):
                    switch error {
                    case .invalidURL:
                        self.alertItem = AlertContext.invalidURL
                    case .invalidResponse:
                        self.alertItem = AlertContext.invalidResponse
                    case .InvalidData:
                        self.alertItem = AlertContext.invalidData
                    case .unableToComplete:
                        self.alertItem = AlertContext.unableToComplete
                    }
                }
            }
        }
    }
}
//
