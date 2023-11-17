//
//  OnboardingModel.swift
//  Ratatouille_PG5602
//
//  Created by Marianne Indrebø on 17/11/2023.
//

import Foundation

struct Onboarding: Equatable, Identifiable {
    let id = UUID()
    var title: String
    var description: String
    var imageUrl: String
    var indexTag: Int
    
    static var sampleOnboarding = Onboarding(title: "Welcome Test", description: "This is a dummypage with a sample description", imageUrl: "ratatouille", indexTag: 0)
    
    static var onboardingPages: [Onboarding] = [
    Onboarding(title: "Søk etter oppskrifter", description: "Du er bare et enkelt søk unna å finne nye deilige retter, basert på opphavsland, ingredienser, kategorier eller navn!", imageUrl: "ratatouille", indexTag: 0),
    Onboarding(title: "Legg til i favoritter", description: "Enkelt lagre dine favorittretter, så de er lett å finne fram når kokkeleringen skal begynne!", imageUrl: "favorite", indexTag: 1),
    Onboarding(title: "Spis og nyt!", description: "Tid for å lage dine nye favorittretter og nyte maten mens den enda er varm.", imageUrl: "rat1", indexTag: 2)
    ]
}
