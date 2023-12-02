import SwiftUI


struct ArchiveView: View {
    
    @ObservedObject var archivedMealsVM = ArchiveViewModel()
    
    @State var hasArchivedAreas: Bool = false
    @State var hasArchivedCategories: Bool = false
    @State var hasArchivedIngredients: Bool = false
    @State var hasArchivedMeals: Bool = false
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Landområder")) {
                    if hasArchivedAreas == true {
                        // vis arkiverte landområder
                    } else {
                        Text("Ingen arkiverte landområder")
                    }
                }
                Section(header: Text("Kategorier")) {
                    if hasArchivedCategories == true {
                        // vis arkiverte kategorier
                    } else {
                        Text("Ingen arkiverte kategorier")
                    }
                }
                Section(header: Text("Ingredienser")) {
                    if hasArchivedIngredients == true {
                        // vis arkriverte ingredienser
                    } else {
                        Text("Ingen arkiverte ingredienser")
                    }
                }
                Section(header: Text("Oppskrifter")) {
                   if archivedMealsVM.archivedMeals.isEmpty {
                        Text("Ingen arkiverte oppskrifter")
                        // Vise liste over arkiverte oppskrifter
                    } else {
                        //List med strMeal Tittel bare. Kan swipe fra venstre for å slette eller legge til igjen
                    /*    List(archivedMealsVM.archivedMeals, id: \.id) { meal in
                            Text("meal")
                        } */
                    }
                }
                
               
            }
            .navigationTitle("Arkiv")
        }
        .onAppear{
            archivedMealsVM.getArchivedMeals()
        }
    }
}


#Preview {
    ArchiveView()
}
