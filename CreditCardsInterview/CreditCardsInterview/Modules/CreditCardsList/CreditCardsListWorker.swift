import Foundation

protocol CreditCardsListWorkerProtocol {
    func fetchCards() throws -> [CreditCardEntity]
}

final class CreditCardsListWorker: CreditCardsListWorkerProtocol {
    func fetchCards() throws -> [CreditCardEntity] {
        guard let url = Bundle.main.url(forResource: "credit_cards", withExtension: "json") else {
            throw NSError(domain: "FileError", code: 100, userInfo: [NSLocalizedDescriptionKey: "Could not find local JSON file."])
        }

        let data = try Data(contentsOf: url)
        return try JSONDecoder().decode([CreditCardEntity].self, from: data)
    }
}
