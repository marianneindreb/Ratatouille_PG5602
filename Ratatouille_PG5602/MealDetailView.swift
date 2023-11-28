import SwiftUI
import Kingfisher

struct MealDetailView: View {
    let meal: MealModel

    @State private var selectedTab: String = "Instructions"

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 10) {
                // Meal Image
                if let imageUrl = meal.strMealThumb, let url = URL(string: imageUrl) {
                    KFImage(url)
                        .resizable()
                        .scaledToFit()
                        .frame(height: 300)
                }

                Text(meal.strMeal)
                    .font(.title)
                    .fontWeight(.bold)


                Picker("Options", selection: $selectedTab) {
                    Text("Instructions").tag("Instructions")
                    Text("Ingredients").tag("Ingredients")
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding()

                if selectedTab == "Instructions" {
                    Text("Instruksjoner")
                        .font(.headline)
                    
                    Text(meal.strInstructions)
                        .font(.body)
                } else {
                    Text("Ingredienser")
                        .font(.headline)

                    VStack(alignment: .leading) {
                        ForEach(getIngredientList(), id: \.self) { ingredient in
                            Text(ingredient)
                                .font(.body)
                        }
                    }
                }
                Spacer()
                
                Button {
                //  saveRecipe(meal)
                } label: {
                    Text("Lagre oppskrift")
                        .padding(20)
                        .frame(maxWidth: .infinity)
                        .background(Color.brandPrimary)
                        .foregroundColor(.black)
                        .fontWeight(.bold)
                        .textCase(.uppercase)
                        .cornerRadius(15)
                        .shadow(color: Color.black.opacity(0.3), radius: 5, x: 0, y: 2)
                }
            }
            .padding()
        }
        .ignoresSafeArea(.container, edges: .top)
        .navigationBarTitle(meal.strMeal, displayMode: .inline)
    }

    private func saveRecipe( _ meal: MealModel) {
        // TODO:
        // Lagre oppskrift
    }
  
    private func getIngredientList() -> [String] {
        let ingredients = [
            meal.strIngredient1, meal.strIngredient2, meal.strIngredient3, meal.strIngredient4, meal.strIngredient5, meal.strIngredient6, meal.strIngredient7, meal.strIngredient8, meal.strIngredient9, meal.strIngredient10, meal.strIngredient11, meal.strIngredient12, meal.strIngredient13, meal.strIngredient14, meal.strIngredient15, meal.strIngredient16, meal.strIngredient17, meal.strIngredient18, meal.strIngredient19, meal.strIngredient20
        ]
        let measures = [
            meal.strMeasure1, meal.strMeasure2, meal.strMeasure3, meal.strMeasure4, meal.strMeasure5, meal.strMeasure6, meal.strMeasure7, meal.strMeasure8, meal.strMeasure9, meal.strMeasure10, meal.strMeasure11, meal.strMeasure12, meal.strMeasure13, meal.strMeasure14, meal.strMeasure15, meal.strMeasure16, meal.strMeasure17, meal.strMeasure18, meal.strMeasure19, meal.strMeasure20
        ]

        var ingredientList = [String]()
        for (ingredient, measure) in zip(ingredients, measures) {
            if let ing = ingredient, !ing.isEmpty {
                ingredientList.append("\(ing) - \(measure ?? "")")
            }
        }
        return ingredientList
    }
}


#Preview {
    MealDetailView(meal: MealModel.sampleMeal)
}



