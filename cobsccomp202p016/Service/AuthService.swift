import Foundation
import Firebase

protocol AuthServiceProtocol {
    func signIn(
        email: String,
        password: String,
        completion: @escaping (Result<Void, Error>) -> Void)
    
    func signUp(
        user: UserDetails,
        password: String,
        completion: @escaping (Result<Void, Error>) -> Void)
}

class AuthService: AuthServiceProtocol {
    
    func signIn(email: String, password: String, completion: @escaping (Result<Void, Error>) -> Void) {
        let db = Firestore.firestore()
        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
            if error != nil {
                completion(.failure(error!))
            } else {
                guard let uid = Auth.auth().currentUser?.uid else { return }
                db.collection("users").document(uid).getDocument { (document, error) in
                    if let document = document, document.exists {
                        do {
                            let user = try document.data(as: UserDetails.self)
                            let encoder = JSONEncoder()
                            if let encoded = try? encoder.encode(user) {
                                let defaults = UserDefaults.standard
                                defaults.set(encoded, forKey: "userDetails")
                            }
                        }
                        catch{return}
                        completion(.success(()))
                    } else{
                        completion(.failure(NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey : "Invaild username"])))
                    }
                }
            }
        }
    }
    
    func signUp(user: UserDetails, password: String, completion: @escaping (Result<Void, Error>) -> Void) {
        let db = Firestore.firestore()
        Auth.auth().createUser(withEmail: user.email, password: password) { (result, error) in
            if error != nil {
                completion(.failure(error!))
            } else {
                guard let uid = Auth.auth().currentUser?.uid else { return }
                let userData: [String: Any] = [
                    "email": user.email,
                    "first_name": user.firstName,
                    "last_name": user.lastName,
                ]
                db.collection("user").document(uid).setData(userData) { err in
                    if let err = err {
                        completion(.failure(err))
                    } else {
                        do {
                            let encoder = JSONEncoder()
                            if let encoded = try? encoder.encode(user) {
                                let defaults = UserDefaults.standard
                                defaults.set(encoded, forKey: "userDetails")
                            }
                        }
                        completion(.success(()))
                    }
                }
            }
        }
    }
    
    
    func forgetPassword(email: String, completion: @escaping (Result<Void, Error>) -> Void) {
        Auth.auth().sendPasswordReset(withEmail: email) { err in
            if let err = err {
                completion(.failure(err))
            } else {
                completion(.success(()))
            }
        }
    }
    
    func updateUserDetails(nic:String, mobile: String, location: GeoPoint, completion: @escaping (Result<Void, Error>) -> Void) {
        let db = Firestore.firestore()
        db.collection("users").document(nic).updateData([
            "mobile": mobile,
            "location": location
        ]) { err in
            if let err = err {
                completion(.failure(err))
            } else {
                do {
                    let defaults = UserDefaults.standard
                    if let user = defaults.object(forKey: "userDetails") as? Data {
                        let decoder = JSONDecoder()
                        if let loadedUser = try? decoder.decode(UserDetails.self, from: user) {
                            let encoder = JSONEncoder()
                            if let encoded = try? encoder.encode(loadedUser) {
                                let defaults = UserDefaults.standard
                                defaults.set(encoded, forKey: "userDetails")
                            }
                            
                        }
                    }
                }
                
                completion(.success(()))
            }
        }
    }
    
    func resetPassword(newPassword: String, completion: @escaping (Result<Void, Error>) -> Void) {
        Auth.auth().currentUser?.updatePassword(to: newPassword) { err in
            if let err = err {
                completion(.failure(err))
            } else {
                completion(.success(()))
            }
        }
    }
    
}
