//  Copyright © 2020 Lyle Resnick. All rights reserved.

enum  TodoSemanticEvent: Error {
    case notFound
    case noData
}

typealias TransactionListManagerResponse = ManagerResponse<[Transaction], TodoSemanticEvent>

protocol TransactionManager: AnyObject {
    
    func fetchAuthorizedTransactions(completion: @escaping (TransactionListManagerResponse) -> ())
    func fetchPostedTransactions(completion: @escaping (TransactionListManagerResponse) -> ())
    func fetchAllTransactions(completion: @escaping (TransactionListManagerResponse) -> ())
}

