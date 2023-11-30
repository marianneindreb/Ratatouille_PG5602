import SwiftUI

struct SearchView: View {
    //  @StateObject var viewModel = MealListViewModel()
    @State private var selectedFilter: Filters = .area
    @Binding var areasViewModel: AreasViewModel
    @Binding var categoriesViewModel: CategoriesViewModel
    @Binding var ingredientsViewModel: IngredientsViewModel
    @Binding var mealViewModel: MealViewModel
    
    
    
    var body: some View {
        NavigationView {
            VStack {
                Picker("Søk", selection: $selectedFilter) {
                    ForEach(Filters.allCases, id: \.self) {
                        Text($0.rawValue)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                
                ChosenFilterView(areasViewModel: $areasViewModel, categoriesViewModel: $categoriesViewModel, ingredientsViewModel: $ingredientsViewModel, mealViewModel: $mealViewModel, selectedFilter: selectedFilter)
                
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
    
    @Binding var areasViewModel: AreasViewModel
    @Binding var categoriesViewModel: CategoriesViewModel
    @Binding var ingredientsViewModel: IngredientsViewModel
    @Binding var mealViewModel: MealViewModel
    var selectedFilter: Filters
    
    var body: some View {
        switch selectedFilter {
        case .area:
            AreaFilterView(viewModel: areasViewModel)
        case .category:
            CategoryFilterView(viewModel: categoriesViewModel)
        case .ingredient:
            IngredientFilterView(viewModel: ingredientsViewModel)
            
        case .search:
            SearchFilterView(viewModel: mealViewModel)
        }
    }
    
}

#Preview {
    SearchView(
        areasViewModel: .constant(AreasViewModel()),
        categoriesViewModel: .constant(CategoriesViewModel()),
        ingredientsViewModel: .constant(IngredientsViewModel()),
        mealViewModel: .constant(MealViewModel())
    )
}

