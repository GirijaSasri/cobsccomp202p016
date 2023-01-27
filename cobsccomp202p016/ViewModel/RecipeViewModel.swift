import Foundation
import UIKit
import Firebase
import Combine

class RecipeViewModel: ObservableObject{
    @Published var isLoadingActive = false
    @Published var isInfoActive = false
    @Published var infoMsg = ""
    
    @Published var recipes = [Recipe]()
    
    private let recipeService:RecipeServiceProtocol
    
    init(recipeService: RecipeServiceProtocol = RecipeService()) {
        self.recipeService = recipeService
        getRecipes()
    }

    func getRecipes(){
        isLoadingActive = true
        recipeService.getRecipe() { result in
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
    }
    
}
