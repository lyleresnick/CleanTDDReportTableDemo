
//  Copyright © 2017 Lyle Resnick. All rights reserved.

import XCTest
@testable import CleanTDDReportTableDemo

class FakeNilEntityGateway: EntityGateway {
    var transactionManager: TransactionManager = FakeNilManagerImpl()
}

class FakeNilManagerImpl: TransactionManager {
    
    func fetchAuthorizedTransactions(completion: @escaping (TransactionListManagerResponse) -> ()) {
        completion(.failure(code: 0, description: "nil"))
    }
    func fetchPostedTransactions(completion: @escaping (TransactionListManagerResponse) -> ()) {
        completion(.failure(code: 0, description: "nil"))
    }
    func fetchAllTransactions(completion: @escaping (TransactionListManagerResponse) -> ()) {
        completion(.failure(code: 0, description: "nil"))
    }
}

class FakeNoneEntityGateway: EntityGateway {
    var transactionManager: TransactionManager = FakeNoneManagerImpl()
}

class FakeNoneManagerImpl: TransactionManager {

    func fetchAuthorizedTransactions(completion: @escaping (TransactionListManagerResponse) -> ()) {
        completion(.success(entity: []))
    }
    func fetchPostedTransactions(completion: @escaping (TransactionListManagerResponse) -> ()) {
        completion(.success(entity: []))
    }
    func fetchAllTransactions(completion: @escaping (TransactionListManagerResponse) -> ()) {
        completion(.success(entity: []))
    }
}
