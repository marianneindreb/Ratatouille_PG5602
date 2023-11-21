import SwiftUI

struct SearchComponent: View {
    @State private var textFieldText: String = ""
    @State private var isButton1Clicked = false
    @State private var isButton2Clicked = false
    @State private var isButton3Clicked = false
    @State private var isButton4Clicked = false

    enum SearchFilter {
        case area
        case category
        case ingredient
        case text
    }

    @State private var selectedFilter: SearchFilter?

    var body: some View {
        VStack {
            HStack {
                Button {
                    toggleFilter(.area)
                } label: {
                    Text("Land")
                        .buttonStyle(isButton1Clicked)
                }
                Button {
                    toggleFilter(.category)
                } label: {
                    Text("Kategori")
                        .buttonStyle(isButton2Clicked)
                }
                Button {
                    toggleFilter(.ingredient)
                } label: {
                    Text("Ingrediens")
                        .buttonStyle(isButton3Clicked)
                }
                Button {
                    toggleFilter(.text)
                } label: {
                    Text("Navn")
                        .buttonStyle(isButton4Clicked)
                }
            }
            .padding()

            HStack {
                TextField("Søk..", text: $textFieldText)
                    .padding()
                    .background(Color(.brandBg))
                    .cornerRadius(10)
                    .padding(.horizontal)
                    .shadow(color: Color.black.opacity(0.3), radius: 5, x: 0, y: 2)
                
                Button(action: {
                    performSearch()
                }) {
                    Text("Søk")
                        .padding()
                        .background(Color.brandPrimary)
                        .foregroundColor(.white)
                        .font(.headline)
                        .cornerRadius(10)
                        .shadow(color: Color.black.opacity(0.3), radius: 5, x: 0, y: 2)
                }
            }.padding()
            
        }
    }

    private func toggleFilter(_ filter: SearchFilter) {
        selectedFilter = (selectedFilter == filter) ? nil : filter

        // Reset other filters
        isButton1Clicked = (filter == .area)
        isButton2Clicked = (filter == .category)
        isButton3Clicked = (filter == .ingredient)
        isButton4Clicked = (filter == .text)
    }

    private func performSearch() {
        guard let selectedFilter = selectedFilter else {
            // No filter selected, perform a default search
            print("Performing default search with text: \(textFieldText)")
            return
        }

        switch selectedFilter {
        case .area:
            print("Performing search by area with text: \(textFieldText)")
            // Implement area-specific search logic here

        case .category:
            print("Performing search by category with text: \(textFieldText)")
            // Implement category-specific search logic here

        case .ingredient:
            print("Performing search by ingredient with text: \(textFieldText)")
            // Implement ingredient-specific search logic here

        case .text:
            print("Performing search by text with text: \(textFieldText)")
            // Implement text-specific search logic here
        }
    }
}

extension Text {
    func buttonStyle(_ isClicked: Bool) -> some View {
        self
            .font(.caption)
            .padding()
            .background(isClicked ? Color.brandPrimary : Color.brandSecondary)
            .foregroundColor(.white)
            .fontWeight(.bold)
            .textCase(.uppercase)
            .cornerRadius(10)
            .shadow(color: Color.black.opacity(0.3), radius: 5, x: 0, y: 2)
    }
}

struct SearchComponent_Previews: PreviewProvider {
    static var previews: some View {
        SearchComponent()
    }
}
