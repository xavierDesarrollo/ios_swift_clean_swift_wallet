import UIKit

enum CardType {
    case visa
    case mastercard
    case amex
    case unknown

    init(cardName: String) {
        let name = cardName.lowercased()

        if name.contains("visa") {
            self = .visa
        } else if name.contains("master") {
            self = .mastercard
        } else if name.contains("amex") {
            self = .amex
        } else {
            self = .unknown
        }
    }

    var backgroundColor: UIColor {
        switch self {
        case .visa:
            return UIColor(red: 36/255, green: 45/255, blue: 82/255, alpha: 1)
        case .mastercard:
            return UIColor(red: 235/255, green: 0/255, blue: 27/255, alpha: 1)
        case .amex:
            return UIColor(red: 0/255, green: 111/255, blue: 207/255, alpha: 1)
        case .unknown:
            return .systemGray
        }
    }
}
