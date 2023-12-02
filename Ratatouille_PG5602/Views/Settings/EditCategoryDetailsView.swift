//
//  EditCategoryDetailsView.swift
//  Ratatouille_PG5602
//
//  Created by Marianne Indrebø on 02/12/2023.
//

import Foundation
import SwiftUI

struct EditCategoryDetailsView: View {
    @ObservedObject var viewModel: CategoriesViewModel
    @State private var category: CategoryModel
    @State var didArchive: Bool = false
    @State private var isEditing: Bool = false
    @State private var editableCategoryName: String

    init(category: CategoryModel, categoriesViewModel: CategoriesViewModel) {
        self.category = category
        self.viewModel = categoriesViewModel
        _editableCategoryName = State(initialValue: category.strCategory)
    }

    var body: some View {
        VStack {
            if isEditing {
                TextField("Kategori", text: $editableCategoryName)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
            } else {
                Text(editableCategoryName.count > 0 ? editableCategoryName : category.strCategory)
                    .font(.headline)
            }
            Spacer()

            if isEditing {
                Button("Lagre endringer") {
                    viewModel.updateCategory(strCategory: category.strCategory, newName: editableCategoryName)
                    isEditing = false
                }
                .padding(20)
                .background(Color.green)
                .foregroundColor(.white)
                .cornerRadius(10)

                Button("Avbryt") {
                    isEditing = false
                    editableCategoryName = category.strCategory
                }
                .padding(20)
                .background(Color.red)
                .foregroundColor(.white)
                .cornerRadius(10)
            } else {
                Button("Rediger kategori") {
                    isEditing = true
                }
                .padding(20)
                .background(Color.brandPrimary)
                .foregroundColor(.black)
                .cornerRadius(15)
                .shadow(color: Color.black.opacity(0.3), radius: 5, x: 0, y: 2)

                Button {
                    if !didArchive {
                        viewModel.archiveCategory(strCategory: category.strCategory)
                        didArchive = true
                        viewModel.loadCategoriesFromCoreData()
                    }

                } label: {
                    Text(didArchive ? "Arkivert!" : "Arkiver kategori")
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
    EditCategoryDetailsView(category: CategoryModel(strCategory: "Desert"), categoriesViewModel: CategoriesViewModel(loadFrom: .API))
}
