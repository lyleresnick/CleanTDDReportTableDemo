//  Copyright © 2017 Lyle Resnick. All rights reserved.

import XCTest
@testable import CleanTDDReportTableDemo

private let constantInt = 6
private let constantCGFloat: CGFloat = 6.0

class TransactionListAdapterTests: XCTestCase {
    
    private var sut: TransactionListAdapter!
    private let cellConfigurator = StubTransactionListCellConfigurator()
    private var entityGateway = FakeNilEntityGateway()
    var transactionListPresenter: TransactionListPresenter!
    

    override func setUp() {
        super.setUp()
        
        configureTransactionListPresenter()
        sut = TransactionListAdapter(cellConfigurator: cellConfigurator)
        sut.rows = [.header(title: "Test") ]
        
    }
    
    private func configureTransactionListPresenter() {
        
        let transactionListUseCase = TransactionListUseCase(entityGateway: entityGateway)
        transactionListPresenter = TransactionListPresenter(useCase: transactionListUseCase)
    }
    
    func test_NumberOfRowsInSection_ReturnsRowCountOfPresenter() {
        let x = sut.tableView(UITableView(), numberOfRowsInSection: 0)
        XCTAssertEqual(x, 1)
    }
    
    func test_CellForRowAt_ConfiguresCell() {
        let cell = sut.tableView(UITableView(), cellForRowAt: IndexPath(row: 0, section: 0))
        XCTAssertTrue(cell is TransactionListHeaderCell)
    }
    
    private class StubTransactionListCellConfigurator: TransactionListCellConfigurator {
        
        override func show(row: TransactionListRowViewModel) -> UITableViewCell {
            return TransactionListHeaderCell()
        }
    }
}
