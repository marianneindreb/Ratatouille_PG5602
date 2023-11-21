//
//  OnboardingPageView.swift
//  Ratatouille_PG5602
//
//  Created by Marianne Indrebø on 17/11/2023.
//

import SwiftUI

struct OnboardingPageView: View {
    var onboarding: Onboarding
    
    var body: some View {
        
        VStack(spacing: 20) {
            Image("\(onboarding.imageUrl)")
                .resizable()
                .scaledToFit()
                .frame(width: 300)
                .padding()
            
            Text(onboarding.title)
                .font(.title)
                .fontWeight(.bold)
                
            Text(onboarding.description)
                .font(.subheadline)
                .frame(width: 300)
                .multilineTextAlignment(.center)
        }
    }
}

#Preview {
    OnboardingPageView(onboarding: Onboarding.sampleOnboarding)
}
