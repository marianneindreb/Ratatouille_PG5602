
import SwiftUI
import Kingfisher

struct AreaFilterView: View {
    @StateObject var viewModel: AreasViewModel
    
    @State private var selectedOption = "Velg land"
    // @State private var optionsArray: [String] = []
    // optionsArray should include areas and flag
    
    var body: some View {
        VStack {
            Text("Hvilket land ønsker du oppskrifter fra?")
            HStack {
                Menu {
                    ForEach(viewModel.areas, id: \.self) { area in
                        Button(action: {
                            print(viewModel.areas)
                            self.selectedOption = area.strArea
                            
                        }) {
                            
                            Text("America")
                                .foregroundColor(.gray)
                            
                            //                                if let url = URL(string: area.flagURL), !area.flagURL.isEmpty {
                            //                                    KFImage(url)
                            //                                        .resizable()
                            //                                        .scaledToFit()
                            //                                        .frame(width: 16, height: 16)
                            
                            
                            //                        }else {
                            //                            Image("placeholderImage")
                            //                                .resizable()
                            //                                .scaledToFit()
                            //                                .frame(width: 16, height: 16)
                            //                        }
                        }
                    }
                
            
        } label: {
            Text("\(selectedOption)")
                .fontWeight(.regular)
            
            
            Spacer()
            Image(systemName: "arrowtriangle.down")
        }
        .padding()
        .padding(.horizontal, 10)
        .frame(width: 300)
        .background(Color.black)
        .foregroundColor(.white)
        .font(.headline)
        .cornerRadius(10)
        .shadow(color: Color.black.opacity(0.3), radius: 5, x: 0, y: 2)
    }
    
    NavigationView {
        List(viewModel.areas, id: \.strArea) { area in
            Text(area.strArea)
        }
        
    }
}
    .onAppear {
        viewModel.fetchAreasFromCoreDataIfNeeded()
    }
}
}

#Preview {
    AreaFilterView(viewModel: AreasViewModel())
}
