import Foundation
import SwiftUI

struct ArchiveView: View {
    @ObservedObject var archivedMealsVM = ArchivedMealsViewModel()
    @ObservedObject var archivedAreasVM = ArchivedAreasViewModel()

    @State var hasArchivedAreas: Bool = false
    @State var hasArchivedCategories: Bool = false
    @State var hasArchivedIngredients: Bool = false
    @State var hasArchivedMeals: Bool = false

    var body: some View {
                    Form {
                Section(header: Text("Landområder")) {
                    if hasArchivedAreas == true {
                        // vis arkiverte landområder
                    } else {
                        ForEach(archivedAreasVM.archivedAreas, id: \.strArea) { area in
                            HStack {
                                Text(area.strArea)
                            }
                            .swipeActions(edge: .trailing, allowsFullSwipe: false) {
                                Button {
                                    archivedAreasVM.deleteArea(strArea: area.strArea)
                                } label: {
                                    Image(systemName: "trash")
                                }
                                .tint(.red)

                                Button {
                                    archivedAreasVM.restoreArea(strArea: area.strArea)
                                } label: {
                                    Image(systemName: "plus.app.fill")
                                }
                                .tint(.green)
                            }
                        }
                    }
                }
                Section(header: Text("Kategorier")) {
                    if hasArchivedCategories == true {
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
                    if archivedMealsVM.archivedMeals.isEmpty {
                        Text("Ingen arkiverte oppskrifter")
                        // Vise liste over arkiverte oppskrifter
                    } else {
                        ForEach(archivedMealsVM.archivedMeals, id: \.idMeal) { meal in
                            HStack {
                                Text(meal.strMeal)
                            }
                            .swipeActions(edge: .trailing, allowsFullSwipe: false) {
                                Button {
                                    archivedMealsVM.deleteMeal(id: meal.idMeal)
                                } label: {
                                    Image(systemName: "trash")
                                }
                                .tint(.red)

                                Button {
                                    archivedMealsVM.restoreMeal(id: meal.idMeal)
                                } label: {
                                    Image(systemName: "plus.app.fill")
                                }
                                .tint(.green)
                            }
                        }
                    }
                }
                .navigationTitle("Arkiv")
            }
            .onAppear {
                archivedMealsVM.getArchivedMeals()
                archivedAreasVM.getArchivedAreas()
            }
        }
    }


#Preview {
    ArchiveView()
}
