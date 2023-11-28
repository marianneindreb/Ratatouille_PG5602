//
//  Ratatouille_PG5602App.swift
//  Ratatouille_PG5602
//
//  Created by Marianne Indrebø on 16/11/2023.
//

import SwiftUI

@main
struct Ratatouille_PG5602App: App {
//    @AppStorage("hasLaunchedBefore") var hasLaunchedBefore: Bool = false
    
//    private var areasViewModel = AreasViewModel()
//    private var categoriesViewModel = CategoriesViewModel()
//    private var ingredientsViewModel = IngredientsViewModel()
//    
//    func fetchDataAndSave() {
//            areasViewModel.fetchAreas()
//            categoriesViewModel.fetchCategoriesFromAPIAndSaveToCoreData()
//            ingredientsViewModel.fetchIngredients()
//            
//            categoriesViewModel.onFetchCompleted = {
//                self.categoriesViewModel.saveCategoriesToCoreData()
//           }
//
//            ingredientsViewModel.onFetchCompleted = {
//                self.ingredientsViewModel.saveIngredientsToCoreData()
//            }
//    }
  // let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            SplashScreenView()
            }
        }
    }

