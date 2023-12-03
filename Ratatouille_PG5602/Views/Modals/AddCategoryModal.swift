import SwiftUI

struct AddCategoryModal: View {
    @Binding var isPresented: Bool
    @ObservedObject var viewModel: CategoriesViewModel
    @State private var newCategoryName: String = ""

    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                Text("Legg til ny kategori")
                    .font(.title3)
                TextField("Ny kategori", text: $newCategoryName)
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
                        viewModel.createNewCategory(named: newCategoryName)
                        isPresented = false
                    }
                    .padding()
                    .frame(width: 120)
                    .background(Color.brandPrimary)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    Spacer()
                }
            }
            .padding()
        }
    }
}
