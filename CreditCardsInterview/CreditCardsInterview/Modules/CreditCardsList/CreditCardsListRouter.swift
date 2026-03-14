import UIKit

protocol CreditCardsListRoutingLogic {
    func routeToCardDetail()
}

protocol CreditCardsListDataPassing {
    var dataStore: CreditCardsListDataStore? { get }
}

final class CreditCardsListRouter: CreditCardsListRoutingLogic, CreditCardsListDataPassing {

    weak var viewController: UIViewController?
    var dataStore: CreditCardsListDataStore?

    func routeToCardDetail() {
        let detailViewController = CreditCardDetailViewController()
        let detailInteractor = CreditCardDetailInteractor()
        let detailPresenter = CreditCardDetailPresenter()
        let detailRouter = CreditCardDetailRouter()

        detailViewController.interactor = detailInteractor
        detailViewController.router = detailRouter
        detailInteractor.presenter = detailPresenter
        detailPresenter.viewController = detailViewController
        detailRouter.viewController = detailViewController

        detailInteractor.selectedCard = dataStore?.selectedCard

        viewController?.navigationController?.pushViewController(detailViewController, animated: true)
    }
}
