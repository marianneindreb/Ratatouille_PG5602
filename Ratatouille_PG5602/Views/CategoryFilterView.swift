import SwiftUI
import Kingfisher

struct CategoryFilterView: View {
 @StateObject var viewModel = CategoriesViewModel()
 @State var options: [CategoryModel] = []
 @State private var selectedOption = "Velg kategori"
    
        
        var body: some View {
            VStack {
                Text("Hvilken kategori ønsker du oppskrifter fra?")
                HStack {
                    Menu {
                        ForEach(options, id: \.idCategory) {
                            //Get from CoreData not from api
                            
                            category in
                            Button(action: {
                                self.selectedOption = category.strCategory
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
            .frame(width: 300)
            .background(Color.black)
            .foregroundColor(.white)
            .font(.headline)
            .cornerRadius(10)
            .shadow(color: Color.black.opacity(0.3), radius: 5, x: 0, y: 2)
        }
              
        
        NavigationView {
            List(viewModel.meals, id: \.idMeal) { meal in
                MealListItem(meal: meal)
            }
        }
    }
        .onAppear {
            options = viewModel.getCategories()
        }
        .navigationTitle("Oppskrifter")
    }
}

#Preview {
    CategoryFilterView(viewModel: CategoriesViewModel())
}
