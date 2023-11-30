import SwiftUI




struct SettingsView: View {

    @AppStorage("isdarkMode") var isDarkMode: Bool = false
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Rediger")) {
                    Text("Redigere landområder")
                    Text("Redigere Kategorier")
                    Text("Redigere ingredienser")
                }
                Section() {
                    HStack {
                        Toggle("Aktivere mørkmodus", isOn: $isDarkMode)
                            .toggleStyle(SwitchToggleStyle(tint: .brandPrimary))
                            .preferredColorScheme(isDarkMode ? .dark : .light)
                    }
                }
                Section() {
                    HStack {
                        Text("Administrer arkiv")
                        Spacer()
                        Image(systemName: "archivebox")
                    }
                }
            }
            .navigationTitle("Innstillinger")
        }
    }
}


#Preview {
    SettingsView()
}
