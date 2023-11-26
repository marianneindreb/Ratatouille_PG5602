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
            AreaFilterView(viewModel: AreasViewModel())
            
        case .category:
            CategoryFilterView(viewModel: CategoriesViewModel())
        case .ingredient:
            IngredientFilterView(viewModel: IngredientsViewModel())
        
        case .search:
            Text("Søk")
        }
    }
    
}
    
    #Preview {
        SearchView()
    }

