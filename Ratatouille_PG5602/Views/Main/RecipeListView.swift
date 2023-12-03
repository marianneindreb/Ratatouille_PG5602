
import SwiftUI

struct RecipeListView: View {
    
    @StateObject var viewModel = SavedMealsViewModel()
    
    var body: some View {
        ZStack(alignment: .topTrailing) {
            
            NavigationView {
                VStack() {
                    if viewModel.savedMeals.isEmpty {
                        VStack {
                            Text("Du har ikke lagret noen oppskrifter.")
                                .font(.title3)
                                .frame(maxWidth: .infinity, alignment: .leading)
                            Text("Gå til søkesiden for å utforske nye og spennende retter! ")
                                .font(.subheadline)
                                .frame(maxWidth: .infinity, alignment: .leading)
                            
                            Image("chefshead")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 600, height: 400)
                            
                        }
                        .padding()
                    } else {
                        List(viewModel.savedMeals, id: \.idMeal) { meal in
                            NavigationLink {
                                MealDetailView(meal: meal, saveMealsModel: viewModel)
                            } label: {
                                MealListItem(meal: MealListItemModel(strMeal: meal.strMeal, strMealThumb: meal.strMealThumb, idMeal: meal.idMeal))
                            }
                            .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                                Button("Arkiver", systemImage: "archivebox") {
                                    viewModel.archiveMeal(id: meal.idMeal)
                                }
                                .tint(.brandPrimary)
                            }
                        }
                        .listStyle(PlainListStyle())
                    }
                }
                .navigationTitle("Mine oppskrifter")
                .navigationBarItems(leading:
                                        HStack {
                    Image("logo.sign")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100)
                }
                )
            }
            .onAppear {
                viewModel.getSavedMeals()
            }
            if viewModel.isLoading {
                LoadingView()
            }
        }
    }
}


#Preview {
    RecipeListView()
}
