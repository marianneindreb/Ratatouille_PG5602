import SwiftUI

struct OnboardingView: View {
    @State private var pageIndex = 0
    @AppStorage("hasLaunchedBefore") var hasLaunchedBefore: Bool = false
    
    private var areasViewModel = AreasViewModel()
       private var categoriesViewModel = CategoriesViewModel()
       private var ingredientsViewModel = IngredientsViewModel()
    
    private let pages: [Onboarding] = Onboarding.onboardingPages
    private let progressAppearance = UIPageControl.appearance()
    
    func incrementPage() {
        pageIndex += 1
    }
    
    func fetchDataAndSave() {
            areasViewModel.fetchAreas()
//            categoriesViewModel.fetchCategories()
//            ingredientsViewModel.fetchIngredients()

            areasViewModel.onFetchCompleted = {
                self.areasViewModel.saveAreasToCoreData()
            }
            
//            categoriesViewModel.onFetchCompleted = {
//                self.categoriesViewModel.saveCategoriesToCoreData()
//            }
//
//            ingredientsViewModel.onFetchCompleted = {
//                self.ingredientsViewModel.saveIngredientsToCoreData()
//            }
        }
    
    var body: some View {
        NavigationView {
            Color.brandBg
                .ignoresSafeArea()
                .overlay(
                    TabView(selection: $pageIndex) {
                        ForEach(pages) { page in
                            VStack {
                                Spacer()
                                OnboardingPageView(onboarding: page)
                                Spacer()
                                
                                if page == pages.last {
                                    NavigationLink(destination: RatatouilleTabView().navigationBarBackButtonHidden(true)) {
                                        Text("La oss lage mat!")
                                            .onTapGesture {
                                                hasLaunchedBefore = true
                                                fetchDataAndSave()
                                            }
                                            .padding(20)
                                            .background(Color.brandPrimary)
                                            .foregroundColor(.black)
                                            .fontWeight(.bold)
                                            .textCase(.uppercase)
                                            .cornerRadius(15)
                                            .shadow(color: Color.black.opacity(0.3), radius: 5, x: 0, y: 2)
                                    }
                                    
                                } else {
                                    HStack {
                                        Button {
                                            incrementPage()
                                        } label: {
                                            Text("Neste")
                                                .padding()
                                                .background(Color.brandPrimary)
                                                .foregroundColor(.black)
                                                .fontWeight(.bold)
                                                .textCase(.uppercase)
                                                .cornerRadius(10)
                                                .shadow(color: Color.black.opacity(0.3), radius: 5, x: 0, y: 2)
                                        }
                                    }
                                    .padding()
                                }
                                
                                Spacer()
                            }
                            .tag(page.indexTag)
                        }
                    }
                        .animation(.easeInOut, value: pageIndex)
                        .tabViewStyle(.page)
                        .indexViewStyle(.page(backgroundDisplayMode: .interactive))
                        .onAppear {
                            progressAppearance.currentPageIndicatorTintColor = .brandSecondary
                            progressAppearance.pageIndicatorTintColor = .white
                        }
                )
        }
    }
}

#Preview {
    OnboardingView()
}

