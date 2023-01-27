import Foundation
import Firebase
import FirebaseStorage
import UIKit

protocol FavoriteRecipeServiceProtocol {
    func getFavoriteRecipe(
        completion: @escaping (Result<QuerySnapshot?, Error>) -> Void)
    
    func createRecipe(
        recipe: Recipe,
        completion: @escaping (Result<Void, Error>) -> Void)
    
    func deleteRecipe(
        recipe: Recipe,
        completion: @escaping (Result<Void, Error>) -> Void)
}

class FavoriteRecipeService: FavoriteRecipeServiceProtocol {
    
    func getFavoriteRecipe(completion: @escaping (Result<QuerySnapshot?, Error>) -> Void) {
        let db = Firestore.firestore()
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        db.collection("user").document(uid).collection("favorite_recipe")
                .getDocuments() { (querySnapshot, error) in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(querySnapshot))
            }
        }
    }
    
    func createRecipe(recipe: Recipe, completion: @escaping (Result<Void, Error>) -> Void) {
        let db = Firestore.firestore()
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        do {
            try db.collection("user").document(uid).collection("favorite_recipe").document(recipe.id!).setData(from: recipe) { err in
                if let err = err {
                    print(err.localizedDescription)
                    completion(.failure(err))
                } else {
                    completion(.success(()))
                }
            }
        } catch {
            completion(.failure(error))
        }
    }
    
    func deleteRecipe(recipe: Recipe, completion: @escaping (Result<Void, Error>) -> Void) {
        let db = Firestore.firestore()
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        db.collection("user").document(uid).collection("favorite_recipe").document(recipe.id!).delete() { err in
            if let err = err {
                print(err.localizedDescription)
                completion(.failure(err))
            } else {
                completion(.success(()))
            }
        }
    }
}
