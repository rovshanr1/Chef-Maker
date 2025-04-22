import SwiftUI

struct OnboardingView: View {
    @State private var currentPage = 0
    @State private var showWelcomeView: Bool = false
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        NavigationStack{
            ZStack {
                AppColors.adaptiveBackground(for: colorScheme)
                    .ignoresSafeArea()
                
                VStack {
                    TabView(selection: $currentPage) {
                        ForEach(0..<onboardingData.count, id: \.self) { index in
                            OnboardingPageView(page: onboardingData[index])
                                .tag(index)
                        }
                    }
                    .tabViewStyle(PageTabViewStyle(indexDisplayMode: .always))
                    
                    Button(action: {
                        UIImpactFeedbackGenerator(style: .medium).impactOccurred()
                        if currentPage < onboardingData.count - 1 {
                            withAnimation {
                                currentPage += 1
                            }
                        } else {
                            showWelcomeView = true
                        }
                    }) {
                        Text(currentPage < onboardingData.count - 1 ? "Next" : "Start Cooking ")
                            .font(.headline)
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(AppColors.lightAccent)
                            .cornerRadius(10)
                    }
                    .padding(.horizontal, 20)
                    .padding(.bottom, 30)
                }
            }
            .navigationDestination(isPresented: $showWelcomeView){
                WelcomeView()
            }
            .navigationBarBackButtonHidden(true)
        }
    }
}





#Preview {
    OnboardingView()
} 
