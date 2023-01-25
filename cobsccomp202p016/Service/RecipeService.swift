import Foundation
import Firebase
import FirebaseStorage
import UIKit

protocol RecipeServiceProtocol {
    func getRecipe(
        completion: @escaping (Result<QuerySnapshot?, Error>) -> Void)
}

class RecipeService: RecipeServiceProtocol {
    
    func getRecipe(completion: @escaping (Result<QuerySnapshot?, Error>) -> Void) {
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
    
}
