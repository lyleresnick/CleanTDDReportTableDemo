//  Copyright © 2017 Lyle Resnick. All rights reserved.

import XCTest
@testable import CleanTDDReportTableDemo

class TransactionListRowViewModelTests: XCTestCase, TransactionListPresenterOutput {
    var rows = [TransactionListRowViewModel]()
    
    func initialize() {
    }

    func showReport(rows: [TransactionListRowViewModel]) {
        self.rows = rows
    }
    
    private var sut: TransactionListPresenter!
    
    override func setUp() {
        super.setUp()
        
        let useCase = TransactionListUseCase(entityGateway: FakeNilEntityGateway())
        sut = TransactionListPresenter(useCase: useCase)
        sut.output = self
        sut.presentInit()
    }
    
    func test_presentInit_ClearsAllRows() {
        sut.presentReport()
        XCTAssertTrue(self.rows.count == 0)
    }
    
    func test_presentHeader_AppendsHeader() {
        
        sut.presentHeader(group: .authorized)
        sut.presentReport()
        let row = self.rows[0]
        guard case .header(let title ) = row  else { XCTAssertTrue(false); return }
        
        XCTAssertTrue(title == "Authorized Transactions")
    }
    
    func test_presentSubheader_AppendsSubheader() {
        
        sut.presentSubheader(date: Date())
        sut.presentReport()
        let row = self.rows[0]
        guard case let .subheader(date, odd ) = row  else { XCTAssertTrue(false); return }
        
        XCTAssertEqual(date, TransactionListPresenter.outboundDateFormatter.string(from: Date()))
        XCTAssertTrue(odd)
    }
    
    func test_presentDetail_AppendsDetail() {
        
        sut.presentDetail(description: "Test", amount: 0.5)
        sut.presentReport()
        let row = self.rows[0]
        guard case let .detail(description, amount, odd) = row  else { XCTAssertTrue(false); return }
        
        XCTAssertEqual(description, "Test")
        XCTAssertEqual(amount, "0.50")
        XCTAssertFalse(odd)
    }
    
    func test_presentSubfooter_AppendsSubfooter() {
        
        sut.presentSubfooter()
        sut.presentReport()
        let row = self.rows[0]
        guard case let .subfooter(odd) = row  else { XCTAssertTrue(false); return }
        
        XCTAssertFalse(odd)
    }
    
    func test_presentFooter_AppendsFooter() {
        
        sut.presentFooter(total: 0.0)
        sut.presentReport()
        let row = self.rows[0]
        guard case let .footer(total, odd) = row  else { XCTAssertTrue(false); return }
        
        XCTAssertEqual(total, "0.00")
        XCTAssertTrue(odd)
    }
    
    func test_presentGrandFooter_AppendsGrandFooter() {
        
        sut.presentGrandFooter(grandTotal: 0.0)
        sut.presentReport()
        let row = self.rows[0]
        guard case let .grandfooter(grandTotal) = row  else { XCTAssertTrue(false); return }
        
        XCTAssertEqual(grandTotal, "0.00")
    }
    
    func test_presentNotFoundMessage_AppendsMessage() {
        
        sut.presentNotFoundMessage(group: .authorized)
        sut.presentReport()
        let row = self.rows[0]
        guard case let .message(message) = row  else { XCTAssertTrue(false); return }
        
        XCTAssertEqual(message, "Authorized Transactions are not currently available.")
    }
    
    func test_presentNoTransactionsMessage_AppendsMessage() {
        
        sut.presentNoTransactionsMessage(group: .authorized)
        sut.presentReport()
        let row = self.rows[0]
        guard case let .message(message) = row  else { XCTAssertTrue(false); return }
        
        XCTAssertEqual(message, "There are no Authorized Transactions in this period")
    }
    
}

