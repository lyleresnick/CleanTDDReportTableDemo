//  Copyright © 2017 Lyle Resnick. All rights reserved.

import XCTest
@testable import CleanTDDReportTableDemo

class TransactionListPresenterTests: XCTestCase {

    private var sut: TransactionListPresenter!
    private var stubbedUseCase: StubTransactionListUseCase!
    private var stubbedViewController: StubViewController!

    override func setUp() {
        super.setUp()

        stubbedUseCase = StubTransactionListUseCase(entityGateway: FakeNilEntityGateway())
        sut = TransactionListPresenter(useCase: stubbedUseCase)
        stubbedUseCase.output = sut

        stubbedViewController = StubViewController()
        sut.output = stubbedViewController
    }

    func test_eventViewReady_CallsUseCase_beginTwoSource() {
        sut.eventViewReady()
        XCTAssertTrue(stubbedUseCase.beginCalled)
    }
    
    func test_presentReport_callsShowReport() {
        sut.presentReport()
        XCTAssertTrue(stubbedViewController.showReportCalled )
    }

// MARK: Stubs

    class StubTransactionListUseCase: TransactionListUseCase {

        var beginCalled = false

        override func begin(transformer: TransactionListUseCaseBeginTwoSourceTransformer?) {
            beginCalled = true
        }
    }

    class StubViewController: TransactionListPresenterOutput {

        var showReportCalled = false

        func showReport() {
            showReportCalled = true
        }

    }
}

