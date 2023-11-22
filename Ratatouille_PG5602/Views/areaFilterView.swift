//
//  categoryFiilterView.swift
//  Ratatouille_PG5602
//
//  Created by Marianne Indrebø on 21/11/2023.
//

import SwiftUI

struct areaFilterView: View {
    
    @StateObject var viewModel = AreaViewModel()
    
    @State private var selectedOption = "Canadian"
    let options = ["American", "British", "Canadian", "Chinese", "Croatian", "Dutch", "Egyptian", "Filipino", "French", "Greek", "Indian", "Irish", "Italian", "Jamaican", "Japanese", "Kenyan", "Malaysian", "Mexican", "Moroccan", "Polish", "Portuguese", "Russian", "Spanish", "Thai", "Tunisian", "Turkish", "Unknown", "Vietnamese"]
    // Array skal komme fra Core Data
    
    //    @State var selectedArea: String?
    //    @StateObject var cdm = CoreDataManager()
    //    @StateObject var avm =  AreaViewModel()
    
    var body: some View {
        VStack {
            Text("Hvilket land ønsker du oppskrifter fra?")
            HStack {
                Menu {
                    ForEach(options, id: \.self) { option in
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
}

#Preview {
    areaFilterView()
}
