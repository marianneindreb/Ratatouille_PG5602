import Foundation
import SwiftUI

struct ArchiveView: View {
    @ObservedObject var viewModel = ArchivedMealsViewModel()
    
    @State var hasArchivedAreas: Bool = false
    @State var hasArchivedCategories: Bool = false
    @State var hasArchivedIngredients: Bool = false
    @State var hasArchivedMeals: Bool = false
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Landområder")) {
                    if hasArchivedAreas == true {
                        // vis arkiverte landområder
                    } else {
                        Text("Ingen arkiverte landområder")
                    }
                }
                Section(header: Text("Kategorier")) {
                    if hasArchivedCategories == true     {
                        // vis arkiverte kategorier
                    } else {
                        Text("Ingen arkiverte kategorier")
                    }
                }
                Section(header: Text("Ingredienser")) {
                    if hasArchivedIngredients == true {
                        // vis arkriverte ingredienser
                    } else {
                        Text("Ingen arkiverte ingredienser")
                    }
                }
                Section(header: Text("Oppskrifter")) {
                    if viewModel.archivedMeals.isEmpty {
                        Text("Ingen arkiverte oppskrifter")
                        // Vise liste over arkiverte oppskrifter
                    } else {
                        ForEach(viewModel.archivedMeals, id: \.idMeal) { meal in
                            HStack {
                                Text(meal.strMeal)
                                // TODO: show flag
                            }
                            .swipeActions(edge: .trailing, allowsFullSwipe: false) {
                                Button {
                                    viewModel.deleteMeal(id: meal.idMeal)
                                } label: {
                                    Image(systemName: "trash")
                                       
                                }
                                .tint(.red)
                                
                                Button {
                                    viewModel.restoreMeal(id: meal.idMeal)
                                } label: {
                                    Image(systemName: "plus.app.fill")
                                }
                                .tint(.green)
                            }
                        }
                    }
                    
                }
            }
            .navigationTitle("Arkiv")
        }
        .onAppear {
            viewModel.getArchivedMeals()
        }
    }
}

#Preview {
    ArchiveView()
}
