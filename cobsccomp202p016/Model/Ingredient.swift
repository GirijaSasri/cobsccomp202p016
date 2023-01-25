import Foundation
import FirebaseFirestoreSwift
import Firebase


struct Ingredient: Identifiable, Codable {
    @DocumentID var id: String? = UUID().uuidString
    var name: String
    var quantity: String
    
    enum CodingKeys: String, CodingKey {
        case name
        case quantity
    }
}
