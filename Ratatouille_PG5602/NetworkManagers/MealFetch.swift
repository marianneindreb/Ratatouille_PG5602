//
//  NetworkManager.swift
//  Ratatouille_PG5602
//
//  Created by Marianne Indrebø on 18/11/2023.
//

import Foundation

final class MealFetch {
    static let shared = MealFetch()
    
    static let apiProtocol = "https://"
    static let baseURL = "www.themealdb.com/api/json/v1/1/"
    
    private let searchURL = baseURL + apiProtocol + "search.php?s="
    private let areaURL = baseURL + apiProtocol + "filter.php?a="
    private let ingredientURL = baseURL + apiProtocol + ""
    private let categoryURL = baseURL + apiProtocol + "filter.php?c="

    
    private init() {}
    
    func getMeals(completed: @escaping (Result<[Meal], MealError>) -> Void) {
        guard let url = URL(string: searchURL) else {
            completed(.failure(.invalidURL))
            return
        }
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, response, error in
            if let _ = error {
                completed(.failure(.unableToComplete))
                return
            }
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completed(.failure(.invalidResponse))
                return
            }
            guard let data = data else {
                completed(.failure(.InvalidData))
                return
            }
            print("Received data: \(String(data: data, encoding: .utf8) ?? "Unable to convert data to string")")
            
            do {
                let decoder = JSONDecoder()
                let decodedResponse = try decoder.decode(MealResponse.self, from: data)
                completed(.success(decodedResponse.meals))
            } catch {
                print("Decoding error: \(error)")
                completed(.failure(.InvalidData))
            }
        }
        task.resume()
    }
}
