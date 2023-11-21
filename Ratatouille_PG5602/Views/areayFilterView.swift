//
//  categoryFiilterView.swift
//  Ratatouille_PG5602
//
//  Created by Marianne Indrebø on 21/11/2023.
//

import SwiftUI

struct areaFilterView: View {
    
    @Published var areas: [AreaModel] = []
    
    @State private var selectedOption = "Norway"
    let options = ["American", "British", "Canadian", "Chinese", "Croatian", "Dutch", "Egyptian", "Filipino", "French", "Greek", "Indian", "Irish", "Italian", "Jamaican", "Japanese", "Kenyan", "Malaysian", "Mexican", "Moroccan", "Polish", "Portuguese", "Russian", "Spanish", "Thai", "Tunisian", "Turkish", "Unknown", "Vietnamese"]
    
    var body: some View {
        VStack {
            Text("Hvilket land ønsker du oppskrifter fra?")
            HStack {
                Menu {
                    ForEach(options, id: \.self) { option in
                        Button(action: {
                            self.selectedOption = option
                        }) {
                            Text(option)
                                .foregroundColor(.gray) // Set the desired text color
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
                .frame(width: .infinity)
                .foregroundColor(.white)
                .font(.headline)
                .cornerRadius(10)
                .shadow(color: Color.black.opacity(0.3), radius: 5, x: 0, y: 2)
            }
        }
    }
}
          

#Preview {
    areaFilterView()
}
