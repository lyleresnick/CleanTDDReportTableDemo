//  Copyright © 2017 Lyle Resnick. All rights reserved.

import XCTest
@testable import CleanTDDReportTableDemo

class TransactionListUseCaseTwoSourceTests: XCTestCase {
    private var sut: TransactionListUseCase!
    private var stubPresenter: StubTransactionListPresenter!
    private var entityGateway = FakeNilEntityGateway()

    private var twoSourceTransformer: StubTransactionListUseCaseBeginTwoSourceTransformer!

    override func setUp() {
        super.setUp()

        twoSourceTransformer = StubTransactionListUseCaseBeginTwoSourceTransformer(transactionManager: FakeNoneTwoSourceManagerImpl())

        stubPresenter = StubTransactionListPresenter()
        sut = TransactionListUseCase(entityGateway: entityGateway)
        sut.output = stubPresenter
    }

    func test_beginTwoSource_CallsTransformerWithPresenter() {

        sut.begin(transformer: twoSourceTransformer)
        XCTAssertTrue(twoSourceTransformer.output === stubPresenter)
    }

    // MARK: Stubs

    class StubTransactionListUseCaseBeginTwoSourceTransformer: TransactionListUseCaseBeginTwoSourceTransformer {

        var output: TransactionListUseCaseOutput!

        override func transform( output: TransactionListUseCaseOutput ) {

            self.output = output
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
