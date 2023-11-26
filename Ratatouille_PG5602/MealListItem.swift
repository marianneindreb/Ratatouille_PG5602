
import SwiftUI

struct MealListItem: View {
    let meal: MealListItemModel
   // var onArchive: () -> Void
    
    var body: some View {
        ZStack(alignment: .topTrailing) {
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
            }
            
            
            if meal.isFavorited == true {
                Image("favorite")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 20, height: 20)
                    .padding([.top, .trailing])
            }
        }
                  .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                      Button("Archive") {
                        //  onArchive()
                      }
                      .tint(.blue)
                  }
              }
          }
                


#Preview {
    MealListItem(meal: MealListItemModel.sampleMealList)
}
