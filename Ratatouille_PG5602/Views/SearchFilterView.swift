import SwiftUI
import Kingfisher

struct SearchFilterView: View {
    @Binding var viewModel: SearchViewModel
    @State var text = ""
    
    var body: some View {
        ZStack(alignment: .trailing) {
            TextField("Søk..", text: $text)
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
        
        NavigationView {
            List(viewModel.meals, id: \.idMeal) { meal in
                MealListItem(meal: meal)
            }
        }
    
        .navigationTitle("Velg kategori")
    
}
}

        



#Preview {
    SearchFilterView(viewModel: .constant(SearchViewModel()))
}
