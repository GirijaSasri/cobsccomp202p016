import SwiftUI

struct FavouriteView: View {
    let data = (1...100).map { "Item \($0)" }

        let columns = [
            GridItem(.adaptive(minimum: 150))
        ]
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 20) {
                ForEach(data, id: \.self) { item in
                    HomeRecipeCard(recipe: Recipe(
                        title: "Recipe #1",
                        description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
                        image: "https://cdn.pixabay.com/photo/2015/09/16/20/10/dough-943245_1280.jpg",
    //                    isCompleted: false,
                        ingredients: [Ingredient(name: "ingredient #1", quantity: "1"),
                                      Ingredient(name: "ingredient #2", quantity: "5"),
                                      Ingredient(name: "ingredient #3", quantity: "1.5"),
                                      Ingredient(name: "ingredient #4", quantity: "100g"),
                                      Ingredient(name: "ingredient #5", quantity: "1L"),]
                    ))
                }
            }
            .padding(.horizontal)
        }
        .padding(.top)
    }
}

struct FavouriteView_Previews: PreviewProvider {
    static var previews: some View {
        FavouriteView()
    }
}
