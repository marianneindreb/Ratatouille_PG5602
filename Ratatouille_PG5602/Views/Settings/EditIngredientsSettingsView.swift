import SwiftUI

struct EditIngredientsSettingsView: View {
    @StateObject var viewModel = IngredientsViewModel(loadFrom: .coreData)
    @State private var showingAddIngredientSheet = false
    //TODO: Search
    // Arkivere landområder, redigere dem og legge til nye
    // I vinduet for innstillinger skal du kunne importere landområder, kategorier og ingredienser fra API til databasen.
    // Du skal ha muligheten til å opprette, redigere og arkivere landområder, kategorier og ingredienser, som illustrert i eksemplene nedenfor.
    
    var body: some View {
            VStack() {
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
            .navigationBarTitle("Ingredienser", displayMode: .inline)
            .navigationBarItems(trailing: addButton)
                    .sheet(isPresented: $showingAddIngredientSheet) {
                        AddIngredientSheetView(isPresented: $showingAddIngredientSheet, viewModel: viewModel)
                    }
                }

                private var addButton: some View {
                    Button(action: {
                        showingAddIngredientSheet = true
                    }) {
                        Image(systemName: "plus")
                    }
                }
            }


#Preview {
    EditIngredientsSettingsView()
}
