import SwiftUI

struct AddAreaModal: View {
    @Binding var isPresented: Bool
    @ObservedObject var viewModel: AreasViewModel
    @State private var newAreaName: String = ""

    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                Text("Legg til nytt landområde")
                    .font(.title3)
                TextField("Nytt landområde", text: $newAreaName)
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
                        viewModel.createNewArea(named: newAreaName)
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
