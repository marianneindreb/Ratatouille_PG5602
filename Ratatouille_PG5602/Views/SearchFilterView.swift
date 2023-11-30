import SwiftUI
import Kingfisher

struct SearchFilterView: View {
    @State var searchText = ""
    @State private var meals: [MealListItemModel] = []
    @StateObject var viewModel: MealViewModel
    
    //    var filteredMeals: [MealModel] {
    //        guard !text.isEmpty else {return meal}
    //        return meal.filter { $0.strMeal.localizedCaseInsensitiveContains(text) }
    //    }
    
    var body: some View {
        ZStack(alignment: .trailing) {
            TextField("Søk..", text: $searchText)
                .padding(.horizontal, 16)
                .padding(.vertical, 10)
                .background(Color.white)
                .foregroundColor(.black)
                .font(.headline)
                .cornerRadius(10)
                .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 2)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.white, lineWidth: 1)
                    
                )
            Image(systemName: "magnifyingglass")
                .foregroundColor(.gray)
                .padding(.trailing, 15)
        }
        .frame(width: 370)
        .padding()
//        .onChange(of: searchText ) { textSearch in
//            fetchMeals()
//        }
        
//        List(meals, id: \.idMeal) { meal in
//            MealListItem(meal: meal)
//        }
        List(viewModel.meals) { meal in
            Text(meal.strMeal)
        }
        .listStyle(PlainListStyle())

        .task {
            do {
                try await viewModel.fetchMeals()
            } catch {
                print(error)
            }
        }
    }
    
    
}


#Preview {
    SearchFilterView(viewModel: MealViewModel())
}
