import SwiftUI

struct FeaturedListView: View {
    @StateObject private var viewModel = FeaturedViewModel()
    
   
    private let columns = [
        GridItem(.flexible(), spacing: 12),
        GridItem(.flexible(), spacing: 12)
    ]
    
    var body: some View {
        NavigationView {
            ScrollView {
                if viewModel.isLoading {
                    ProgressView()
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .padding(.top, 40)
                } else if let error = viewModel.error {
                    VStack(spacing: 16) {
                        Image(systemName: "exclamationmark.triangle")
                            .font(.largeTitle)
                            .foregroundColor(.orange)
                        Text(error.localizedDescription)
                            .multilineTextAlignment(.center)
                            .foregroundColor(.secondary)
                    }
                    .padding(.top, 40)
                } else {
                    LazyVGrid(columns: columns, spacing: 12) {
                        ForEach(viewModel.data) { recipe in
                            NavigationLink(destination: RecipeDetailView(recipe: recipe)) {
                                FeaturedGridItem(recipe: recipe)
                                    .frame(height: 180)
                            }
                            .buttonStyle(PlainButtonStyle())
                        }
                    }
                    .padding(.horizontal, 12)
                    .padding(.vertical, 16)
                }
            }
            .navigationTitle("Most Popular")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    FeaturedListView()
} 
