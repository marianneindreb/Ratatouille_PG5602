import SwiftUI

struct EditIngredientsSettingsView: View {
    @StateObject var viewModel = IngredientsViewModel(loadFrom: .coreData)
    @State private var showingAddIngredientModal = false
    @State private var editedIngredientName: String = ""
      
      var body: some View {
          ZStack {
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
                              if viewModel.editingIngredient == ingredient.strIngredient {
                                  TextField("Nytt navn", text: $editedIngredientName)
                                      .textFieldStyle(RoundedBorderTextFieldStyle())
                                  Button("Lagre") {
                                      viewModel.saveEditedIngredient(originalName: ingredient.strIngredient, newName: editedIngredientName)
                                      viewModel.editingIngredient = nil
                                  }
                                  .buttonStyle(BorderlessButtonStyle())
                              } else {
                                  Text(ingredient.strIngredient)
                                  Spacer()
                                  Image(systemName: "ellipsis")
                                      .foregroundColor(.gray)
                              }
                          }
                          .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                              Button("Arkiver") {
                                  viewModel.archiveIngredient(idIngredient: ingredient.idIngredient)
                              }
                              .tint(.brandSecondary)
                              Button {
                                  editedIngredientName = ingredient.strIngredient
                                  viewModel.editingIngredient = ingredient.strIngredient
                              } label: {
                                  Text("Rediger")
                              }
                              .tint(.blue)
                          }
                      }
                      .listStyle(PlainListStyle())
                  }
              }
              .searchable(text: $viewModel.searchText, prompt: "Søk etter ingredienser")
              .navigationBarTitle("Ingredienser", displayMode: .inline)
              .navigationBarItems(trailing: addButton)

             
              if showingAddIngredientModal {
                  Color.black.opacity(0.4)
                      .edgesIgnoringSafeArea(.all)
                      .onTapGesture {
                          showingAddIngredientModal = false
                      }

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
