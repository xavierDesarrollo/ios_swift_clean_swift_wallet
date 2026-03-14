import Foundation

protocol CreditCardDetailPresentationLogic {
    func presentCard(response: CreditCardDetail.LoadCard.Response)
}

final class CreditCardDetailPresenter: CreditCardDetailPresentationLogic {

    weak var viewController: CreditCardDetailDisplayLogic?

    func presentCard(response: CreditCardDetail.LoadCard.Response) {
        let card = response.card

        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencyCode = "USD"
        formatter.locale = Locale(identifier: "en_US")

        let formattedAmount = formatter.string(from: NSNumber(value: card.availableAmount))
            ?? "\(card.availableAmount)"

        let status = card.isBlocked ? "Blocked" : "Active"
        
        let cardType = CardType(cardName: card.name)

        let viewModel = CreditCardDetail.LoadCard.ViewModel(
            title: card.name,
            number: card.number,
            availableAmount: formattedAmount,
            status: status,
            cardColor: cardType.backgroundColor
        )

        viewController?.displayCard(viewModel: viewModel)
    }
}
