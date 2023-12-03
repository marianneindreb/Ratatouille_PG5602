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
    @State private var rotation = 0.0
    @State private var backgroundColor = Color.black
    
    
    var body: some View {
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
                backgroundColor
                    .ignoresSafeArea()
                
                ZStack {
                    
                    
                    VStack {
                        Image("1")
                            .resizable()
                            .scaledToFit()
                            .opacity(opacity)
                            .rotationEffect(.degrees(rotation))
                            .onAppear() {
                                let rotationAnimation = Animation.linear(duration: 5.0).repeatForever(autoreverses: false)
                                withAnimation(rotationAnimation) {
                                    self.rotation = 360.0
                                }
                                
                                withAnimation(.easeIn(duration: 0.5)) {
                                    self.opacity = 1
                                }
                                
                                DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                                    withAnimation(.easeInOut(duration: 0.5)) {
                                        self.scale = CGSize(width: 50, height: 50)
                                        self.opacity = 0.0
                                        self.backgroundColor = .white
                                    }
                                }
                                DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                                    withAnimation {
                                        self.isActive = true
                                        coreDataLoaded = true
                                    }
                                    if !coreDataLoaded {
                                        fetchDataAndSave()
                                        coreDataLoaded = true
                                    }
                                    hasLaunchedBefore = true
                                }
                            }
                        Image("logo.sign")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 400)
                            .opacity(opacity)
                            .scaleEffect(opacity > 0 ? 1.2 : 1.0)
                            .offset(y: -80)
                    }
                    .scaleEffect(scale)
                    .opacity(opacity)
                    .onAppear() {
                        withAnimation(.easeIn(duration: 1.0)) {
                            self.opacity = 1
                        }
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                            withAnimation {
                                self.isActive = true
                                coreDataLoaded = true
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
