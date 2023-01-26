import Foundation
import Firebase
import FirebaseStorage
import UIKit

protocol FavoriteRecipeServiceProtocol {
    func getFavoriteRecipe(
        completion: @escaping (Result<QuerySnapshot?, Error>) -> Void)
    
    func createRecipe(
        id: String,
        completion: @escaping (Result<Void, Error>) -> Void)
}

class FavoriteRecipeService: FavoriteRecipeServiceProtocol {
    
    func getFavoriteRecipe(completion: @escaping (Result<QuerySnapshot?, Error>) -> Void) {
        let db = Firestore.firestore()
        db.collection("recipe")
                .getDocuments() { (querySnapshot, error) in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(querySnapshot))
            }
        }
    }
    
    func createRecipe(id: String, completion: @escaping (Result<Void, Error>) -> Void) {
        let db = Firestore.firestore()
        guard let uid = Auth.auth().currentUser?.uid else { return }
        let documentRefString = db.collection("recipe").document(id)
        let recipeRef = db.document(documentRefString.path)
        
        let data: [String: Any] = [
            "recipe":recipeRef
        ]
        
        db.collection("user").document(uid).collection("favorite_recipe").document().setData(data) { err in
            if let err = err {
                print(err.localizedDescription)
                completion(.failure(err))
            } else {
                completion(.success(()))
            }
        }
    }
    
}
