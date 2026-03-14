import UIKit

protocol CreditCardDetailDisplayLogic: AnyObject {
    func displayCard(viewModel: CreditCardDetail.LoadCard.ViewModel)
}

final class CreditCardDetailViewController: UIViewController, CreditCardDetailDisplayLogic {

    var interactor: CreditCardDetailBusinessLogic?
    var router: CreditCardDetailRouter?

    private let cardContainerView = UIView()
    private let nameLabel = UILabel()
    private let numberLabel = UILabel()
    private let amountTitleLabel = UILabel()
    private let amountLabel = UILabel()
    private let statusTitleLabel = UILabel()
    private let statusLabel = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        interactor?.loadCard(request: .init())
    }

    private func setup() {
        view.backgroundColor = .systemBackground
        title = "Card Detail"
        view.backgroundColor = .systemGroupedBackground

        cardContainerView.translatesAutoresizingMaskIntoConstraints = false
        cardContainerView.backgroundColor = UIColor(red: 36/255, green: 45/255, blue: 82/255, alpha: 1)
        cardContainerView.layer.cornerRadius = 20
        cardContainerView.layer.shadowColor = UIColor.black.cgColor
        cardContainerView.layer.shadowOpacity = 0.18
        cardContainerView.layer.shadowOffset = CGSize(width: 0, height: 6)
        cardContainerView.layer.shadowRadius = 10

        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.font = .boldSystemFont(ofSize: 24)
        nameLabel.textColor = .white
        nameLabel.numberOfLines = 2

        numberLabel.translatesAutoresizingMaskIntoConstraints = false
        numberLabel.font = .monospacedDigitSystemFont(ofSize: 20, weight: .medium)
        numberLabel.textColor = .white
        numberLabel.numberOfLines = 1

        amountTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        amountTitleLabel.text = "Available amount"
        amountTitleLabel.font = .systemFont(ofSize: 13, weight: .medium)
        amountTitleLabel.textColor = UIColor.white.withAlphaComponent(0.85)

        amountLabel.translatesAutoresizingMaskIntoConstraints = false
        amountLabel.font = .boldSystemFont(ofSize: 22)
        amountLabel.textColor = .white

        statusTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        statusTitleLabel.text = "Status"
        statusTitleLabel.font = .systemFont(ofSize: 13, weight: .medium)
        statusTitleLabel.textColor = UIColor.white.withAlphaComponent(0.85)

        statusLabel.translatesAutoresizingMaskIntoConstraints = false
        statusLabel.font = .boldSystemFont(ofSize: 18)
        statusLabel.textColor = .white

        view.addSubview(cardContainerView)

        cardContainerView.addSubview(nameLabel)
        cardContainerView.addSubview(numberLabel)
        cardContainerView.addSubview(amountTitleLabel)
        cardContainerView.addSubview(amountLabel)
        cardContainerView.addSubview(statusTitleLabel)
        cardContainerView.addSubview(statusLabel)

        NSLayoutConstraint.activate([
            cardContainerView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            cardContainerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            cardContainerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            cardContainerView.heightAnchor.constraint(equalToConstant: 240),

            nameLabel.topAnchor.constraint(equalTo: cardContainerView.topAnchor, constant: 24),
            nameLabel.leadingAnchor.constraint(equalTo: cardContainerView.leadingAnchor, constant: 20),
            nameLabel.trailingAnchor.constraint(equalTo: cardContainerView.trailingAnchor, constant: -20),

            numberLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 28),
            numberLabel.leadingAnchor.constraint(equalTo: cardContainerView.leadingAnchor, constant: 20),
            numberLabel.trailingAnchor.constraint(equalTo: cardContainerView.trailingAnchor, constant: -20),

            amountTitleLabel.leadingAnchor.constraint(equalTo: cardContainerView.leadingAnchor, constant: 20),
            amountTitleLabel.bottomAnchor.constraint(equalTo: amountLabel.topAnchor, constant: -4),

            amountLabel.leadingAnchor.constraint(equalTo: cardContainerView.leadingAnchor, constant: 20),
            amountLabel.bottomAnchor.constraint(equalTo: cardContainerView.bottomAnchor, constant: -24),

            statusTitleLabel.trailingAnchor.constraint(equalTo: cardContainerView.trailingAnchor, constant: -20),
            statusTitleLabel.bottomAnchor.constraint(equalTo: statusLabel.topAnchor, constant: -4),

            statusLabel.trailingAnchor.constraint(equalTo: cardContainerView.trailingAnchor, constant: -20),
            statusLabel.bottomAnchor.constraint(equalTo: cardContainerView.bottomAnchor, constant: -24)
        ])
    }

    func displayCard(viewModel: CreditCardDetail.LoadCard.ViewModel) {
        nameLabel.text = "\(viewModel.title)"
        numberLabel.text = "\(viewModel.number)"
        amountLabel.text = "\(viewModel.availableAmount)"
        statusLabel.text = "\(viewModel.status)"
        cardContainerView.backgroundColor = viewModel.cardColor
        statusLabel.textColor = viewModel.status == "Blocked" ? .systemRed : .systemGreen
    }
}
