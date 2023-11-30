import SwiftUI

struct OnboardingView: View {
    @State private var pageIndex = 0
    
    private let pages: [Onboarding] = Onboarding.onboardingPages
    private let progressAppearance = UIPageControl.appearance()
    
    func incrementPage() {
        pageIndex += 1
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
                                    NavigationLink(destination: RatatouilleTabView(areasViewModel: .constant(AreasViewModel()), categoriesViewModel: .constant(CategoriesViewModel()), ingredientsViewModel: .constant(IngredientsViewModel()),
                                        mealViewModel: .constant(MealViewModel())).navigationBarBackButtonHidden(true)) {
                                        Text("La oss lage mat!")
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

