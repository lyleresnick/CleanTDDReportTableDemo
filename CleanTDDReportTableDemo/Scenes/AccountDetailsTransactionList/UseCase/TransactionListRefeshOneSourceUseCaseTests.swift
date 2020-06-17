//  Copyright © 2017 Lyle Resnick. All rights reserved.

import XCTest
@testable import CleanTDDReportTableDemo

class TransactionListRefeshOneSourceUseCaseTests: XCTestCase {
    private var sut: TransactionListUseCase!
    private var stubPresenter: StubTransactionListPresenter!
    private var entityGateway = FakeNilEntityGateway()

    private var oneSourceTransformer: StubTransactionListUseCaseRefreshOneSourceTransformer!

    override func setUp() {
        super.setUp()

        oneSourceTransformer = StubTransactionListUseCaseRefreshOneSourceTransformer(transactionManager: FakeNoneManagerImpl())

        stubPresenter = StubTransactionListPresenter()
        sut = TransactionListUseCase(entityGateway: entityGateway)
        sut.output = stubPresenter
    }

    func test_refreshOneSource_CallsTransformer() {
        
        sut.eventRefreshOneSource(transformer: oneSourceTransformer)
        XCTAssertTrue(oneSourceTransformer.didCall)
    }
    
    func test_refreshOneSource_CallsTransformerWithPresenter() {
        
        sut.eventRefreshOneSource(transformer: oneSourceTransformer)
        XCTAssertTrue(oneSourceTransformer.presenter === stubPresenter)
    }

    // MARK: Stubs

    class StubTransactionListUseCaseRefreshOneSourceTransformer: TransactionListRefreshOneSourceUseCaseTransformer {
        
        var didCall = false
        var presenter: TransactionListUseCaseOutput!
        
        override func transform( output presenter: TransactionListRefreshUseCaseOutput ) {
            
            didCall = true
            self.presenter = presenter as? TransactionListUseCaseOutput
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
