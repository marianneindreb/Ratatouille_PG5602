import SwiftUI

struct SplashScreenView: View {
    
    @AppStorage ("coreDataLoaded") var coreDataLoaded = false
    @AppStorage ("hasLaunchedBefore") var hasLaunchedBefore = false
    
    @ObservedObject var areasViewModel = AreasViewModel()
    @StateObject var categoriesViewModel = CategoriesViewModel()
    @StateObject var ingredientsViewModel = IngredientsViewModel()

    @State private var isActive = false
    @State private var scale = CGSize(width: 0.8, height: 0.8)
    @State private var opacity = 0.0
    @State private var ledLogoOpacity = 0.0
    
    var body: some View {
        
        //        if isActive {
        //            if hasLaunchedBefore {
        //                RatatouilleTabView()
        //            } else {
        //                // fetch data from api
        //                OnboardingView()
        //                    .onAppear {
        //                        fetchDataAndSave()
        //                        hasLaunchedBefore = true
        //                    }
        //            }
        if isActive {
            if hasLaunchedBefore {
                RatatouilleTabView(
                    areasViewModel: .constant(
                        AreasViewModel()
                    ),
                    categoriesViewModel: .constant(CategoriesViewModel()),
                    ingredientsViewModel: .constant(IngredientsViewModel()),
                    searchViewModel: .constant(SearchViewModel())
                )
            } else {
                OnboardingView()
            }
        } else {
                ZStack {
                    Color(.black).ignoresSafeArea()
                    
                    ZStack {
                        Image("bg")
                            .resizable()
                            .ignoresSafeArea()
                        
                        ZStack {
                            Image("logo")
                                .resizable()
                                .scaledToFit()
                                .opacity(opacity)
                            
                            Image("ledLogo")
                                .resizable()
                                .scaledToFit()
                                .opacity(ledLogoOpacity)
                        }
                        .scaleEffect(scale)
                        
                    }.opacity(opacity)
                        .onAppear() {
                            withAnimation(.easeIn(duration: 1.0)) {
                                self.opacity = 1
                            }
                            
                            for i in 1..<9{
                                DispatchQueue.main.asyncAfter(deadline: .now() + 1.8 + Double(i) * 0.2) {
                                    if ledLogoOpacity == 0.0 {
                                        ledLogoOpacity = 1.0
                                    } else {
                                        ledLogoOpacity = 0.0
                                    }
                                }
                            }
                            
                            DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                                withAnimation {
                                    self.isActive = true
                                   // coreDataLoaded = true
                                }
                                if !coreDataLoaded {
                                    fetchDataAndSave()
                                    coreDataLoaded = true
                                }
                                hasLaunchedBefore = true
                            }
                        }
                }
            }
        }
    
    
    
    func fetchDataAndSave() {
        areasViewModel.fetchAreasFromAPIAndSaveToCoreData()
        categoriesViewModel.fetchCategoriesFromAPIAndSaveToCoreData()
        ingredientsViewModel.fetchIngredientsFromAPIAndSaveToCoreData()
    }
}

#Preview {
    SplashScreenView()
}
