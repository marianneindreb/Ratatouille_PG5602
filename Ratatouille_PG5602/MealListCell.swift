//
//  MealListCell.swift
//  Ratatouille_PG5602
//
//  Created by Marianne Indrebø on 18/11/2023.
//

import SwiftUI

struct MealListCell: View {
    let meal: Meal
    
    var body: some View {
        HStack {
            Image(meal.strImageSource)
                .resizable()
                .scaledToFit()
                .frame(width: 120)
                .cornerRadius(8)
            
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
