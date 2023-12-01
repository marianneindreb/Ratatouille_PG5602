
import SwiftUI

struct MealListItem: View {
    let meal: MealListItemModel
    // var onArchive: () -> Void
    @State private var isDetailViewActive = false
    @StateObject var saveMealsViewModel = SavedMealsViewModel()
    @State private var isFavorited = false
    
    var mealModel: MealModel {
        return convertToMealModel(meal)
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
    
    
    private func convertToMealModel( _ mealListItem: MealListItemModel) -> MealModel {
        return MealModel(
            idMeal: self.meal.idMeal, strMeal: self.meal.strMeal, strDrinkAlternate: "", strCategory: "", strArea: "", strInstructions: "", strMealThumb: self.meal.strMealThumb, strTags: "", strYoutube: "", strIngredient1: "", strIngredient2: "", strIngredient3: "", strIngredient4: "", strIngredient5: "", strIngredient6: "", strIngredient7: "", strIngredient8: "", strIngredient9: "", strIngredient10: "", strIngredient11: "", strIngredient12: "", strIngredient13: "", strIngredient14: "", strIngredient15: "", strIngredient16: "", strIngredient17: "", strIngredient18: "", strIngredient19: "", strIngredient20: "", strMeasure1: "", strMeasure2: "", strMeasure3: "", strMeasure4: "", strMeasure5: "", strMeasure6: "", strMeasure7: "", strMeasure8: "", strMeasure9: "", strMeasure10: "", strMeasure11: "", strMeasure12: "", strMeasure13: "", strMeasure14: "", strMeasure15: "", strMeasure16: "", strMeasure17: "", strMeasure18: "", strMeasure19: "", strMeasure20: "", strSource: "", strImageSource: "", strCreativeCommonsConfirmed: "", dateModified: ""
        )
    }
}



#Preview {
    MealListItem(meal: MealListItemModel.sampleMealList)
}
