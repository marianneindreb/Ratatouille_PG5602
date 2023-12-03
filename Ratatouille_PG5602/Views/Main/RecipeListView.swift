
import SwiftUI

struct RecipeListView: View {
    
    @StateObject var viewModel = SavedMealsViewModel()
    
    var body: some View {
        ZStack(alignment: .topTrailing) {
            
            NavigationView {
                VStack() {
                    if viewModel.savedMeals.isEmpty {
                        VStack {
                            Image("rat1")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 150, height: 150)
                            Text("Du har ikke lagret noen oppskrifter")
                                .font(.headline)
                        }
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
                                .tint(.brandSecondary)
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
            Spacer(minLength: 0)
        }
    }
}


#Preview {
    RecipeListView()
}
