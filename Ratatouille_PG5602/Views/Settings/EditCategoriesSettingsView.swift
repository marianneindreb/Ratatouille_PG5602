//
//  EditCategoriesSettingsView.swift
//  Ratatouille_PG5602
//
//  Created by Marianne Indrebø on 02/12/2023.
//

import SwiftUI

struct EditCategoriesSettingsView: View {
    @StateObject var viewModel = CategoriesViewModel(loadFrom: .coreData)

    var body: some View {
        VStack {
            if viewModel.categories.isEmpty {
                VStack {
                    Text("Du har arkivert alle kategorier. Gå til 'Administrer arkiv' for å hente noen tilbake")
                        .font(.headline)
                        .padding(20)
                }
            } else {
                List(viewModel.categories, id: \.strCategory) { category in
                    HStack {
                        NavigationLink {
                            EditCategoryDetailsView(category: category, categoriesViewModel: viewModel)
                        } label: {
                            Text(category.strCategory)
                        }
                    }
                    .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                        Button("Arkiver") {
                            viewModel.archiveCategory(strCategory: category.strCategory)
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
    EditCategoriesSettingsView()
}
