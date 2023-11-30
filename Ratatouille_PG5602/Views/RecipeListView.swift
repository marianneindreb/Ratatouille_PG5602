
import SwiftUI

struct RecipeListView: View {
    
    @StateObject var viewModel = SavedMealsViewModel()
    
    var body: some View {
        ZStack(alignment: .topTrailing) {
            Image("logo")
                .resizable()
                .scaledToFit()
                .frame(width: 200, height: 200)
                .alignmentGuide(.top) { d in d[VerticalAlignment.center] }
                .padding(.top, -40)
            //                Image("logo")
            //                    .resizable()
            //                    .scaledToFit()
            //                    .frame(width: 300, height: 120)
            //                    .shadow(radius: 10)
            //                    .padding(.top, -10)
            
            
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
                                MealDetailView(id: meal.idMeal)
                            } label: {
                                MealListItem(meal: meal)
                            }
                            .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                                Button("Arkiver") {
                                    viewModel.archiveMeal()
                                }
                                .tint(.brandSecondary)
                                
                                Button {
                                    // edit meal
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
                
                .navigationTitle("Mine Oppskrifter")
               
                
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
