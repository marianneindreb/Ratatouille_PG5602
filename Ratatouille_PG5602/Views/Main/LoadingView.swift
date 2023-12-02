//
//  LoadingView.swift
//  Ratatouille_PG5602
//
//  Created by Marianne Indrebø on 26/11/2023.
//

import SwiftUI

struct ActivityIndicator: UIViewRepresentable {
    func makeUIView(context: Context) -> UIActivityIndicatorView {
        let activityIndicatorView = UIActivityIndicatorView(style: .large)
        activityIndicatorView.color = UIColor(named: "brandPrimary")
        activityIndicatorView.startAnimating()
        return activityIndicatorView
    }
    func updateUIView(_ uiView: UIActivityIndicatorView, context: Context) {
        //
    }
}

struct LoadingView: View {
    var body: some View {
        ZStack {
            Color(.systemBackground)
                .edgesIgnoringSafeArea(.all)
            ActivityIndicator()
        }
    }
}
