import SwiftUI

struct HomeRecipeCard: View {
    var recipe:Recipe
    @StateObject var authViewModel = AuthViewModel()
    var body: some View {
        NavigationLink(destination: RecipeDetailsView(data: recipe)
        ){
            ZStack {
                Color(.gray)
                    .opacity(0.2)
                    .cornerRadius(12)
                VStack(alignment: .leading){
                    AsyncImage(url: URL(string: recipe.image),
                    content: { image in
                        image.resizable()
                            .frame(height: 120)
                    }) {
                        ProgressView()
                            .frame(maxWidth: .infinity, minHeight: 120, maxHeight: 120)
                            .background(.gray.opacity(0.1))
                    }
                        .cornerRadius(12)
                        .frame(height: 120)
                    Text(recipe.title)
                        .fontWeight(.medium)
                        .font(.system(size: 18))
                        .padding(.leading)
                    Text(recipe.description)
                        .fontWeight(.medium)
                        .font(.system(size: 12))
                        .lineLimit(3)
                        .padding(.horizontal)
                    Spacer()
                }
            }
            .frame(width: 150, height: 210)
            .padding(.trailing, 5)
        }
    }
}

struct HomeRecipeCard_Previews: PreviewProvider {
    static var previews: some View {
        HomeRecipeCard(
            recipe: Recipe(
                title: "Recipe #1",
                description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
                image: "https://cdn.pixabay.com/photo/2015/09/16/20/10/dough-943245_1280.jpg",
//                    isCompleted: false,
                ingredients: [Ingredient(name: "ingredient #1", quantity: "1"),
                              Ingredient(name: "ingredient #2", quantity: "5"),
                              Ingredient(name: "ingredient #3", quantity: "1.5"),
                              Ingredient(name: "ingredient #4", quantity: "100g"),
                              Ingredient(name: "ingredient #5", quantity: "1L"),]
            )
        )
    }
}
