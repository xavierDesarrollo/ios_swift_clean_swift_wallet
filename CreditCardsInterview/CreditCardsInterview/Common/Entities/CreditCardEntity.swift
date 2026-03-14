import Foundation

struct CreditCardEntity: Decodable {
    let id: String
    let name: String
    let number: String
    let availableAmount: Double
    let isBlocked: Bool
    
    enum CodingKeys: String, CodingKey {
        case id = "card_id"
        case name = "card_name"
        case number = "card_number"
        case availableAmount = "available_amount"
        case isBlocked = "is_blocked"
    }
}
