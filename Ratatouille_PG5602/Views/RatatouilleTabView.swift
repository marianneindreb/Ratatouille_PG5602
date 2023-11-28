import SwiftUI

struct RatatouilleTabView: View {
    @Binding var areasViewModel: AreasViewModel
    @Binding var categoriesViewModel: CategoriesViewModel
    @Binding var ingredientsViewModel: IngredientsViewModel
    
    var body: some View {
        TabView {
            RecipeListView()
                .tabItem {
                    Image(systemName: "fork.knife")
                    Text("Mine Oppskrifter")
                }
            SearchView(areasViewModel: $areasViewModel, categoriesViewModel: $categoriesViewModel, ingredientsViewModel: $ingredientsViewModel)
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
    RatatouilleTabView(areasViewModel: .constant(AreasViewModel()), categoriesViewModel: .constant(CategoriesViewModel()), ingredientsViewModel: .constant(IngredientsViewModel()))
}
