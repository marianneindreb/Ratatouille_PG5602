////
////  RecipeListView.swift
////  Ratatouille_PG5602
////
////  Created by Marianne Indrebø on 16/11/2023.
////
//
//import SwiftUI
//
//struct RecipeListView: View {
//    
//    @StateObject var viewModel = MealListViewModel()
//    
//    var body: some View {
//        VStack(spacing: 0) {
//            Image("logo")
//                .resizable()
//                .scaledToFit()
//                .frame(width: 200, height: 120)
//                .shadow(radius: 10)
//                .padding(.top, -10)
//            NavigationView {
//                List(viewModel.meals, id: \.idMeal) { meal in
//                    MealListCell(meal: meal)
//                    
//                }
//                .navigationTitle("Mine oppskrifter")
//            }
//            .onAppear {
//                viewModel.getMeals()
//            }
//            .alert(item: $viewModel.alertItem) { alertItem in    
//                Alert(title: alertItem.title, message: alertItem.message, dismissButton: alertItem.dismissButton)
//            }
//            Spacer(minLength: 0)
//        }
//    }
//}
//
//#Preview {
//    RecipeListView()
//}
