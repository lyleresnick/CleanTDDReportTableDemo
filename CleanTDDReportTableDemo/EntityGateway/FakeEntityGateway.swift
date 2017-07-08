
//  Copyright © 2017 Lyle Resnick. All rights reserved.

import XCTest
@testable import CleanTDDReportTableDemo

class FakeNilEntityGateway: EntityGateway {
    var oneSourceManager: OneSourceManager = NilOneSourceManagerImpl()
    var twoSourceManager: TwoSourceManager = NilTwoSourceManagerImpl()
}

class NilOneSourceManagerImpl: OneSourceManager {
    
    func fetchAllTransactions() -> [TransactionEntity]? {
        return nil
    }
}

class NilTwoSourceManagerImpl: TwoSourceManager {
    
    func fetchAuthorizedTransactions() -> [TransactionEntity]? { return nil }
    func fetchPostedTransactions() -> [TransactionEntity]? { return nil }
}

