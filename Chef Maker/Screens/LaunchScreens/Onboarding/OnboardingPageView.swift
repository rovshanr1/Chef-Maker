//
//  OnboardingPageView.swift
//  Chef Maker
//
//  Created by Rovshan Rasulov on 08.04.25.
//
import SwiftUI

struct OnboardingPageView: View {
    let page: OnboardingPageModel
    
    var body: some View {
        VStack(spacing: 20) {
            Image(page.imageName)
                .resizable()
                .scaledToFit()
                .frame(width: 250, height: 250)
                .padding(.top, 50)
            
            Text(page.title)
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(AppColors.lightText)
                .multilineTextAlignment(.center)
                .padding(.horizontal)
            
            Text(page.description)
                .font(.body)
                .foregroundColor(AppColors.lightText.opacity(0.8))
                .multilineTextAlignment(.center)
                .padding(.horizontal)
                .padding(.bottom)
        }
        .padding()
    }
}
