//
//  NetworkManager.swift
//  Ratatouille_PG5602
//
//  Created by Marianne Indrebø on 18/11/2023.
//

import Foundation

final class NetworkManager {
    static let shared = NetworkManager()
    
    static let apiProtocol = "https://"
    static let baseURL = "www.themealdb.com/api/json/v1/1/"
    
    // La bruker søke på navn
    private let searchURL = apiProtocol + baseURL + "search.php?s=Arrabiata"
    // La bruker velge land fra liste
    private let areaURL = apiProtocol + baseURL + "filter.php?a="
    // La bruker velge hovedingrediens fra liste
    private let ingredientURL = apiProtocol + baseURL + "filter.php?i="
    // La bruker velge kategori fra liste
    private let categoryURL = apiProtocol + baseURL +  "categories.php"

    
    
    func getMeals(completed: @escaping (Result<[MealModel], MealError>) -> Void) {
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
    // decodedResponse.meals må inn i et array som er av typen mealmodel
    
    func getAreas(area: String, completed: @escaping (Result<[AreaModel], MealError>) -> Void) {
        guard let url = URL(string: "\(areaURL)\(area)") else { 
            completed(.failure(.invalidURL))
            return
        }
//        func getMeals(forCategory category: String, completion: @escaping (Result<[Meal], Error>) -> Void) {
//                var urlComponents = URLComponents(string: baseURL + "filter.php")!
//                urlComponents.queryItems = [
//                    URLQueryItem(name: "c", value: category)
//                ]
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
                let decodedResponse = try decoder.decode(AreaResponse.self, from: data)
                completed(.success(decodedResponse.meals))
            } catch {
                print("Decoding error: \(error)")
                completed(.failure(.InvalidData))
            }
        }
        task.resume()
    }
    
    
    func getCategory(completed: @escaping (Result<[CategoryModel], MealError>) -> Void) {
        guard let url = URL(string: areaURL) else {
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
                let decodedResponse = try decoder.decode(CategoryResponse.self, from: data)
                completed(.success(decodedResponse.categoryMeals))
            } catch {
                print("Decoding error: \(error)")
                completed(.failure(.InvalidData))
            }
        }
        task.resume()
    }
    
    func getIngredient(completed: @escaping (Result<[IngredientModel], MealError>) -> Void) {
        guard let url = URL(string: ingredientURL) else {
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
                let decodedResponse = try decoder.decode(IngredientResponse.self, from: data)
                completed(.success(decodedResponse.ingredientMeals))
            } catch {
                print("Decoding error: \(error)")
                completed(.failure(.InvalidData))
            }
        }
        task.resume()
    }
    
}
