import Foundation

enum CreditCardsList {

    enum LoadCards {
        struct Request {}

        struct Response {
            let cards: [CreditCardEntity]
        }

        struct ViewModel {
            let items: [Item]

            struct Item {
                let title: String
                let subtitle: String
            }
        }
    }

    enum SearchCards {
        struct Request {
            let query: String
        }

        struct Response {
            let cards: [CreditCardEntity]
        }

        struct ViewModel {
            let items: [LoadCards.ViewModel.Item]
            let isEmpty: Bool
        }
    }

    enum ErrorState {
        struct ViewModel {
            let message: String
        }
    }
}
