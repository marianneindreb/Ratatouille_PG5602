import SwiftUI
import Kingfisher

struct IngredientFilterView: View {
    @Binding var viewModel: IngredientsViewModel
    @State private var selectedOption = "Velg hovedingrediens"
    
    
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    Menu {
                        ForEach(viewModel.ingredients, id: \.idIngredient) { ingredient in
                            Button(action: {
                                self.selectedOption = ingredient.strIngredient
                                viewModel.fetchMealsFromAPI(forIngredient: selectedOption)
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
                    .foregroundColor(.gray)
            }
            .padding()
            .padding(.horizontal, 10)
            .frame(width: 370)
            .background(Color.white)
            .foregroundColor(.black)
            .font(.headline)
            .cornerRadius(10)
            .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 2)
                } .padding()
              
        
        
            List(viewModel.meals , id: \.idMeal) { meal in
                MealListItem(meal: meal)
            }
        }
    }
        .navigationTitle("Velg Ingrediens")
    }
}

#Preview {
    IngredientFilterView(viewModel: .constant(IngredientsViewModel()))
}
