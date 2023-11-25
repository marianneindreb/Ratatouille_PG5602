import SwiftUI

struct SplashScreenView: View {
    var body: some View {
        ZStack {
            Image("bg")
                .resizable()
                .ignoresSafeArea()
            Image("logo")
                .resizable()
                
        }
    }
}

#Preview {
    SplashScreenView()
}
