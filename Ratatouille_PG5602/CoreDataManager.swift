//
//  CoreDataManager.swift
//  Ratatouille_PG5602
//
//  Created by Marianne Indrebø on 21/11/2023.
//

import Foundation
import CoreData

class CoreDataManager: ObservableObject {

    let container: NSPersistentContainer
    @Published var savedEntities: [MealEntity] = []
    
    init() {
        container = NSPersistentContainer(name: "MealModel")
        container.loadPersistentStores { (description, error) in
            if let error = error {
                print("Error loading core data. \(error)")
            } else {
                print("successfully loaded core data")
            }
        }
        fetchMeals()
    }

    func fetchMeals() {
        let request = NSFetchRequest<MealEntity>(entityName: "MealEntity")
        
        do {
            savedEntities = try container.viewContext.fetch(request)
        } catch let error {
            print("Error fetching. \(error)")
        }
    }
    
    func addMeal(text: String) {
        let newMeal = MealEntity(context: container.viewContext)
        newMeal.mealName = text
        saveData()
    }
    
    // Bruker kan gjøre endringer i meal. Andre endringer enn navn..
    func updateMeal(entity: MealEntity){
        let currentMealName = entity.mealName ?? ""
        let newName = currentMealName
        saveData()
    }
    
    func deleteMeal(indexSet: IndexSet) {
        guard let index = indexSet.first else { return }
        let entity = savedEntities[index]
        container.viewContext.delete(entity)
        saveData()
    }
    
//    func archiveMeal(indexSet: IndexSet) {
//        guard let index = indexSet.first else { return }
//        let entity = savedEntities[index]
//        container.viewContext.delete(entity)
//    }
    
    func saveData() {
        do {
            try container.viewContext.save()
            fetchMeals()
        } catch let error {
            print("Error saving. \(error)")
        }
    }
    
    func insertAreas(from apiURL: URL) {
        URLSession.shared.dataTask(with: apiURL) { data, _, error in
            if let error = error {
                print("Error fetching data \(error)")
                return
            }
            guard let data = data else {
                print("No data received from API.")
                return
            }
            do {
                let areas = try JSONDecoder().decode([ListAllAreasModel].self, from: data)
                self.insertAreasIntoCoreData(areas)
            } catch {
                print("Error decoding JSON: \(error)")
            }
            
        }.resume()
    }
    
    func insertAreasIntoCoreData(_ areas: [ListAllAreasModel]) {
           for area in areas {
               let newArea = AreaEntity(context: container.viewContext)
               newArea.areaName = area.strArea
           }
           saveData()
       }
    
    func insertMealsIntoCoreData(_ meals: [AreaModel]) {
           for meal in meals {
               let newMeal = MealEntity(context: container.viewContext)
               newMeal.mealName = meal.strMeal
           }
           saveData()
       }
    
}
