
import SwiftUI

struct MealListItem: View {
    let meal: MealListItemModel
    // var onArchive: () -> Void
    @State private var isDetailViewActive = false
    @StateObject var saveMealsViewModel = SavedMealsViewModel()
    @State private var isFavorited = false
    
    init (meal: MealListItemModel){
        self.meal = meal
    }
    
    var body: some View {
        ZStack {
            HStack {
                if let imageUrl = meal.strMealThumb, let url = URL(string: imageUrl) {
                    AsyncImage(url: url) { phase in
                        switch phase {
                        case .empty:
                            ProgressView()
                        case .success(let image):
                            image
                                .resizable()
                                .scaledToFit()
                                .frame(width: 120)
                                .cornerRadius(8)
                        case .failure:
                            Image("ratatouille")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 120)
                                .cornerRadius(8)
                        @unknown default:
                            fatalError("Unhandled AsyncImage")
                        }
                    }
                } else {
                    Image("ratatouille")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 120)
                        .cornerRadius(8)
                }
                HStack {
                    Text(meal.strMeal )
                        .font(.title2)
                        .fontWeight(.medium)
                }
                .padding(.leading)
                Spacer()
                if isFavorited {
                    Image("favorite")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 25)
                        .onTapGesture {
                            isFavorited.toggle()
                        }
                }
            }
        }
        .swipeActions(edge: .leading, allowsFullSwipe: true) {
            Button {
                isFavorited = true
            } label: {
                Image("favorite")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 25)
                    .shadow(radius: 10)
            }
            .tint(.white)
        }
        
    }
}



#Preview {
    MealListItem(meal: MealListItemModel.sampleMealList)
}
