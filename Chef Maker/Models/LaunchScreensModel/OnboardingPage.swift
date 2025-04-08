//
//  File.swift
//  Chef Maker
//
//  Created by Rovshan Rasulov on 08.04.25.
//

import Foundation


struct OnboardingPage: Identifiable {
    let id = UUID()
    let title: String
    let description: String
    let imageName: String
}


let onboardingData = [
    OnboardingPage(
        title: "Discover Recipes",
        description: "Browse thousands of delicious recipes and save your favorites to your collection.",
        imageName: "discover_recipes"
    ),
    OnboardingPage(
        title: "Step-by-Step Instructions",
        description: "Master the kitchen with detailed and easy-to-follow recipe guides.",
        imageName: "step_by_step"
    ),
    OnboardingPage(
        title: "Share Your Own Recipes",
        description: "Share your unique creations with the community and inspire others.",
        imageName: "share_recipes"
    )
]

