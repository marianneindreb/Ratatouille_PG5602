import SwiftUI
import Kingfisher

struct IngredientFilterView: View {
 @StateObject var viewModel: IngredientsViewModel
@State private var selectedOption = "Velg hovedingrediens"
    
        
        var body: some View {
            VStack {
                Text("Hvilken hovedingrediens ønsker du oppskrifter fra?")
                HStack {
                    Menu {
                        ForEach(viewModel.ingredients, id: \.ingredientId) { ingredient in
                            Button(action: {
                                self.selectedOption = ingredient.strIngredient
                                
                                viewModel.fetchMeals(forIngredient: ingredient.strIngredient)
                                print( viewModel.fetchMeals(forIngredient: ingredient.strIngredient))
                                
                            }) {
                                
                                Text(ingredient.strIngredient)
                                    .foregroundColor(.gray)
                            }
                        }
                    
                
            } label: {
                Text("\(selectedOption)")
                    .fontWeight(.regular)
                
                
                Spacer()
                Image(systemName: "arrowtriangle.down")
            }
            .padding()
            .padding(.horizontal, 10)
            .frame(width: 300)
            .background(Color.black)
            .foregroundColor(.white)
            .font(.headline)
            .cornerRadius(10)
            .shadow(color: Color.black.opacity(0.3), radius: 5, x: 0, y: 2)
        }
              
        
        NavigationView {
            List(viewModel.meals , id: \.idMeal) { meal in
                MealListItem(meal: meal)
            }
        }
    }
        .onAppear {
            viewModel.getIngredientsFromCoreDataIfNeeded()
        }
        .navigationTitle("Oppskrifter")
    }
}

#Preview {
    IngredientFilterView(viewModel: IngredientsViewModel())
}
