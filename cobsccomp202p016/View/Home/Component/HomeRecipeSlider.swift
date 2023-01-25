import SwiftUI

struct HomeRecipeSlider: View {
    var title:String
    @StateObject var recipeViewModel = RecipeViewModel()
    var body: some View {
        VStack(alignment: .leading){
            Text(title)
                .fontWeight(.semibold)
                .font(.system(size: 28))
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach (recipeViewModel.recipes, id: \.id) { recipe in
                        HomeRecipeCard(
                            recipe: recipe
                        )
                    }
                }
            }
        }.padding(.leading)
    }
}

struct HomeRecipeSlider_Previews: PreviewProvider {
    static var previews: some View {
        HomeRecipeSlider(title: "Latest Recipe")
    }
}
