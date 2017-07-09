//  Copyright © 2017 Lyle Resnick. All rights reserved.

import XCTest
@testable import CleanTDDReportTableDemo

private let constantInt = 6
private let constantCGFloat: CGFloat = 6.0

class TransactionListAdapterTests: XCTestCase {
    
    private var sut: TransactionListAdapter!
    private let cellConfigurator = StubTransactionListCellConfigurator()
    private var entityGateway = FakeNilEntityGateway()
    

    override func setUp() {
        super.setUp()
        
        sut = TransactionListAdapter(cellConfigurator: cellConfigurator)
        sut.presenter = configureTransactionListPresenter()
    }
    
    private func configureTransactionListPresenter() -> StubTransactionListPresenter {
        
        let transactionListUseCase = TransactionListUseCase(entityGateway: entityGateway)
        let transactionListPresenter = StubTransactionListPresenter(useCase: transactionListUseCase)
        transactionListUseCase.output = transactionListPresenter
        return transactionListPresenter
    }
    
    func test_NumberOfRowsInSection_ReturnsRowCountOfPresenter() {
        let x = sut.tableView(UITableView(), numberOfRowsInSection: 0)
        XCTAssertEqual(x, constantInt)
    }
    
    func test_CellForRowAt_ConfiguresCell() {
        let _ = sut.tableView(UITableView(), cellForRowAt: IndexPath(row: 0, section: 0))
        XCTAssertTrue(cellConfigurator.wasConfigured)
    }
    
    
    func test_HeightForRowAt_ReturnsHeightFromPresenter() {
        let x = sut.tableView(UITableView(), heightForRowAt: IndexPath(row: 0, section: 0))
        XCTAssertEqual(x, constantCGFloat)
    }
    
    
    private class StubTransactionListPresenter: TransactionListPresenter {
        
        override var rowCount: Int {
            return constantInt
        }
        
        override func row(at index: Int ) -> TransactionListViewModel {
            return .header(title: "Hello")
        }
        
        override func cellHeight(at index: Int) -> CGFloat {
            return constantCGFloat
        }
    }
    
    private class StubTransactionListCellConfigurator: TransactionListCellConfigurator {
        
        var wasConfigured = false
        
        override func show(row: TransactionListViewModel) -> UITableViewCell {
            wasConfigured = true
            return TransactionListHeaderCell()
        }
    }
}
