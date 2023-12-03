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
    @State private var editedAreaName: String = ""
    
    // Arkivere landområder, redigere dem og legge til nye
    // I vinduet for innstillinger skal du kunne importere landområder, kategorier og ingredienser fra API til databasen.
    // Du skal ha muligheten til å opprette, redigere og arkivere landområder, kategorier og ingredienser, som illustrert i eksemplene nedenfor.
    
    var body: some View {
        ZStack {
            VStack {
                            if viewModel.areas.isEmpty {
                                Text("Du har arkivert alle områder. Gå til 'Administrer arkiv' for å hente noen tilbake")
                                    .font(.headline)
                                    .padding(20)
                            } else {
                                List(viewModel.filteredAreas, id: \.id) { area in
                                    HStack {
                                        if viewModel.editingArea == area.strArea {
                                            TextField("Nytt navn", text: $editedAreaName)
                                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                            
                                            Button("Lagre") {
                                                viewModel.saveEditedArea(originalName: area.strArea, newName: editedAreaName)
                                                viewModel.editingArea = nil
                                            }
                                            .buttonStyle(BorderlessButtonStyle())
                                        } else {
                                            Text(area.strArea)
                                            Spacer()
                                        }
                                    }
                                    .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                                        Button {
                                            viewModel.archiveArea(strArea: area.strArea)
                                        } label: {
                                            Image(systemName: "archivebox")
                                        }
                                        .tint(.brandSecondary)

                                        Button {
                                            editedAreaName = area.strArea
                                            viewModel.editingArea = area.strArea
                                        } label: {
                                            Text("Rediger")
                                        }
                                        .tint(.blue)
                                    }
                                }
                                .listStyle(PlainListStyle())
                }
            }
            .searchable(text: $viewModel.searchText, prompt: "Søk etter landområder")
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
