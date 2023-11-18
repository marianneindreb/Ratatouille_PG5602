//
//  RecipeListView.swift
//  Ratatouille_PG5602
//
//  Created by Marianne Indrebø on 16/11/2023.
//

import SwiftUI

struct RecipeListView: View {
    var body: some View {
        NavigationView {
            List(MockData.meals, id: \.idMeal) { meal in
                MealListCell(meal: meal)
                
            }
            .navigationTitle("Mine oppskrifter")
        }
    }
}

#Preview {
    RecipeListView()
}
