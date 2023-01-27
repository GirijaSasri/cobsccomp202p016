import SwiftUI

struct RecipeDetailsView: View {
    var data: Recipe
    @StateObject var favoriteRecipeViewModel = FavoriteRecipeViewModel()
    
    var body: some View {
        VStack(alignment: .leading){
            AsyncImage(url: URL(string: data.image))
            { image in image
                        .resizable()
                        .frame(height: 250)
                        .scaledToFill()
            } placeholder: {
                ProgressView()
                    .frame(maxWidth: .infinity, minHeight: 250, maxHeight: 250)
                    .background(.gray.opacity(0.1))
            }
            Text(data.title)
                .font(.system(size: 22, weight: .bold))
                .padding(.leading)
                .padding(.bottom)
            Text(data.description)
                .font(.system(size: 12, weight: .thin))
                .padding(.leading)
            Text("ingredients-")
                .font(.system(size: 18, weight: .semibold))
                .padding(.leading)
                .padding(.top, 5)
                .padding(.bottom,2)
            VStack(alignment: .leading) {
                ForEach (data.ingredients, id: \.id) { ingredient in
                    HStack(){
                        Text(ingredient.name)
                            .font(.system(size: 14, weight: .thin))
                            .padding(.leading)
                        Text(ingredient.quantity)
                            .font(.system(size: 14, weight: .thin))
                            .padding(.leading)
                    }
                }
            }.padding(.leading)
            Spacer()
            Button(action: {
                let results = favoriteRecipeViewModel.recipes.filter { el in el.id == data.id }
                if results.count > 0 {
                    favoriteRecipeViewModel.deleteFavorite(recipe: data)
                } else {
                    favoriteRecipeViewModel.addFavorite(recipe: data)
                }
               }) {
                   let results = favoriteRecipeViewModel.recipes.filter { el in el.id == data.id }
                   if favoriteRecipeViewModel.isLoadingActive {
                       ProgressView()
                           .frame(maxWidth: .infinity)
                           .font(.system(size: 18))
                           .padding()
                           .foregroundColor(.green)
                           .background(.white)
                           .overlay(
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(Color.green, lineWidth: 2))
                   } else if results.count > 0 {
                       Text("Remove from Favorite")
                           .frame(maxWidth: .infinity)
                           .font(.system(size: 18))
                           .padding()
                           .foregroundColor(.green)
                           .background(.white)
                           .overlay(
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(Color.green, lineWidth: 2)
                           )
                   } else {
                       Text("Add to Favourite")
                           .frame(maxWidth: .infinity)
                           .font(.system(size: 18))
                           .padding()
                           .foregroundColor(.green)
                           .background(.white)
                           .overlay(
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(Color.green, lineWidth: 2)
                           )
                   }
               }
               .background(Color.green) // If you have this
               .cornerRadius(12)
               .padding()
        }
    }
}

struct RecipeDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        RecipeDetailsView(
            data: Recipe(
                title: "Recipe #1",
                description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
                image: "https://cdn.pixabay.com/photo/2015/09/16/20/10/dough-943245_1280.jpg",
                ingredients: [Ingredient(name: "ingredient #1", quantity: "1"),
                              Ingredient(name: "ingredient #2", quantity: "5"),
                              Ingredient(name: "ingredient #3", quantity: "1.5"),
                              Ingredient(name: "ingredient #4", quantity: "100g"),
                              Ingredient(name: "ingredient #5", quantity: "1L"),]
            )
        )
    }
}
