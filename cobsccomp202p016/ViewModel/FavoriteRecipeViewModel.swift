import UIKit
import Firebase
import Combine

class FavoriteRecipeViewModel: ObservableObject{
    @Published var isLoadingActive = false
    @Published var isInfoActive = false
    @Published var infoMsg = ""
    
    @Published var recipes = [Recipe]()
    
    private let favoriteRecipeService:FavoriteRecipeServiceProtocol
    
    init(favoriteRecipeService: FavoriteRecipeServiceProtocol = FavoriteRecipeService()) {
        self.favoriteRecipeService = favoriteRecipeService
        getRecipes()
    }
    
    func addFavorite(recipe:Recipe){
        isInfoActive = false
        infoMsg = ""
        isLoadingActive = true

        favoriteRecipeService.createRecipe(recipe: recipe
        ) { result in
                switch result {
                    case .success:
                        self.isLoadingActive = false
                        self.infoMsg = "ToDo crate successfully"
                        self.isInfoActive = true
                        self.getRecipes()
                    case let .failure(error):
                        print(error)
                        self.isLoadingActive = false
                        self.infoMsg = error.localizedDescription
                        self.isInfoActive = true
                }
            }
    }
    
    func deleteFavorite(recipe:Recipe){
        isInfoActive = false
        infoMsg = ""
        isLoadingActive = true

        favoriteRecipeService.deleteRecipe(recipe: recipe
        ) { result in
                switch result {
                    case .success:
                        self.isLoadingActive = false
                        self.infoMsg = "ToDo crate successfully"
                        self.isInfoActive = true
                        self.getRecipes()
                    case let .failure(error):
                        print(error)
                        self.isLoadingActive = false
                        self.infoMsg = error.localizedDescription
                        self.isInfoActive = true
                }
            }
    }
    
    
    func getRecipes(){
        isLoadingActive = true
        favoriteRecipeService.getFavoriteRecipe() { result in
            switch result {
                case let .success(querySnapshot):
                    guard let documents = querySnapshot?.documents else {
                        return
                    }
                
                    self.recipes = documents.compactMap { (queryDocumentSnapshot) -> Recipe? in
                        return try? queryDocumentSnapshot.data(as: Recipe.self)
                    }
                    self.isLoadingActive = false
                case .failure(_):
                    self.isLoadingActive = false
            }
        }
        isLoadingActive = false
    }
}
