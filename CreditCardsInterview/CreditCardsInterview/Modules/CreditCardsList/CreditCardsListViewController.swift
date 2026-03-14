import UIKit

protocol CreditCardsListDisplayLogic: AnyObject {
    func displayCards(viewModel: CreditCardsList.LoadCards.ViewModel)
    func displayFilteredCards(viewModel: CreditCardsList.SearchCards.ViewModel)
    func displayError(viewModel: CreditCardsList.ErrorState.ViewModel)
}

final class CreditCardsListViewController: UIViewController, CreditCardsListDisplayLogic {

    var interactor: CreditCardsListBusinessLogic?
    var router: CreditCardsListRoutingLogic?

    private let searchBar = UISearchBar()
    private let tableView = UITableView(frame: .zero, style: .plain)
    private let emptyStateLabel = UILabel()

    private var items: [CreditCardsList.LoadCards.ViewModel.Item] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        interactor?.loadCards(request: .init())
    }

    private func setup() {
        title = "Credit Cards"
        view.backgroundColor = .systemBackground

        searchBar.placeholder = "Search by card name"
        searchBar.delegate = self

        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.dataSource = self
        tableView.delegate = self
        tableView.tableFooterView = UIView()

        emptyStateLabel.text = "No cards found"
        emptyStateLabel.textAlignment = .center
        emptyStateLabel.numberOfLines = 0
        emptyStateLabel.isHidden = true

        [searchBar, tableView, emptyStateLabel].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview($0)
        }

        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),

            tableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            emptyStateLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            emptyStateLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            emptyStateLabel.leadingAnchor.constraint(greaterThanOrEqualTo: view.leadingAnchor, constant: 24),
            emptyStateLabel.trailingAnchor.constraint(lessThanOrEqualTo: view.trailingAnchor, constant: -24)
        ])
    }

    func displayCards(viewModel: CreditCardsList.LoadCards.ViewModel) {
        items = viewModel.items
        tableView.reloadData()
    }

    func displayFilteredCards(viewModel: CreditCardsList.SearchCards.ViewModel) {
        items = viewModel.items
        emptyStateLabel.isHidden = !items.isEmpty
        tableView.reloadData()
    }

    func displayError(viewModel: CreditCardsList.ErrorState.ViewModel) {
        let alert = UIAlertController(title: "Error", message: viewModel.message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}

extension CreditCardsListViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        interactor?.searchCards(request: .init(query: searchText))
    }
}

extension CreditCardsListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        items.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        var content = cell.defaultContentConfiguration()
        let item = items[indexPath.row]
        content.text = item.title
        content.secondaryText = item.subtitle
        cell.contentConfiguration = content
        cell.accessoryType = .disclosureIndicator
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        interactor?.selectCard(at: indexPath.row)
        router?.routeToCardDetail()
    }
}
