import FirebaseFirestoreSwift
import Firebase

struct Recipe: Identifiable, Codable {
    @DocumentID var id: String? = UUID().uuidString
    var title: String
    var description: String
    var image: String
    var ingredients: [Ingredient]
    
    enum CodingKeys: String, CodingKey {
        case title
        case description
        case image
        case ingredients
    }
}
