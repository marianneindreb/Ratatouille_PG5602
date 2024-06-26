
import SwiftUI
import Kingfisher

struct AreaFilterView: View {
    @StateObject var viewModel: AreasViewModel
    @State private var selectedOption = "Velg land"

    
    var body: some View {
        VStack {
            HStack {
                Menu {
                    ForEach(viewModel.areas, id: \.strArea) { area in
                        Button(action: {
                            self.selectedOption = area.strArea
                            viewModel.fetchMealsFromAPI(forArea: selectedOption)
                        }) {
                            Text(area.strArea)
                                .foregroundColor(.gray)
                        }
                    }
                    
                    
                } label: {
                    Text("\(selectedOption)")
                        .fontWeight(.regular)
                    
                    Spacer()
                    Image(systemName: "arrowtriangle.down")
                        .foregroundColor(.gray)
                }
                .padding()
                .padding(.horizontal, 10)
                .frame(width: 370)
                .background(Color.white)
                .foregroundColor(.black)
                .font(.headline)
                .cornerRadius(10)
                .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 2)
                .padding()
            }
            
            List(viewModel.meals, id: \.idMeal) { meal in
                NavigationLink {
                    MealDetailView(id: meal.idMeal)
                } label: {
                    MealListItem(meal: meal)
                }
                .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                    Button("Lagre") {
                        MealDetailViewModel().fetchAndSaveMeal(id: meal.idMeal)
                    }
                    .tint(.brandSecondary)
                }
            }
            .listStyle(PlainListStyle())
            .navigationTitle("Velg landområde")
        }
    }
}
#Preview {
    AreaFilterView(viewModel: AreasViewModel())
}

