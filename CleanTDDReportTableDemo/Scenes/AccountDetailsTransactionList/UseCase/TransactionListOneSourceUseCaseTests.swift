//  Copyright © 2017 Lyle Resnick. All rights reserved.

import XCTest
@testable import CleanTDDReportTableDemo

class TransactionListOneSourceUseCaseTests: XCTestCase {
    private var sut: TransactionListUseCase!
    private var stubPresenter: StubTransactionListPresenter!
    private var entityGateway = FakeNilEntityGateway()

    private var oneSourceTransformer: StubTransactionListUseCaseViewReadyOneSourceTransformer!

    override func setUp() {
        super.setUp()

        oneSourceTransformer = StubTransactionListUseCaseViewReadyOneSourceTransformer(transactionManager: FakeNoneOneSourceManagerImpl())

        stubPresenter = StubTransactionListPresenter()
        sut = TransactionListUseCase(entityGateway: entityGateway)
        sut.output = stubPresenter
    }

    func test_viewReadyOneSource_CallsTransformer() {
        
        sut.eventViewReadyOneSource(transformer: oneSourceTransformer)
        XCTAssertTrue(oneSourceTransformer.didCall)
    }
    
    func test_viewReadyOneSource_CallsTransformerWithPresenter() {
        
        sut.eventViewReadyOneSource(transformer: oneSourceTransformer)
        XCTAssertTrue(oneSourceTransformer.presenter === stubPresenter)
    }

    // MARK: Stubs

    class StubTransactionListUseCaseViewReadyOneSourceTransformer: TransactionListViewReadyOneSourceUseCaseTransformer {
        
        var didCall = false
        var presenter: TransactionListUseCaseOutput!
        
        override func transform( output presenter: TransactionListViewReadyUseCaseOutput ) {
            
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
