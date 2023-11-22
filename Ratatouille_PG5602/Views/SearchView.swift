//
//  SearchView.swift
//  Ratatouille_PG5602
//
//  Created by Marianne Indrebø on 16/11/2023.
//

import SwiftUI

struct SearchView: View {
  //  @StateObject var viewModel = MealListViewModel()
    @State private var selectedFilter: Filters = .area
    
  
    
    var body: some View {
        NavigationView {
            VStack {
                Picker("Søk", selection: $selectedFilter) {
                    ForEach(Filters.allCases, id: \.self) {
                        Text($0.rawValue)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                
                Spacer()
                ChosenFilterView(selectedFilter: selectedFilter)
                }
                .navigationTitle("Søk")
            }
        }
    }
enum Filters: String, CaseIterable {
    case area = "Landområde"
    case category = "Kategori"
    case ingredient = "Ingrediens"
    case search = "Søk"
}

struct ChosenFilterView: View {
    var selectedFilter: Filters
    
    var body: some View {
        switch selectedFilter {
        case .area:
            areaFilterView()
        case .category:
            Text("Kategori")
        case .ingredient:
            Text("Ingrediens")
        case .search:
            Text("Søk")
        }
    }
    
}
    
    #Preview {
        SearchView()
    }

