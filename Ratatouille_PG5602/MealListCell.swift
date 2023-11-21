//
//  MealListCell.swift
//  Ratatouille_PG5602
//
//  Created by Marianne Indrebø on 18/11/2023.
//

import SwiftUI

struct MealListCell: View {
    let meal: MealModel
    
    var body: some View {
        HStack {
            if let imageUrl = meal.strImageSource?.first, let url = URL(string: imageUrl) {
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
                                      fatalError("Unhandled AsyncImage phase")
                                  }
                              }
                          } else {
                              Image(systemName: "fork.knife.circle")
                                  .resizable()
                                  .scaledToFit()
                                  .frame(width: 120)
                                  .cornerRadius(8)
                          }
                          
                          VStack(alignment: .leading, spacing: 5){
                              Text(meal.strMeal)
                                  .font(.title2)
                                  .fontWeight(.medium)
                              Text(meal.strArea)
                                  .font(.subheadline)
                                  .foregroundStyle(Color(.gray))
                }
                .padding(.leading)
            }
        }
    }


#Preview {
    MealListCell(meal: MockData.sampleMeal)
}
