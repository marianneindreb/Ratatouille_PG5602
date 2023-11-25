
import SwiftUI

struct MealListItem: View {
    let meal: MealModel
    var onArchive: () -> Void
    
    var body: some View {
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
                        Image(systemName: "fork.knife.circle")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 120)
                            .cornerRadius(8)
                    @unknown default:
                        fatalError("Unhandled AsyncImage")
                    }
                }
            } else {
                Image(systemName: "fork.knife.circle")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 120)
                    .cornerRadius(8)
            }
            
            VStack(alignment: .leading, spacing: 5) {
                Text(meal.strMeal )
                              .font(.title2)
                              .fontWeight(.medium)
                Text(meal.strArea )
                              .font(.subheadline)
                              .foregroundStyle(Color(.gray))
                      }
                      .padding(.leading)
                  }
                  .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                      Button("Archive") {
                          onArchive()
                      }
                      .tint(.blue)
                  }
              }
          }
                


#Preview {
    MealListItem(meal: MealModel.sampleMeal, onArchive: {})
}
