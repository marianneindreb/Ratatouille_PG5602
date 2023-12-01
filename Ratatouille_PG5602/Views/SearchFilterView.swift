import SwiftUI
import Kingfisher

struct SearchFilterView: View {
    @State var searchText = ""
    // @State private var meals: [MealModel] = []
    @State private var meals: [MealListItemModel] = []
    @StateObject var viewModel: SearchViewModel
    @StateObject var savedMealsViewModel = SavedMealsViewModel()
    
    
    
    var body: some View {
        ZStack(alignment: .trailing) {
            List(viewModel.meals, id: \.idMeal) { meal in
                NavigationLink {
                    MealDetailView(id: meal.idMeal)
                } label: {
                    MealListItem(meal: MealListItemModel.init(strMeal: meal.strMeal, strMealThumb: meal.strMealThumb, idMeal: meal.idMeal))
                }
                .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                    Button("Lagre") {
                        savedMealsViewModel.saveMeal(MealListItemModel(strMeal: meal.strMeal, strMealThumb: meal.strMealThumb, idMeal: meal.idMeal))
                    }
                    .tint(.brandSecondary)
                }
            }
            .listStyle(PlainListStyle())
        }
        .searchable(text: $searchText, prompt: "Pie")
        .onSubmit(of: .search ) {
            print("blablabla")
            viewModel.fetchSearchResult(searchText)
        }
        
        
    }
}


#Preview {
    SearchFilterView(viewModel: SearchViewModel())
}
//
//var body: some View {
//    ZStack(alignment: .trailing) {
//    }
//     .searchable(text: $searchText, prompt: "Pie")
//            .onChange(of: searchText ) { textSearch in
//                print("blablabla")
//                viewModel.fetchSearchResult(textSearch)
//            }
//
//    List(viewModel.meals, id: \.idMeal) { meal in
//        NavigationLink {
//            MealDetailView(id: meal.idMeal)
//        } label: {
//            MealListItem(meal: meal)
//        }
//        .swipeActions(edge: .trailing, allowsFullSwipe: true) {
//            Button("Lagre") {
//                savedMealsViewModel.saveMeal(meal)
//            }
//            .tint(.brandSecondary)
//        }
//    }
//    .listStyle(PlainListStyle())
//}
//}
