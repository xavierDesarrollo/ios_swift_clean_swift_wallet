import Foundation

protocol CreditCardDetailBusinessLogic {
    func loadCard(request: CreditCardDetail.LoadCard.Request)
}

final class CreditCardDetailInteractor: CreditCardDetailBusinessLogic {

    var presenter: CreditCardDetailPresentationLogic?
    var selectedCard: CreditCardEntity?

    func loadCard(request: CreditCardDetail.LoadCard.Request) {
        guard let selectedCard else { return }
        presenter?.presentCard(response: .init(card: selectedCard))
    }
}
