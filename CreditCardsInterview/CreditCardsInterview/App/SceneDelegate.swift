import UIKit

final class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {
        guard let windowScene = scene as? UIWindowScene else { return }

        let viewController = CreditCardsListViewController()
        let interactor = CreditCardsListInteractor()
        let presenter = CreditCardsListPresenter()
        let router = CreditCardsListRouter()
        let worker = CreditCardsListWorker()

        viewController.interactor = interactor
        viewController.router = router

        interactor.presenter = presenter
        interactor.worker = worker

        presenter.viewController = viewController

        router.viewController = viewController
        router.dataStore = interactor

        let navigationController = UINavigationController(rootViewController: viewController)

        let window = UIWindow(windowScene: windowScene)
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
        self.window = window
    }
}
