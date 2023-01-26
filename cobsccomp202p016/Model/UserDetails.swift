import FirebaseFirestoreSwift
import Firebase

struct UserDetails: Identifiable, Codable {
    @DocumentID var id: String? = UUID().uuidString
    var fullName: String
    var email: String
    
    enum CodingKeys: String, CodingKey {
        case fullName = "full_name"
        case email
    }
}
