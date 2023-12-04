import SwiftUI


struct SettingsView: View {
    
    @AppStorage("isdarkMode") var isDarkMode: Bool = false
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Rediger")) {
                    NavigationLink(destination: EditAreasSettingsView()) {
                        HStack {
                            Image(systemName: "globe")
                            Text("Rediger landområder")
                            Spacer()
                            
                        }
                    }
                    NavigationLink(destination: EditCategoriesSettingsView()) {
                        HStack {
                            Image(systemName: "folder.badge.plus")
                            Text("Rediger kategorier")
                            Spacer()
                            
                        }
                    }
                    NavigationLink(destination: EditIngredientsSettingsView()) {
                        HStack {
                            Image(systemName: "carrot")
                            Text("Rediger ingredienser")
                            Spacer()
                            
                        }
                    }
                }
                Section() {
                    HStack {
                        Toggle("Aktivere mørkmodus", isOn: $isDarkMode)
                            .toggleStyle(SwitchToggleStyle(tint: .brandPrimary))
                            .preferredColorScheme(isDarkMode ? .dark : .light)
                    }
                }
                Section() {
                    NavigationLink(destination: ArchiveView()) {
                        HStack {
                            Image(systemName: "archivebox")
                            Text("Administrer arkiv")
                            Spacer()
                            
                        }
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
