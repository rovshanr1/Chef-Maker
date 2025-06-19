import SwiftUI
import Kingfisher

struct RecipeDetailsView: View {
    //constants
    let recipe: Recipe
   
    let ingredient: [Ingredient]
    let nutrition: [RecipeNutrient]
    var namespace: Namespace.ID
    
    //States
    @State private var selectedTab: DetailTab = .ingredients
    @StateObject var profileViewModel: ProfileViewModel
    @Binding var show: Bool

    
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.dismiss) var dismiss
     
    init(
          recipe: Recipe,
          profile: ProfileModel,
          ingredient: [Ingredient],
          nutrition: [RecipeNutrient],
          namespace: Namespace.ID,
          appState: AppState,
          show: Binding<Bool>
      ) {
          self.recipe = recipe
          self.ingredient = ingredient
          self.nutrition = nutrition
          self.namespace = namespace
          _profileViewModel = StateObject(wrappedValue: ProfileViewModel(appState: appState, profileUser: profile))
          self._show = show
      }
    
    var body: some View {
        ZStack {
            Color.appsBackground
                .ignoresSafeArea()
     
            VStack(alignment: .leading,spacing: 16){
                // Top Bar
                headerButton()
                 ScrollView{
                    VStack{
                        
                        // Recipe Image Card
                        cardView()
                        
                        //Profile View
                        profileView()
                        
                        //Detail View
                        detailTabView()
                    }
                }
        }
            
        }
        .navigationBarBackButtonHidden(true)
        
    }
    
    @ViewBuilder
    func headerButton() -> some View{
        HStack {
            Button(action: {
                withAnimation(.easeInOut(duration: 0.3)){
                    show = false
                }
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                    dismiss()
                }
            
            }) {
                Image(systemName: "chevron.backward")
                    .font(.title2)
                    .foregroundStyle(
                        Color(AppColors.adaptiveText(for: colorScheme)).opacity(0.5)
                    )
                    .padding(8)
            }
            
            Spacer()
            
            Menu{
                Button(action: {
                    // More Detail
                }) {
                    Label("Share", systemImage: "square.and.arrow.up")
                              .font(.title2)
                              .foregroundStyle(
                                Color(AppColors.adaptiveText(for: colorScheme)).opacity(0.5)
                              )
                }
                Button(action: {
                    // More Detail
                }) {
                    Label("Rate Recipe ", systemImage: "star")
                              .font(.title2)
                              .foregroundStyle(
                                Color(AppColors.adaptiveText(for: colorScheme)).opacity(0.5)
                              )
                }
                Button(action: {
                    // More Detail
                }) {
                    Label("Review", systemImage: "ellipsis.message")
                              .font(.title2)
                              .foregroundStyle(
                                Color(AppColors.adaptiveText(for: colorScheme)).opacity(0.5)
                              )
                }
                Button(action: {
                    // More Detail
                }) {
                    Label("Unsave", systemImage:"bookmark.slash")
                              .font(.title2)
                              .foregroundStyle(
                                Color(AppColors.adaptiveText(for: colorScheme)).opacity(0.5)
                              )
                }
                
            }label: {
                Label("", systemImage: "ellipsis")
                    .font(.title2)
                    .foregroundStyle(
                        Color(AppColors.adaptiveText(for: colorScheme)).opacity(0.5)
                    )
                    .padding(8)
                   
            }

        }
        .padding(.horizontal)
    }
    
    
    @ViewBuilder
    func cardView() -> some View {
        GeometryReader { proxy in
            ZStack(alignment: .topTrailing) {
                KFImage(URL(string: recipe.image))
                    .targetCache(CacheManager().imageCache)
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
                    .matchedGeometryEffect(id: "\(recipe.id)  image", in: namespace, isSource: show)
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
            
           
        }
        .frame(height: 220)

    }
    
   
    @ViewBuilder
    func profileView() -> some View {
        VStack {
            VStack(alignment: .leading){
                HStack {
                    Text(recipe.title)
                        .font(.custom("Poppins-Bold", size: 18))
                        .lineLimit(2)
                        .padding(8)
                    Spacer()
                    //Apidan cekilecek
                    Text("(12k reviews)")
                        .foregroundStyle(.secondary)
                        .padding(8)
                }
            }
            
            
            HStack(spacing: 12){
                
                ProfilePhoto(profile: profileViewModel.profile)
                                    
                VStack(alignment: .leading) {
                    Text(profileViewModel.profile.fullName)
                        .font(.custom("Poppins-SemiBold", size: 16))
                    
                    HStack{
                        Image("Location")
                            
                        //TODO: - User Location added
                        Text("Lagos, Nigeria")
                            .font(.custom("Poppins-SemiBold", size: 12))
                            .foregroundStyle(.secondary)
                    }
                }
                
                
                Spacer()
                
                Button(action: {
                    
                }){
                    Text("Follow")
                        .font(.custom("Poppins-Bold", size: 12))
                        .padding()

                }
                .background(
                    RoundedRectangle(cornerRadius: 12)
                        .fill(AppColors.filedFilterButtonColor)
                )
                .foregroundStyle(.white)
                
                
            }
            .padding(8)

        }
        .padding(.horizontal)
    }
    
    @ViewBuilder
    func detailTabView() -> some View {
        
        VStack {
            HStack{
                Button(action: {
                    withAnimation{
                        selectedTab = .ingredients
                    }
                }){
                    Text("Ingredients")
                        .font(.custom("Poppins-SemiBold", size: 12))
                        .foregroundStyle(selectedTab == .ingredients ? .white : AppColors.filedFilterButtonColor)
                        .frame(maxWidth: .infinity)
                        .padding(12)
                       
                }
                .background(
                    RoundedRectangle(cornerRadius: 12)
                        .fill(selectedTab == .ingredients ? AppColors.filedFilterButtonColor : Color.clear)
                )
                
                Button(action: {
                    withAnimation{
                        selectedTab = .nutrition
                    }
                }){
                    Text("Nutritions")
                        .font(.custom("Poppins-SemiBold", size: 12))
                        .foregroundStyle(selectedTab == .nutrition ? .white : AppColors.filedFilterButtonColor)
                        .frame(maxWidth: .infinity)
                        .padding(12)
                      
                }
                .background(
                    RoundedRectangle(cornerRadius: 12)
                        .fill(selectedTab == .nutrition ? AppColors.filedFilterButtonColor : Color.clear)
                )
            }
       
            
            if selectedTab == .ingredients{
                IngredietsView(ingredient: ingredient)
            }else if selectedTab == .nutrition{
                NutritionsView(nutrients: nutrition)
            }
        }
        .padding()
        
    }
   
}



#Preview{
    RecipeCardView(recipe: MockData.sampleRecipes[0])
        .environmentObject(AppState())
}
