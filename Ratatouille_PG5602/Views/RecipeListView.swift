
import SwiftUI

struct RecipeListView: View {
    
    @StateObject var viewModel = SavedMealsViewModel()
    
    var body: some View {
        VStack(spacing: 0) {
                Image("logo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 300, height: 120)
                    .shadow(radius: 10)
                    .padding(.top, -10)

            
            NavigationView {
                ZStack {
                    if viewModel.savedMeals.isEmpty {
                        VStack {
                            Image("rat1")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 150, height: 150)
                            Text("Du har ikke lagret noen oppskrifter")
                        }
                    } else {
                        List(viewModel.savedMeals, id: \.idMeal) { meal in
                            MealListItem(meal: meal)
                                .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                                    Button("Arkiver") {
                                        viewModel.archiveMeal()
                                    }
                                    .tint(.brandSecondary)
                                    
                                    Button {
                                       // isFavorited = true
                                    } label: {
                                        Image(systemName: "square.and.pencil")
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 25)
                                            .shadow(radius: 10)
                                        
                                    }
                                }
                        }
                        .listStyle(PlainListStyle())
                      
                    }
                }
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
