//
//  CoreDataViewModel.swift
//  Ratatouille_PG5602
//
//  Created by Marianne Indrebø on 22/11/2023.
//

import Foundation
import CoreData

class CoreDataViewModel: ObservableObject {
    
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
    
    func saveData() {
        do {
            try container.viewContext.save()
            fetchMeals()
        } catch let error {
            print("Error saving. \(error)")
        }
    }
}
