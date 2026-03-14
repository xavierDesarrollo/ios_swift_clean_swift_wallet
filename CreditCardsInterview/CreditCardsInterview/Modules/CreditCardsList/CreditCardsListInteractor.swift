import Foundation

protocol CreditCardsListBusinessLogic {
    func loadCards(request: CreditCardsList.LoadCards.Request)
    func searchCards(request: CreditCardsList.SearchCards.Request)
    func selectCard(at index: Int)
}

protocol CreditCardsListDataStore: AnyObject {
    var cards: [CreditCardEntity] { get set }
    var selectedCard: CreditCardEntity? { get set }
}

final class CreditCardsListInteractor: CreditCardsListBusinessLogic, CreditCardsListDataStore {

    var presenter: CreditCardsListPresentationLogic?
    var worker: CreditCardsListWorkerProtocol?

    var cards: [CreditCardEntity] = []
    var selectedCard: CreditCardEntity?

    private var filteredCards: [CreditCardEntity] = []

    func loadCards(request: CreditCardsList.LoadCards.Request) {
        do {
            let cards = try worker?.fetchCards() ?? []
            self.cards = cards
            self.filteredCards = cards
            presenter?.presentCards(response: .init(cards: cards))
        } catch {
            presenter?.presentError(message: error.localizedDescription)
        }
    }

    func searchCards(request: CreditCardsList.SearchCards.Request) {
        let query = request.query.trimmingCharacters(in: .whitespacesAndNewlines)

        if query.isEmpty {
            filteredCards = cards
        } else {
            filteredCards = cards.filter {
                $0.name.localizedCaseInsensitiveContains(query)
            }
        }

        presenter?.presentFilteredCards(response: .init(cards: filteredCards))
    }

    func selectCard(at index: Int) {
        guard filteredCards.indices.contains(index) else { return }
        selectedCard = filteredCards[index]
    }
}
