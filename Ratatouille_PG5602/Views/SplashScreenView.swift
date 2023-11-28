import SwiftUI

struct SplashScreenView: View {
    
    @State private var scale = CGSize(width: 0.8, height: 0.8)
    @State private var isActive = false
    @State private var opacity = 0.0
    @State private var ledLogoOpacity = 0.0
    
    var body: some View {
        
        if isActive {
            OnboardingView()
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
                            }
                        }
                    }
            }
        }
    }
}

#Preview {
    SplashScreenView()
}
