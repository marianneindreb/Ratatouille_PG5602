
import SwiftUI

struct EditCategoriesSettingsView: View {
    @StateObject var viewModel = CategoriesViewModel(loadFrom: .coreData)
    @State var showingAddCategoryModal = false
    @State private var editedCategoryName: String = ""

    var body: some View {
        ZStack {
            VStack {
                if viewModel.categories.isEmpty {
                    VStack {
                        Image(systemName: "archivebox")
                            .resizable()
                            .frame(width: 40, height: 40)
                        Text("Du har arkivert alle kategorier. Gå til 'Administrer arkiv' for å hente noen tilbake")
                            .font(.headline)
                            .padding(20)
                    }
                } else {
                    List(viewModel.filteredCategories, id: \.strCategory) { category in
                        HStack {
                            if viewModel.editingCategory == category.strCategory {
                                TextField("Nytt navn", text: $editedCategoryName)
                                    .textFieldStyle(RoundedBorderTextFieldStyle())
                                
                                Button("Lagre") {
                                    viewModel.saveEditedCategory(originalName: category.strCategory, newName: editedCategoryName)
                                    viewModel.editingCategory = nil
                                }
                                .buttonStyle(BorderlessButtonStyle())
                            } else {
                           
                                Text(category.strCategory)
                                Spacer()
                                Image(systemName: "ellipsis")
                                    .foregroundColor(.gray)
                            }
                        }
                        .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                            Button("Arkiver") {
                                viewModel.archiveCategory(strCategory: category.strCategory)
                            }
                            .tint(.brandSecondary)
                            
                            Button {
                                editedCategoryName = category.strCategory
                                viewModel.editingCategory = category.strCategory
                            } label: {
                                Text("Rediger")
                            }
                            .tint(.blue)
                        }
                    }
                    .listStyle(PlainListStyle())
                }
            }
            .searchable(text: $viewModel.searchText, prompt: "Søk etter kategorier")
            .navigationBarTitle("Kategorier", displayMode: .inline)
            .navigationBarItems(trailing: addButton)

            if showingAddCategoryModal {
                Color.black.opacity(0.4)
                    .edgesIgnoringSafeArea(.all)
                    .onTapGesture {
                        showingAddCategoryModal = false
                    }

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
