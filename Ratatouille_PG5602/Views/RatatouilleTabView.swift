//
//  TabView.swift
//  Ratatouille_PG5602
//
//  Created by Marianne Indrebø on 16/11/2023.
//

import SwiftUI

struct RatatouilleTabView: View {
    var body: some View {
        TabView {
           // RecipeListView()
//                .tabItem {
//                    Image(systemName: "fork.knife")
//                    Text("Mine Oppskrifter")
//                }
            SearchView()
                .tabItem {
                    Image(systemName: "magnifyingglass")
                    Text("Søk")
                }
            SettingsView()
                .tabItem {
                    Image(systemName: "gear")
                    Text("Innstillinger")
                }
        }
        .accentColor(Color("brandPrimary"))
    }
}

#Preview {
    RatatouilleTabView()
}
