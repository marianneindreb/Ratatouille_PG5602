//
//  EditCategoriesSettingsView.swift
//  Ratatouille_PG5602
//
//  Created by Marianne Indrebø on 02/12/2023.
//

import SwiftUI

struct EditCategoriesSettingsView: View {
    @StateObject var viewModel = CategoriesViewModel(loadFrom: .coreData)
    @State var showingAddCategoryModal = false

    var body: some View {
        ZStack {
            VStack {
                if viewModel.categories.isEmpty {
                    VStack {
                        Text("Du har arkivert alle kategorier. Gå til 'Administrer arkiv' for å hente noen tilbake")
                            .font(.headline)
                            .padding(20)
                    }
                } else {
                    List(viewModel.filteredCategories, id: \.strCategory) { category in
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
            .searchable(text: $viewModel.searchText, prompt: "Søk etter kategorier")
            .navigationBarTitle("Kategorier", displayMode: .inline)
            .navigationBarItems(trailing: addButton)

            // Custom modal presentation
            if showingAddCategoryModal {
                // Overlay for dimming the background
                Color.black.opacity(0.4)
                    .edgesIgnoringSafeArea(.all)
                    .onTapGesture {
                        showingAddCategoryModal = false
                    }

                // Modal content
                AddCategoryModal(isPresented: $showingAddCategoryModal, viewModel: viewModel)
                    .frame(width: 300, height: 300)
                    .background(Color.white)
                    .cornerRadius(15)
                    .shadow(radius: 10)
            }
        }
    }
    private var addButton: some View {
        Button(action: {
            showingAddCategoryModal = true
        }) {
            Image(systemName: "plus")
        }
    }
}

#Preview {
    EditCategoriesSettingsView()
}
