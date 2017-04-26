//  Copyright © 2017 Lyle Resnick. All rights reserved.

import XCTest
@testable import CleanTDDReportTableDemo

class TransactionListPresenterTests: XCTestCase {

    private var sut: TransactionListPresenter!
    private var stubbedUseCase: StubTransactionListUseCase!
    private var stubbedViewController: StubViewController!
    private var entityGateway = EntityGatewayFactory.makeEntityGateway()

    override func setUp() {
        super.setUp()

        stubbedUseCase = StubTransactionListUseCase(entityGateway: entityGateway)
        sut = TransactionListPresenter(useCase: stubbedUseCase)
        stubbedUseCase.presenter = sut

        stubbedViewController = StubViewController()
        sut.viewController = stubbedViewController
    }

    func test_eventViewReady_CallsUseCase_beginTwoSource() {
        sut.eventViewReady()
        XCTAssertTrue(stubbedUseCase.beginCalled)
    }
    
    
    func test_presentInit_ClearsAllRows() {
        sut.presentInit()
        XCTAssertTrue(sut.rowCount == 0)
    }
    
    func test_presentHeader_AppendsHeader() {
        sut.presentInit()
        sut.presentHeader(group: .Authorized)
        let row = sut.row(at: 0)
        guard case .header(_) = row  else { XCTAssertTrue(false); return }
        XCTAssertTrue(true)
    }
    
    func test_presentSubheader_AppendsSubheader() {
        sut.presentInit()
        sut.presentSubheader(date: Date())
        let row = sut.row(at: 0)
        guard case .subheader(_) = row  else { XCTAssertTrue(false); return }
        XCTAssertTrue(true)
    }
    
    func test_presentDetail_AppendsDetail() {
        sut.presentInit()
        sut.presentDetail(description: "Test", amount: 0.5)
        let row = sut.row(at: 0)
        guard case .detail(_, _ ,_) = row  else { XCTAssertTrue(false); return }
        XCTAssertTrue(true)
    }
    
    func test_presentSubfooter_AppendsSubfooter() {
        sut.presentInit()
        sut.presentSubfooter()
        let row = sut.row(at: 0)
        guard case .subfooter(_) = row  else { XCTAssertTrue(false); return }
        XCTAssertTrue(true)
    }
    
    func test_presentFooter_AppendsFooter() {
        sut.presentInit()
        sut.presentFooter(total: 0.0)
        let row = sut.row(at: 0)
        guard case .footer(_,_) = row  else { XCTAssertTrue(false); return }
        XCTAssertTrue(true)
    }

    func test_presentGrandFooter_AppendsGrandFooter() {
        sut.presentInit()
        sut.presentGrandFooter(grandTotal: 0.0)
        let row = sut.row(at: 0)
        guard case .grandfooter(_) = row  else { XCTAssertTrue(false); return }
        XCTAssertTrue(true)
    }
    
    func test_presentNotFoundMessage_AppendsMessage() {
        sut.presentInit()
        sut.presentNotFoundMessage(group: .Authorized)
        let row = sut.row(at: 0)
        guard case .message(_) = row  else { XCTAssertTrue(false); return }
        XCTAssertTrue(true)
    }
    
    func test_presentNoTransactionsMessage_AppendsMessage() {
        sut.presentInit()
        sut.presentNoTransactionsMessage(group: .Authorized)
        let row = sut.row(at: 0)
        guard case .message(_) = row  else { XCTAssertTrue(false); return }
        XCTAssertTrue(true)
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

