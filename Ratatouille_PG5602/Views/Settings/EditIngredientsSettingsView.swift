import SwiftUI

struct EditIngredientsSettingsView: View {
    @StateObject var viewModel = IngredientsViewModel(loadFrom: .coreData)
    @State private var showingAddIngredientModal = false
    //TODO: Search
    // Arkivere landområder, redigere dem og legge til nye
    // I vinduet for innstillinger skal du kunne importere landområder, kategorier og ingredienser fra API til databasen.
    // Du skal ha muligheten til å opprette, redigere og arkivere landområder, kategorier og ingredienser, som illustrert i eksemplene nedenfor.
      
      var body: some View {
          ZStack {
              // Main content
              VStack {
                  if viewModel.ingredients.isEmpty {
                      VStack {
                          Image(systemName: "archivebox")
                              .resizable()
                              .frame(width: 40, height: 40)
                          Text("Du har arkivert alle ingredienser. Gå til 'Administrer arkiv' for å hente noen tilbake")
                              .font(.body)
                              .padding(20)
                      }
                  } else {
                      List(viewModel.filteredIngredients, id: \.idIngredient) { ingredient in
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
              .searchable(text: $viewModel.searchText, prompt: "Søk etter ingredienser")
              .navigationBarTitle("Ingredienser", displayMode: .inline)
              .navigationBarItems(trailing: addButton)

              // Custom modal presentation
              if showingAddIngredientModal {
                  // Overlay for dimming the background
                  Color.black.opacity(0.4)
                      .edgesIgnoringSafeArea(.all)
                      .onTapGesture {
                          showingAddIngredientModal = false
                      }

                  // Modal content
                  AddIngredientModal(isPresented: $showingAddIngredientModal, viewModel: viewModel)
                      .frame(width: 300, height: 300)
                      .background(Color.white)
                      .cornerRadius(15)
                      .shadow(radius: 10)
              }
          }
      }

      private var addButton: some View {
          Button(action: {
              showingAddIngredientModal = true
          }) {
              Image(systemName: "plus")
          }
      }
  }

#Preview {
    EditIngredientsSettingsView()
}
