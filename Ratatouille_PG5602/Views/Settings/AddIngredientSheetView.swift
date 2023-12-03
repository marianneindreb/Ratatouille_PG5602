import SwiftUI

struct AddIngredientSheetView: View {
    @Binding var isPresented: Bool
    @ObservedObject var viewModel: IngredientsViewModel
    @State private var newIngredientName: String = ""

    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                TextField("Ny ingrediens", text: $newIngredientName)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                
                HStack {
                    Button("Avbryt") {
                        isPresented = false
                    }
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.gray)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    
                    Button("Lagre") {
                        viewModel.createNewIngredient(named: newIngredientName)
                        isPresented = false
                    }
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.green)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                }
            }
            .padding()
            .navigationTitle("Legg til ny ingrediens")
        }
    }
}


struct AddIngredientSheetView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = IngredientsViewModel()
        AddIngredientSheetView(isPresented: .constant(true), viewModel: viewModel)
    }
}
