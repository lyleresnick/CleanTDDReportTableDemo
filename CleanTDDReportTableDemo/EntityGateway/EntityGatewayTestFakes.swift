
//  Copyright © 2017 Lyle Resnick. All rights reserved.

import XCTest
@testable import CleanTDDReportTableDemo

class FakeNilEntityGateway: EntityGateway {
    var oneSourceManager: OneSourceManager = FakeNilOneSourceManagerImpl()
    var twoSourceManager: TwoSourceManager = FakeNilTwoSourceManagerImpl()
}

class FakeNilOneSourceManagerImpl: OneSourceManager {
    
    func fetchAllTransactions() -> [TransactionEntity]? { return nil }
}

class FakeNilTwoSourceManagerImpl: TwoSourceManager {
    
    func fetchAuthorizedTransactions() -> [TransactionEntity]? { return nil }
    func fetchPostedTransactions() -> [TransactionEntity]? { return nil }
}


class FakeNoneEntityGateway: EntityGateway {
    var oneSourceManager: OneSourceManager = FakeNoneOneSourceManagerImpl()
    var twoSourceManager: TwoSourceManager = FakeNoneTwoSourceManagerImpl()
}

class FakeNoneOneSourceManagerImpl: OneSourceManager {

    func fetchAllTransactions() -> [TransactionEntity]? { return [] }
}

class FakeNoneTwoSourceManagerImpl: TwoSourceManager {

    func fetchAuthorizedTransactions() -> [TransactionEntity]? { return [] }
    func fetchPostedTransactions() -> [TransactionEntity]? { return [] }
}

