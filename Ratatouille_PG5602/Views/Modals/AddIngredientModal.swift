import SwiftUI

struct AddIngredientModal: View {
    @Binding var isPresented: Bool
    @ObservedObject var viewModel: IngredientsViewModel
    @State private var newIngredientName: String = ""

    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                Text("Legg til ny ingrediens")
                    .font(.title3)
                TextField("Ny ingrediens", text: $newIngredientName)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                
                HStack {
                    Spacer()
                    Button("Avbryt") {
                        isPresented = false
                    }
                    .padding()
                    .frame(width: 120)
                    .background(Color.gray)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    
                    Spacer()
                    
                    Button("Lagre") {
                        viewModel.createNewIngredient(named: newIngredientName)
                        isPresented = false
                    }
                    .padding()
                    .frame(width: 120)
                    .background(Color.green)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    Spacer()
                }
            }
            .padding()
        }
    }
}


struct AddIngredientSheetView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = IngredientsViewModel()
        AddIngredientModal(isPresented: .constant(true), viewModel: viewModel)
    }
}
