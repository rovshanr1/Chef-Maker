import SwiftUI
import Kingfisher

struct RecipeDetailsView: View {
    let recipe: Recipe
    let profile: ProfileModel
    
    @Environment(\.colorScheme) var colorScheme
     
    
    var body: some View {
        ZStack {
            AppColors.adaptiveMainTabView(for: colorScheme)
                .ignoresSafeArea()
            
            VStack(alignment: .leading,spacing: 16) {
                // Top Bar
                HStack {
                    Button(action: {
                        // Back button action
                    }) {
                        Image(systemName: "arrow.backward")
                            .font(.title2)
                            .foregroundStyle(Color(AppColors.adaptiveText(for: colorScheme)).opacity(0.5))
                            .padding(8)
                    }
                    
                    Spacer()
                    
                    Button(action: {
                        // More Detail
                    }) {
                        Image(systemName: "ellipsis")
                            .font(.title2)
                            .foregroundStyle(Color(AppColors.adaptiveText(for: colorScheme)).opacity(0.5))
                            .padding(8)
                    }
                }
                .padding(.horizontal)
                
                // Recipe Image Card
                cardView()
                //Profile View
                profileView()
            }
            .padding()
        }
      
    }
    
    @ViewBuilder
    func cardView() -> some View {
        GeometryReader { proxy in
            ZStack(alignment: .topTrailing) {
                KFImage(URL(string: recipe.image))
                    .targetCache(CacheManager.shared.imageCache)
                    .placeholder {
                        RoundedRectangle(cornerRadius: 20, style: .continuous)
                            .foregroundStyle(AppColors.cardBackground)
                    }
                    .fade(duration: 0.5)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: proxy.size.width * 0.9, height: 220)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                    .shadow(color: Color.black.opacity(0.1), radius: 10, x: 0, y: 5)
                    .overlay(
                        LinearGradient(
                            gradient: Gradient(colors: [.black.opacity(0.8), .black.opacity(0)]),
                            startPoint: .bottom,
                            endPoint: .top
                        )
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                    )
                    .frame(maxWidth: .infinity, alignment: .center)
                
                // Top right: rating and bookmark
                VStack(alignment: .trailing, spacing: 12) {
                    HStack(spacing: 4) {
                        Image(systemName: "star.fill")
                            .resizable()
                            .frame(width: 12, height: 12)
                            .foregroundStyle(AppColors.secondaryColor)
                        
                        Text("\(recipe.starRating)")
                            .font(.system(size: 12))
                            .foregroundStyle(.white)
                    }
                    .padding(8)
                    .background(Color.gray.opacity(0.6))
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                    
                    Spacer()
                    
                    HStack{
                        Image("Timer")
                        
                        Text("\(recipe.readyInMinutes) min")
                            .font(.system(size: 12))
                            .foregroundStyle(.white.opacity(0.8))
                        
                        Button(action: {
                            // Bookmark action
                        }) {
                            Image("Bookmark2")
                                .padding(8)
                        }
                    }
                }
                .padding(12)
                .padding(.trailing)
            }
            .frame(height: 220)
            
            VStack(alignment: .leading){
                Spacer()
                HStack {
                    Text(recipe.title)
                        .font(.custom("Poppins-Bold", size: 18))
                        .lineLimit(2)
                        .padding(8)
                    
                    //Apidan cekilecek
                    Text("(12k reviews)")
                        .foregroundStyle(.secondary)
                }
            }
            .padding(.leading)
        }
        .frame(height: 260)
    }
    
    @ViewBuilder
    func profileView() -> some View {
        VStack {
            HStack {
                Circle()
                    .fill(.gray)
                    .frame(width: 52, height: 52)
                    .overlay(
                        Text(profile.initials)
                            .font(.custom("Poppins-SemiBold", size: 12))
                            .foregroundStyle(.white)
                    )
                
                VStack(alignment: .leading) {
                    Text(profile.fullName)
                    
                    HStack{
                        Image("Location")
                        
                        //TODO: - User Location added
                        Text("Lagos, Nigeria")
                            .font(.custom("Poppins-SemiBold", size: 12))
                    }
                }
                
                Spacer()
                
                Button(action: {
                    
                }){
                    Text("Follow")
                }
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 12)
                        .fill(AppColors.filedFilterButtonColor)
                )
                .foregroundStyle(.white)
                
                
            }
        }
        .padding(.horizontal)
    }
   
}


#Preview {
    RecipeDetailsView(recipe: MockData.sampleRecipe, profile: ProfileModel.preview)
}
