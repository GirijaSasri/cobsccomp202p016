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
    }
    
    func addFavorite(id:String){
        isInfoActive = false
        infoMsg = ""
        isLoadingActive = true

        favoriteRecipeService.createRecipe(id: id
        ) { result in
                switch result {
                    case .success:
                        self.isLoadingActive = false
                        self.infoMsg = "ToDo crate successfully"
                        self.isInfoActive = true
                    case let .failure(error):
                        print(error)
                        self.isLoadingActive = false
                        self.infoMsg = error.localizedDescription
                        self.isInfoActive = true
                }
            }
    }
}
