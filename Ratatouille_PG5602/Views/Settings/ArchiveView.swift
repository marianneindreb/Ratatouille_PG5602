import Foundation
import SwiftUI

struct ArchiveView: View {
    @ObservedObject var archivedMealsVM = ArchivedMealsViewModel()
    @ObservedObject var archivedAreasVM = ArchivedAreasViewModel()
    @ObservedObject var archivedIngredientsVM = ArchivedIngredientsViewModel()
    @ObservedObject var archivedCategoriesVM = ArchivedCategoriesViewModel()
    
    @State var hasArchivedAreas: Bool = false
    @State var hasArchivedCategories: Bool = false
    @State var hasArchivedIngredients: Bool = false
    @State var hasArchivedMeals: Bool = false
    
    var body: some View {
        Form {
            Section(header: Text("Landområder")) {
                if archivedAreasVM.archivedAreas.isEmpty {
                    Text("Ingen arkiverte landområder")
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
                if archivedCategoriesVM.archivedCategories.isEmpty {
                    Text("Ingen arkiverte kategorier")
                } else {
                    ForEach(archivedCategoriesVM.archivedCategories, id: \.strCategory) { category in
                        HStack {
                            Text(category.strCategory)
                        }
                        .swipeActions(edge: .trailing, allowsFullSwipe: false) {
                            Button {
                                archivedCategoriesVM.deleteCategory(strCategory: category.strCategory)
                            } label: {
                                Image(systemName: "trash")
                            }
                            .tint(.red)
                            
                            Button {
                                archivedCategoriesVM.restoreCategory(strCategory: category.strCategory)
                            } label: {
                                Image(systemName: "plus.app.fill")
                            }
                            .tint(.green)
                        }
                        
                    }
                }
            }
            
            Section(header: Text("Ingredienser")) {
                if archivedIngredientsVM.archivedIngredients.isEmpty{
                    Text("Ingen arkiverte ingredienser")
                } else {
                    ForEach(archivedIngredientsVM.archivedIngredients, id: \.strIngredient) { ingredient in
                        HStack {
                            Text(ingredient.strIngredient)
                        }
                        .swipeActions(edge: .trailing, allowsFullSwipe: false) {
                            Button {
                                archivedIngredientsVM.deleteIngredient(strIngredient: ingredient.strIngredient)
                            } label: {
                                Image(systemName: "trash")
                            }
                            .tint(.red)
                            
                            Button {
                                archivedIngredientsVM.restoreIngredient(strIngredient: ingredient.strIngredient)
                            } label: {
                                Image(systemName: "plus.app.fill")
                            }
                            .tint(.green)
                        }
                        
                    }
                }
            }
            Section(header: Text("Oppskrifter")) {
                if archivedMealsVM.archivedMeals.isEmpty {
                    Text("Ingen arkiverte oppskrifter")
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
            archivedCategoriesVM.getArchivedCategories()
            archivedIngredientsVM.getArchivedIngredients()
        }
    }
}


#Preview {
    ArchiveView()
}
