//  Copyright © 2020 Lyle Resnick. All rights reserved.

import Foundation

class NetworkedTransactionManager: TransactionManager {
        
    private let baseURLString = "https://report-demo-backend.herokuapp.com/api"

    private let formatter = DateFormatter.dateFormatter( format: "yyyy-MM-dd'T'HH:mm:ss'Z'")
    private lazy var decoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .formatted(formatter)
        return decoder
    }()
    
    let session: URLSession
    
    init(session: URLSession = URLSession(configuration: .default)) {
        self.session = session
    }
        
    func fetchAuthorizedTransactions(completion: @escaping (TransactionListManagerResponse) -> ()) {
        return fetch(path: "sortedTransactions/authorized", completion: completion)
    }

    func fetchPostedTransactions(completion: @escaping (TransactionListManagerResponse) -> ()) {
        return fetch(path: "sortedTransactions/posted", completion: completion)
    }

    func fetchAllTransactions(completion: @escaping (TransactionListManagerResponse) -> ())  {
        return fetch(path: "sortedTransactions/all", completion: completion)
    }
    
    enum TransactionError: Error {
        case decoding(String)
    }
    
    private func fetch(path: String, completion:  @escaping (TransactionListManagerResponse) -> ()) {
        
        let url = URL(string: baseURLString + "/" + path)!
        
        let dataTask = session.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(code: 0, description: error.localizedDescription))
                return
            }
            if let data = data, let response = response as? HTTPURLResponse {
                if  response.statusCode == 200 {
                    do {
                        let networkedTransactionList = try self.decoder.decode([NetworkedTransaction].self, from: data)
                        let transactionList = networkedTransactionList.compactMap {
                            return Transaction(networkedTransaction: $0)
                        }
                        completion(.success(entity: transactionList))
                    }
                    catch {
                        return completion(.failure(code: 0, description: "JSON: error decoding 'NetworkedTransactionResult': \(error.localizedDescription)"))
                    }
                }
                else {
                    return completion(.failure(code: response.statusCode, description: "Networking Error"))
                }
            }
        }
        dataTask.resume()
    }
}

