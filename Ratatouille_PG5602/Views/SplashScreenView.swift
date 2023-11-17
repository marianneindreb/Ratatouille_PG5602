//
//  SplashScreenView.swift
//  Ratatouille_PG5602
//
//  Created by Marianne Indrebø on 16/11/2023.
//

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
