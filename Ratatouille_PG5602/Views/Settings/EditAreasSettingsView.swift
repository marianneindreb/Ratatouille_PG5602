//
//  EditAreasSettingsView.swift
//  Ratatouille_PG5602
//
//  Created by Marianne Indrebø on 02/12/2023.
//

import SwiftUI

struct EditAreasSettingsView: View {
    @StateObject var viewModel = AreasViewModel(loadFrom: .coreData)
    @State private var showingAddAreaModal = false
    
    // Arkivere landområder, redigere dem og legge til nye
    // I vinduet for innstillinger skal du kunne importere landområder, kategorier og ingredienser fra API til databasen.
    // Du skal ha muligheten til å opprette, redigere og arkivere landområder, kategorier og ingredienser, som illustrert i eksemplene nedenfor.
    
    var body: some View {
        ZStack {
            VStack() {
                if viewModel.areas.isEmpty {
                    VStack {
                        Text("Du har arkivert alle områder. Gå til 'Administrer arkiv' for å hente noen tilbake")
                            .font(.headline)
                            .padding(20)
                    }
                } else {
                    List(viewModel.areas, id: \.strArea) { area in
                        HStack {
                            NavigationLink {
                                EditAreasDetailsView(area: area, areasViewModel: viewModel)
                            } label: {
                                Text(area.strArea)
                            }
                            //TODO: flag, area.flagURL. Liten og rund.
                            
                        }
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
            .navigationBarTitle("Landområder", displayMode: .inline)
            .navigationBarItems(trailing: addButton)

            // Custom modal presentation
            if showingAddAreaModal {
                // Overlay for dimming the background
                Color.black.opacity(0.4)
                    .edgesIgnoringSafeArea(.all)
                    .onTapGesture {
                        showingAddAreaModal = false
                    }

                // Modal content
                AddAreaModal(isPresented: $showingAddAreaModal, viewModel: viewModel)
                    .frame(width: 300, height: 300)
                    .background(Color.white)
                    .cornerRadius(15)
                    .shadow(radius: 10)
            }
        }
    }

    private var addButton: some View {
        Button(action: {
            showingAddAreaModal = true
        }) {
            Image(systemName: "plus")
        }
    }
}
#Preview {
    EditAreasSettingsView()
}
