//
//  EditIngredientsSettingsView.swift
//  Ratatouille_PG5602
//
//  Created by Marianne Indrebø on 02/12/2023.
//

import SwiftUI

struct EditIngredientsSettingsView: View {
    @StateObject var viewModel = IngredientsViewModel(loadFrom: .coreData)
    //TODO: Search
    // Arkivere landområder, redigere dem og legge til nye
    // I vinduet for innstillinger skal du kunne importere landområder, kategorier og ingredienser fra API til databasen.
   // Du skal ha muligheten til å opprette, redigere og arkivere landområder, kategorier og ingredienser, som illustrert i eksemplene nedenfor.

    var body: some View {
        VStack() {
            if viewModel.ingredients.isEmpty {
                VStack {
                    Text("Du har arkivert alle ingredienser. Gå til 'Administrer arkiv' for å hente noen tilbake")
                        .font(.headline)
                        .padding(20)
                }
            } else {
                List(viewModel.ingredients, id: \.idIngredient) { ingredient in
                    HStack {
                        NavigationLink {
                            EditIngredientDetailsView(ingredient: ingredient, ingredientsViewModel: viewModel)
                        } label: {
                            Text(ingredient.strIngredient)
                        }
                        
                    }
                    .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                        Button("Arkiver") {
                            viewModel.archiveIngredient(idIngredient: ingredient.idIngredient)
                        }
                        .tint(.brandSecondary)
                    }
                }
                .listStyle(PlainListStyle())
            }
        }
    }
}

#Preview {
    EditIngredientsSettingsView()
}
