import SwiftUI

struct FavouriteView: View {
    let data = (1...100).map { "Item \($0)" }

    let columns = [
        GridItem(.adaptive(minimum: 150))
    ]
    @StateObject var favoriteRecipeViewModel = FavoriteRecipeViewModel()
    var body: some View {
        ScrollView {
            if favoriteRecipeViewModel.isLoadingActive {
                ProgressView()
                    .frame(maxWidth: .infinity, minHeight: 120, maxHeight: 120)
                    .background(.gray.opacity(0.1))
            } else {
                LazyVGrid(columns: columns, spacing: 20) {
                    ForEach(favoriteRecipeViewModel.recipes, id: \.id) { item in
                        HomeRecipeCard(recipe: item)
                    }
                }
                .padding(.horizontal)
            }
        }
        .padding(.top)
    }
}

struct FavouriteView_Previews: PreviewProvider {
    static var previews: some View {
        FavouriteView()
    }
}
