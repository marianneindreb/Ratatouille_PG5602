////
////  categoryFiilterView.swift
////  Ratatouille_PG5602
////
////  Created by Marianne Indrebø on 21/11/2023.
////
//
//import SwiftUI
//
//struct AreaFilterView: View {
//    @StateObject var viewModel: AreaViewModel
//    
////    @StateObject var coreDataManager = CoreDataManager()
//    
//    @State private var selectedOption = "Land"
//    @State private var optionsArray: [String] = []
//    
////    init(viewModel: AreaViewModel) {
////        self._viewModel = StateObject(wrappedValue: viewModel)
////    }
//    
//    var body: some View {
//        VStack {
//            Text("Hvilket land ønsker du oppskrifter fra?")
//            HStack {
//                Menu {
//                    ForEach(optionsArray, id: \.self) { option in
//                        Button(action: {
//                            self.selectedOption = option
//                            viewModel.getArea(area: option)
//                        }) {
//                            Text(option)
//                                .foregroundColor(.gray)
//                        }
//                    }
//                } label: {
//                    Text("\(selectedOption)")
//                        .fontWeight(.regular)
//                    Spacer()
//                    Image(systemName: "arrowtriangle.down")
//                }
//                .padding()
//                .padding(.horizontal, 10)
//                .frame(width: 300)
//                .background(Color.black)
//                .foregroundColor(.white)
//                .font(.headline)
//                .cornerRadius(10)
//                .shadow(color: Color.black.opacity(0.3), radius: 5, x: 0, y: 2)
//            }
//            
//            NavigationView {
//                List(viewModel.area, id: \.idMeal) { area in
//                    Text(area.strMeal)
//                }
//                .onAppear {
//                    viewModel.getArea(area: selectedOption)
//                }
//                .alert(item: $viewModel.alertItem) { alertItem in
//                    Alert(title: alertItem.title, message: alertItem.message, dismissButton: alertItem.dismissButton)
//                }
//            }
//        }
//    }
//    
//  
//#Preview {
//    AreaFilterView()
//}
