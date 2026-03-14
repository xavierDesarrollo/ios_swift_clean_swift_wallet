import Foundation

protocol CreditCardsListPresentationLogic {
    func presentCards(response: CreditCardsList.LoadCards.Response)
    func presentFilteredCards(response: CreditCardsList.SearchCards.Response)
    func presentError(message: String)
}

final class CreditCardsListPresenter: CreditCardsListPresentationLogic {

    weak var viewController: CreditCardsListDisplayLogic?

    func presentCards(response: CreditCardsList.LoadCards.Response) {
        let items = response.cards.map {
            CreditCardsList.LoadCards.ViewModel.Item(
                title: $0.name,
                subtitle: $0.number
            )
        }

        viewController?.displayCards(viewModel: .init(items: items))
    }

    func presentFilteredCards(response: CreditCardsList.SearchCards.Response) {
        let items = response.cards.map {
            CreditCardsList.LoadCards.ViewModel.Item(
                title: $0.name,
                subtitle: $0.number
            )
        }

        let isEmpty = items.isEmpty
        viewController?.displayFilteredCards(viewModel: .init(items: items, isEmpty: isEmpty))
    }

    func presentError(message: String) {
        viewController?.displayError(viewModel: .init(message: message))
    }
}
