//
//  NetworkManager.swift
//  Ratatouille_PG5602
//
//  Created by Marianne Indrebø on 18/11/2023.
//

import Foundation

final class NetworkManager {
    static let shared = NetworkManager()
    
    static let baseURL = "www.themealdb.com/api/json/v1/1/"
    private let categoryURL = baseURL + "categories.php"

    
    private init() {}
    
    func getMeals(completed: @escaping (Result<[Meal], MealError>) -> Void) {
        guard let url = URL(string: categoryURL) else {
            completed(.failure(.invalidURL))
            return
        }
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, response, error in
            guard let _ = error else {
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
            do {
                let decoder = JSONDecoder()
                let decodedResponse = try decoder.decode(MealResponse.self, from: data)
                completed(.success(decodedResponse.request))
            } catch {
                completed(.failure(.InvalidData))
            }
        }
        task.resume()
    }
}
