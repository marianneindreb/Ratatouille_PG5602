//
//  EditIngredientDetailsView.swift
//  Ratatouille_PG5602
//
//  Created by Marianne Indrebø on 02/12/2023.
//

import Foundation
import SwiftUI

struct EditIngredientDetailsView: View {
    @ObservedObject var viewModel: IngredientsViewModel
    @State private var ingredient: IngredientModel
    @State var didArchive: Bool = false
    @State private var isEditing: Bool = false
    @State private var editableIngredientName: String

    init(ingredient: IngredientModel, ingredientsViewModel: IngredientsViewModel) {
        self.ingredient = ingredient
        self.viewModel = ingredientsViewModel
        _editableIngredientName = State(initialValue: ingredient.strIngredient)
    }

    var body: some View {
        VStack {
            if isEditing {
                TextField("Legg til ny ingrediens", text: $editableIngredientName)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
            } else {
                Text(editableIngredientName.count > 0 ? editableIngredientName : ingredient.strIngredient)
                    .font(.headline)
            }
            Spacer()

            if isEditing {
                Button("Lagre endringer") {
                    viewModel.updateIngredient(idIngredient: ingredient.strIngredient, newName: editableIngredientName)
                    isEditing = false
                }
                .padding(20)
                .background(Color.green)
                .foregroundColor(.white)
                .cornerRadius(10)

                Button("Avbryt") {
                    isEditing = false
                    editableIngredientName = ingredient.strIngredient
                }
                .padding(20)
                .background(Color.red)
                .foregroundColor(.white)
                .cornerRadius(10)
            } else {
                Button("Rediger ingrediens") {
                    isEditing = true
                }
                .padding(20)
                .background(Color.brandPrimary)
                .foregroundColor(.black)
                .cornerRadius(15)
                .shadow(color: Color.black.opacity(0.3), radius: 5, x: 0, y: 2)

                Button {
                    if !didArchive {
                        viewModel.archiveIngredient(idIngredient: ingredient.idIngredient)
                        didArchive = true
                        viewModel.loadIngredientsFromCoreData()
                    }

                } label: {
                    Text(didArchive ? "Arkivert!" : "Arkiver ingrediens")
                        .padding(20)
                        .frame(maxWidth: .infinity)
                        .background(didArchive ? Color.gray : Color.brandSecondary)
                        .foregroundColor(.white)
                        .fontWeight(.bold)
                        .textCase(.uppercase)
                        .cornerRadius(15)
                        .shadow(color: Color.black.opacity(0.3), radius: 5, x: 0, y: 2)
                }
                .disabled(didArchive)
            }
        }
    }
}

#Preview {
    EditIngredientDetailsView(ingredient: IngredientModel(idIngredient: "123", strIngredient: "Chicken"), ingredientsViewModel: IngredientsViewModel(loadFrom: .coreData))
}
