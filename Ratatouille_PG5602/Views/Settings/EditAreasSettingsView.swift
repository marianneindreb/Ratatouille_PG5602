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
    
    var body: some View {
        ZStack {
            VStack {
                if viewModel.areas.isEmpty {
                    VStack {
                        
                        Text("Du har arkivert alle områder. Gå til 'Administrer arkiv' for å hente noen tilbake.")
                            .font(.title3)
                            .padding(80)
                        
                        Spacer()
                        
                        Image("chefshead")
                            .resizable()
                            .frame(width: 500, height: 500)
                    }
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
                                
                                if let flagURL = area.flagURL, let url = URL(string: flagURL) {
                                    AsyncImage(url: url) { image in
                                        image.resizable()
                                            .scaledToFit()
                                    } placeholder: {
                                        ProgressView()
                                    }
                                    .frame(width: 30, height: 20)
                                    .clipShape(RoundedRectangle(cornerRadius: 5))
                                }
                                Spacer()
                                Image(systemName: "ellipsis")
                                    .foregroundColor(.gray)
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
            
            
            if showingAddAreaModal {
                Color.black.opacity(0.4)
                    .edgesIgnoringSafeArea(.all)
                    .onTapGesture {
                        showingAddAreaModal = false
                    }
                
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
