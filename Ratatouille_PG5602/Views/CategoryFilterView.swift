import SwiftUI
import Kingfisher

struct CategoryFilterView: View {
 @Binding var viewModel: CategoriesViewModel
 @State private var selectedOption = "Velg kategori"
    
        
        var body: some View {
            VStack {
                HStack {
                    Menu {
                        ForEach(viewModel.categories, id: \.strCategory) { category in
                            Button(action: {
                                self.selectedOption = category.strCategory
                                viewModel.fetchMealsFromAPI(forCategory: selectedOption)
                            }) {
                                Text(category.strCategory)
                                    .foregroundColor(.gray)
                            }
                        }
            } label: {
                Text("\(selectedOption)")
                    .fontWeight(.regular)
                
                
                Spacer()
                Image(systemName: "arrowtriangle.down")
            }
            .padding()
            .padding(.horizontal, 10)
            .frame(width: 370)
            .background(Color.white)
            .foregroundColor(.black)
            .font(.headline)
            .cornerRadius(10)
            .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 2)
                } .padding()
              
        
        NavigationView {
            List(viewModel.meals, id: \.idMeal) { meal in
                MealListItem(meal: meal)
            }
        }
    }
        .navigationTitle("Velg kategori")
    }
}

#Preview {
    CategoryFilterView(viewModel: .constant(CategoriesViewModel()))
}
