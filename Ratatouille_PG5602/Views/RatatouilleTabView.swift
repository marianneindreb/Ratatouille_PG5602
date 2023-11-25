import SwiftUI

struct RatatouilleTabView: View {
    var body: some View {
        TabView {
            RecipeListView()
                .tabItem {
                    Image(systemName: "fork.knife")
                    Text("Mine Oppskrifter")
                }
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
