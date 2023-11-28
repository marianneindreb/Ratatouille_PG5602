import SwiftUI

struct SplashScreenView: View {
    
    @AppStorage ("coreDataLoaded") var coreDataLoaded = false
    @AppStorage ("hasLaunchedBefore") var hasLaunchedBefore = false
    
    private var areasViewModel = AreasViewModel()
    private var categoriesViewModel = CategoriesViewModel()
    private var ingredientsViewModel = IngredientsViewModel()

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
                RatatouilleTabView()
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
        areasViewModel.fetchAreas()
        categoriesViewModel.fetchCategoriesFromAPIAndSaveToCoreData()
        ingredientsViewModel.fetchIngredients()
        
        categoriesViewModel.onFetchCompleted = {
            self.categoriesViewModel.saveCategoriesToCoreData()
        }
        
        ingredientsViewModel.onFetchCompleted = {
            self.ingredientsViewModel.saveIngredientsToCoreData()
        }
    }
}

#Preview {
    SplashScreenView()
}
