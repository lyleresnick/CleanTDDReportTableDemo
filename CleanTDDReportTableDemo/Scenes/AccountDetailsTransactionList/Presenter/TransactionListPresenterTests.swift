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

    func test_eventRefresh_CallsUseCase_refreshTwoSource() {
        sut.eventRefreshTwoSource()
        XCTAssertTrue(stubbedUseCase.refreshCalled)
    }
    
    
    func test_presentInit_callsInitialize() {
        sut.presentInit()
        XCTAssertTrue(stubbedViewController.initializeCalled )
    }

    func test_presentReport_callsShowReport() {
        sut.presentReport()
        XCTAssertTrue(stubbedViewController.showReportCalled )
    }

// MARK: Stubs

    class StubTransactionListUseCase: TransactionListUseCase {

        var refreshCalled = false

        override func eventRefreshTwoSource(transformer: TransactionListRefreshTwoSourceUseCaseTransformer?) {
            refreshCalled = true
        }
    }

    class StubViewController: TransactionListPresenterOutput {

        var initializeCalled = false
        var showReportCalled = false

        func initialize() {
            initializeCalled = true
        }
        
        func showReport(rows: [TransactionListRowViewModel]) {
            showReportCalled = true
        }

    }
}

