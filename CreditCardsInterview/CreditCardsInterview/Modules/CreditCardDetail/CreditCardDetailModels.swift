import Foundation
import UIKit

enum CreditCardDetail {

    enum LoadCard {
        struct Request {}

        struct Response {
            let card: CreditCardEntity
        }

        struct ViewModel {
            let title: String
            let number: String
            let availableAmount: String
            let status: String
            let cardColor: UIColor
        }
    }
}
