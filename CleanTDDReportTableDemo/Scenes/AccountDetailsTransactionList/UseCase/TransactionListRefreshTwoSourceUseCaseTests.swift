//  Copyright © 2017 Lyle Resnick. All rights reserved.

import XCTest
@testable import CleanTDDReportTableDemo

class TransactionListRefreshTwoSourceUseCaseTests: XCTestCase {
    private var sut: TransactionListUseCase!
    private var stubPresenter: StubTransactionListPresenter!
    private var entityGateway = FakeNilEntityGateway()

    private var twoSourceTransformer: StubTransactionListRefreshTwoSourceUseCaseTransformer!

    override func setUp() {
        super.setUp()

        twoSourceTransformer = StubTransactionListRefreshTwoSourceUseCaseTransformer(transactionManager: FakeNoneManagerImpl())

        stubPresenter = StubTransactionListPresenter()
        sut = TransactionListUseCase(entityGateway: entityGateway)
        sut.output = stubPresenter
    }

    func test_refreshTwoSource_CallsTransformerWithPresenter() {

        sut.eventRefreshTwoSource(transformer: twoSourceTransformer)
        XCTAssertTrue(twoSourceTransformer.output === stubPresenter)
    }

    // MARK: Stubs

    class StubTransactionListRefreshTwoSourceUseCaseTransformer: TransactionListRefreshTwoSourceUseCaseTransformer {

        var output: TransactionListUseCaseOutput!

        override func transform( output: TransactionListRefreshUseCaseOutput ) {

            self.output = output as? TransactionListUseCaseOutput
        }
    }

    class StubTransactionListPresenter: TransactionListUseCaseOutput {

        func presentInit() {}
        func presentHeader(group: TransactionGroup) {}
        func presentSubheader(date: Date) {}
        func presentDetail(description: String, amount: Double) {}
        func presentSubfooter() {}
        func presentFooter(total: Double) {}
        func presentGrandFooter(grandTotal: Double) {}
        func presentNotFoundMessage(group: TransactionGroup) {}
        func presentNoTransactionsMessage(group: TransactionGroup) {}
        func presentNotFoundMessage() {}
        func presentReport() {}
    }
}
