import Kingfisher
import SwiftUI

struct SearchFilterView: View {
    @State var searchText = ""
    @StateObject var viewModel: SearchViewModel
    @StateObject var savedMealsViewModel = SavedMealsViewModel()

    var body: some View {
        ZStack(alignment: .trailing) {
            List(viewModel.meals, id: \.idMeal) { meal in
                NavigationLink {
                    MealDetailView(id: meal.idMeal)
                } label: {
                    MealListItem(meal: MealListItemModel(
                        strMeal: meal.strMeal,
                        strMealThumb: meal.strMealThumb,
                        idMeal: meal.idMeal)
                    )
                }
                .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                    Button("Lagre") {
                        MealDetailViewModel().fetchAndSaveMeal(id: meal.idMeal)
                    }
                    .tint(.brandSecondary)
                }
            }
            .listStyle(PlainListStyle())
        }
        .searchable(text: $searchText, prompt: "Pie")
        .autocorrectionDisabled(true)
        .onSubmit(of: .search) {
            if (searchText != ""){
                viewModel.fetchSearchResult(searchText)
            }
        }
    }
}

#Preview {
    SearchFilterView(viewModel: SearchViewModel())
}
