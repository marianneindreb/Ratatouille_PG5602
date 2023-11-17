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
            RecipeListView()
                .tabItem {
                    Image(systemName: "house")
                    Text("Mine Oppskrifter")
                }
            SearchView()
                .tabItem {
                    Image(systemName: "house")
                    Text("Mine Oppskrifter")
                }
            SettingsView()
                .tabItem {
                    Image(systemName: "house")
                    Text("Mine Oppskrifter")
                }
        }
    }
}

#Preview {
    RatatouilleTabView()
}
