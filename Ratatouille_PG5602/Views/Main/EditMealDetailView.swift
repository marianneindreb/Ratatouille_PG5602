//
//  EditMealDetailView.swift
//  Ratatouille_PG5602
//
//  Created by Marianne Indrebø on 03/12/2023.
//

import SwiftUI

struct EditMealDetailView: View {
    @ObservedObject var viewModel: MealDetailViewModel
    @State private var title: String = ""
    @State private var description: String = ""
    @State private var imageUrl: String = ""
    @State private var ingredients: [String] = []
    
    init(meal: MealModel) {
        viewModel = MealDetailViewModel(meal: meal)
        _title = State(initialValue: meal.strMeal)
        _description = State(initialValue: meal.strInstructions)
        _imageUrl = State(initialValue: meal.strMealThumb ?? "")
        _ingredients = State(initialValue: getIngredientList(meal: meal))
    }
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 10) {
                Text("Oppskrift")
                    .font(.subheadline)
                    .foregroundStyle(.gray)
                TextField("Oppskrift", text: $title)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                Text("Bilde-URL")
                    .font(.subheadline)
                    .foregroundStyle(.gray)
                    .padding(.top)
                TextField("Legg inn nytt bilde med URL", text: $imageUrl)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                Text("Beskrivelse")
                    .font(.subheadline)
                    .foregroundStyle(.gray)
                    .padding(.top)
                TextEditor(text: $description)
                    .frame(minHeight: 150)
                    .overlay(
                        RoundedRectangle(cornerRadius: 5)
                            .stroke(Color.gray, lineWidth: 1)
                    )
                
                Text("Ingredienser og mengde")
                    .font(.subheadline)
                    .foregroundStyle(.gray)
                    .padding(.top)
                ForEach($ingredients.indices, id: \.self) { index in
                    TextField("Ingrediens", text: $ingredients[index])
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                }
                
                Button("Lagre endringer") {
                    viewModel.updateMeal(title: title, description: description, imageUrl: imageUrl, ingredients: ingredients)
                }
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color.green)
                .foregroundColor(.white)
                .cornerRadius(10)
            }
            .padding()
        }
    }
}

private func getIngredientList(meal: MealModel) -> [String] {
    var ingredientList = [String]()
    
    let ingredients = [
        meal.strIngredient1, meal.strIngredient2, meal.strIngredient3, meal.strIngredient4, meal.strIngredient5, meal.strIngredient6, meal.strIngredient7, meal.strIngredient8, meal.strIngredient9, meal.strIngredient10, meal.strIngredient11, meal.strIngredient12, meal.strIngredient13, meal.strIngredient14, meal.strIngredient15, meal.strIngredient16, meal.strIngredient17, meal.strIngredient18, meal.strIngredient19, meal.strIngredient20
    ]
    let measures = [
        meal.strMeasure1, meal.strMeasure2, meal.strMeasure3, meal.strMeasure4, meal.strMeasure5, meal.strMeasure6, meal.strMeasure7, meal.strMeasure8, meal.strMeasure9, meal.strMeasure10, meal.strMeasure11, meal.strMeasure12, meal.strMeasure13, meal.strMeasure14, meal.strMeasure15, meal.strMeasure16, meal.strMeasure17, meal.strMeasure18, meal.strMeasure19, meal.strMeasure20
    ]
    
    for (ingredient, measure) in zip(ingredients, measures) {
        if let ing = ingredient, !ing.isEmpty {
            let ingredientString = "\(ing) - \(measure ?? "")"
            ingredientList.append(ingredientString)
        }
    }
    
    return ingredientList
    
}

#Preview {
    EditMealDetailView(meal: MealModel.sampleMeal)
}
