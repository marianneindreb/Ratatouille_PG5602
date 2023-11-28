
import SwiftUI
import Kingfisher

struct AreaFilterView: View {
    @Binding var viewModel: AreasViewModel
    
    @State private var selectedOption = "Velg land"
 //   @State private var meals: [MealModel] = []
    // optionsArray should include areas and flag
    
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
                            
                            //                                if let url = URL(string: area.flagURL), !area.flagURL.isEmpty {
                            //                                    KFImage(url)
                            //                                        .resizable()
                            //                                        .scaledToFit()
                            //                                        .frame(width: 16, height: 16)
                            
                            
                            //                        }else {
                            //                            Image("placeholderImage")
                            //                                .resizable()
                            //                                .scaledToFit()
                            //                                .frame(width: 16, height: 16)
                            //                        }
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
    .navigationTitle("Velg landområde")
}
}

#Preview {
    AreaFilterView(viewModel: .constant(AreasViewModel()))
}

