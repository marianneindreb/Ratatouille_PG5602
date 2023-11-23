//
//  categoryFiilterView.swift
//  Ratatouille_PG5602
//
//  Created by Marianne Indrebø on 21/11/2023.
//

import SwiftUI

struct areaFilterView: View {
    
    @StateObject var viewModel = AreaViewModel()
    @StateObject var cdm = CoreDataManager()
    // @State var selectedArea: String?
    
    @State private var selectedOption = "Canadian"
    @State private var optionsArray: [String] = []
    
    var options = ["American", "British", "Canadian", "Chinese", "Croatian", "Dutch", "Egyptian", "Filipino", "French", "Greek", "Indian", "Irish", "Italian", "Jamaican", "Japanese", "Kenyan", "Malaysian", "Mexican", "Moroccan", "Polish", "Portuguese", "Russian", "Spanish", "Thai", "Tunisian", "Turkish", "Unknown", "Vietnamese"]
    // Array skal komme fra Core Data
    
    
    
    var body: some View {
        VStack {
            Text("Hvilket land ønsker du oppskrifter fra?")
            HStack {
                Menu {
                    ForEach(optionsArray, id: \.self) { option in
                        Button(action: {
                            self.selectedOption = option
                            viewModel.getArea(area: selectedOption)
                        }) {
                            Text(option)
                                .foregroundColor(.gray)
                        }
                    }
                } label: {
                    Text("\(selectedOption)")
                        .fontWeight(.regular)
                    Spacer()
                    Image(systemName: "arrowtriangle.down")
                }
                .padding()
                .padding(.horizontal, 10)
                .frame(width: 300)
                .background(Color.black)
                .foregroundColor(.white)
                .font(.headline)
                .cornerRadius(10)
                .shadow(color: Color.black.opacity(0.3), radius: 5, x: 0, y: 2)
            }
            
            NavigationView {
                List(viewModel.area, id: \.idMeal) { area in
                    // Use properties of the AreaModel to display information
                    Text(area.strMeal)
                }
                .onAppear {
                    fetchAreasFromCoreData()
                    viewModel.getArea(area: selectedOption)
                }
                .alert(item: $viewModel.alertItem) { alertItem in
                    Alert(title: alertItem.title, message: alertItem.message, dismissButton: alertItem.dismissButton)
                }
            }
            
            // onAppear
            // onChange
            // if else - no result, else List
        }
    }
    
    
    private func fetchAreasFromCoreData() {
        // Fetch areas from Core Data and update the options array
        do {
            let areaEntities = try cdm.container.viewContext.fetch(AreaEntity.fetchRequest()) as! [AreaEntity]
            DispatchQueue.main.async {
                optionsArray = areaEntities.compactMap { $0.areaName }
                print("Options Array: \(optionsArray)")
            }
        } catch {
            print("Error fetching areas from Core Data: \(error)")
        }
    }
}
    

#Preview {
    areaFilterView()
}
