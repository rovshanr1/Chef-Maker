import SwiftUI

struct WelcomeView: View {
    var body: some View {
        ZStack {
            AppColors.lightBackground
                .ignoresSafeArea()
            
            VStack(spacing: 20) {
                Text("Chef Maker'a\nHoş Geldiniz!")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(AppColors.lightText)
                    .multilineTextAlignment(.center)
                
                Text("Lezzetli tarifleri keşfetmeye hazır mısınız?")
                    .font(.title3)
                    .foregroundColor(AppColors.lightText.opacity(0.8))
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)
                
//                NavigationLink(destination: MainTabView()) {
//                    Text("Hadi Başlayalım")
//                        .font(.headline)
//                        .foregroundColor(.white)
//                        .frame(maxWidth: .infinity)
//                        .padding()
//                        .background(AppColors.lightAccent)
//                        .cornerRadius(10)
//                }
//                .padding(.top, 30)
//                .padding(.horizontal, 20)
            }
            .padding()
        }
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    WelcomeView()
} 
