//
//  EditAreaDetailsView.swift
//  Ratatouille_PG5602
//
//  Created by Marianne Indrebø on 02/12/2023.
//

import Foundation
import SwiftUI

struct EditAreasDetailsView: View {
    @ObservedObject var viewModel: AreasViewModel
    @State private var area: AreaModel
    @State var didArchive: Bool = false
    @State private var isEditing: Bool = false
    @State private var editableAreaName: String
    // Arkivere landområder, redigere dem og legge til nye
    // I vinduet for innstillinger skal du kunne importere landområder, kategorier og ingredienser fra API til databasen.
    // Du skal ha muligheten til å opprette, redigere og arkivere landområder, kategorier og ingredienser, som illustrert i eksemplene nedenfor.

    init(area: AreaModel, areasViewModel: AreasViewModel) {
        self.area = area
        self.viewModel = areasViewModel
        _editableAreaName = State(initialValue: area.strArea)
    }

    var body: some View {
        VStack {
            if isEditing {
                TextField("Landområde", text: $editableAreaName)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
            } else {
                Text(editableAreaName.count > 0 ? editableAreaName : area.strArea)
                    .font(.headline)
            }
            Spacer()

            if isEditing {
                Button("Lagre endringer") {
                    viewModel.updateArea(strArea: area.strArea, newName: editableAreaName)
                    isEditing = false
                }
                .padding(20)
                .background(Color.green)
                .foregroundColor(.white)
                .cornerRadius(10)

                Button("Avbryt") {
                    isEditing = false
                    editableAreaName = area.strArea
                }
                .padding(20)
                .background(Color.red)
                .foregroundColor(.white)
                .cornerRadius(10)
            } else {
                Button("Rediger landområde") {
                    isEditing = true
                }
                .padding(20)
                .background(Color.brandPrimary)
                .foregroundColor(.black)
                .cornerRadius(15)
                .shadow(color: Color.black.opacity(0.3), radius: 5, x: 0, y: 2)

                Button {
                    if !didArchive {
                        viewModel.archiveArea(strArea: area.strArea)
                        didArchive = true
                        viewModel.loadAreasFromCoreData()
                    }

                } label: {
                    Text(didArchive ? "Arkivert!" : "Arkiver landområde")
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
    EditAreasDetailsView(area: AreaModel(strArea: "Canadian"), areasViewModel: AreasViewModel(loadFrom: .API))
}
