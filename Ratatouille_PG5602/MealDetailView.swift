import SwiftUI
import Kingfisher

// Kanksje legge inn Instruksjoner som en knapp og Ingredienser som en knapp. Så kan man velge

struct MealDetailView: View {
    let meal: MealModel
    @State private var selectedTab = "Instructions"
    
    
    var body: some View {
        VStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 10) {
                    if let imageUrl = meal.strMealThumb, let url = URL(string: imageUrl) {
                        KFImage(url)
                            .resizable()
                            .scaledToFit()
                            .frame(height: 400)
                    }
                    
                    Text(meal.strMeal)
                        .font(.title)
                        .fontWeight(.bold)
                    
                    Picker("Options", selection: $selectedTab) {
                        Text("Instruksjoner").tag("Instructions")
                        Text("Ingredienser").tag("Ingredients")
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    //.padding()
                    
                    if selectedTab == "Instructions" {
                        Text("Slik gjør du:")
                            .font(.headline)
                        Text(meal.strInstructions)
                            .font(.body)
                    } else {
                        Text("Dette trenger du:")
                            .font(.headline)
                        
                        // Formatere riktig fra MealModel. En liste av ingredienser og tilhørende measure
                        // Dette er bare placeholder for å teste
                        VStack {
                            HStack {
                                Text(meal.strIngredient1 ?? "Egg")
                                Spacer()
                                Text(meal.strMeasure1 ?? "1")
                            }
                            HStack {
                                Text(meal.strIngredient1 ?? "Mel")
                                Spacer()
                                Text(meal.strMeasure1 ?? "250g")
                            }
                            HStack {
                                Text(meal.strIngredient1 ?? "Melk")
                                Spacer()
                                Text(meal.strMeasure1 ?? "0.5l")
                            }
                            HStack {
                                Text(meal.strIngredient1 ?? "Hvitløk")
                                Spacer()
                                Text(meal.strMeasure1 ?? "2 fedd")
                            }
                            
                            
                        }
                        .padding(20)
                    }
                }
                .padding()
            }
                    
                   
                    Button {
                        // code
                    } label: {
                        Text("Lagre oppskrift")
                            .padding(20)
                            .frame(maxWidth: .infinity)
                            .background(Color.brandPrimary)
                            .foregroundColor(.black)
                            .fontWeight(.bold)
                            .textCase(.uppercase)
                            .cornerRadius(15)
                            .shadow(color: Color.black.opacity(0.3), radius: 5, x: 0, y: 2)
                    }
                    .padding(.horizontal)
                    .padding(.bottom, 20)
                    
                }
                .ignoresSafeArea(.container, edges: .top)
                .navigationBarTitle(meal.strMeal, displayMode: .inline)
            }
               
        }
 


#Preview {
    MealDetailView(meal: MealModel.sampleMeal)
}
