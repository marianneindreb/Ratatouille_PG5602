//
//  EditAreasSettingsView.swift
//  Ratatouille_PG5602
//
//  Created by Marianne Indrebø on 02/12/2023.
//

import SwiftUI

struct EditAreasSettingsView: View {
    @ObservedObject var viewModel = AreasViewModel(loadFrom: .coreData)

    //TODO: Add categories. Fetch from core data which are
    var body: some View {
        VStack() {
            if viewModel.areas.isEmpty {
                VStack {
                    Text("Du har arkivert alle områder. Gå til 'Administrer arkiv' for å hente noen tilbake")
                        .font(.headline)
                }
            } else {
                List(viewModel.areas, id: \.strArea) { area in
                    Text(area.strArea)
                    .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                        Button("Arkiver") {
                            viewModel.archiveArea(strArea: area.strArea)
                        }
                        .tint(.brandSecondary)
                    }
                }
                .listStyle(PlainListStyle())
            }
        }
    }
}

#Preview {
    EditAreasSettingsView()
}
