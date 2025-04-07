import SwiftUI

struct RecipeCard: View {
    let recipe: Recipe
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            // Image
            if let url = URL(string: recipe.image) {
                AsyncImage(url: url) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                } placeholder: {
                    Color.gray.opacity(0.3)
                }
                .frame(height: 150)
                .clipShape(RoundedRectangle(cornerRadius: 12))
            }
            
            // Title
            Text(recipe.title)
                .font(.headline)
                .lineLimit(2)
            
            // Nutrition info
            if let calories = recipe.nutrition.nutrients.first(where: { $0.name == "Calories" }) {
                Text("\(Int(calories.amount)) kcal")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            
            // Additional nutrition info
            HStack(spacing: 12) {
                NutrientView(
                    label: "Protein",
                    value: recipe.nutrition.nutrients.first(where: { $0.name == "Protein" })?.amount ?? 0
                )
                NutrientView(
                    label: "Carbs",
                    value: recipe.nutrition.nutrients.first(where: { $0.name == "Carbohydrates" })?.amount ?? 0
                )
                NutrientView(
                    label: "Fat",
                    value: recipe.nutrition.nutrients.first(where: { $0.name == "Fat" })?.amount ?? 0
                )
            }
        }
        .padding(12)
        .background(Color.white)
        .cornerRadius(16)
        .shadow(radius: 4)
    }
}


