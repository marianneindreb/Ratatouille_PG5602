//
//  Ratatouille_PG5602App.swift
//  Ratatouille_PG5602
//
//  Created by Marianne Indrebø on 16/11/2023.
//

import SwiftUI

@main
struct Ratatouille_PG5602App: App {

    init() {
        printDocumentsDirectory()
    }

    var body: some Scene {
        WindowGroup {
            SplashScreenView()
        }
    }

    func printDocumentsDirectory() {
        if let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).last {
            print("Documents Directory: \(url)")
        }
    }
    }

