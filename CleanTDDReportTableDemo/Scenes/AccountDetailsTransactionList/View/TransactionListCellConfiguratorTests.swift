//  Copyright © 2017 Lyle Resnick. All rights reserved.

import XCTest
@testable import CleanTDDReportTableDemo


class TransactionViewListCellConfiguratorTests: XCTestCase {
    
    var sut: StubTransactionListCellConfigurator!
    let tableView = UITableView()
    let indexPath = IndexPath(row: 999, section: 999)
    let presenter = TransactionListPresenter(useCase: TransactionListUseCase(entityGateway: FakeNilEntityGateway()))
    
    override func setUp() {
        super.setUp()
        sut = StubTransactionListCellConfigurator()
        
        let _ = sut.set(tableView: tableView, indexPath: indexPath)
    }
    
    func test_Set_SetsTableView() {
        XCTAssertTrue(sut.tableView === tableView)
    }
    
    func test_Set_SetsIndexPath() {
        XCTAssertEqual(sut.indexPath, indexPath)
    }
        
    func test_Show_CallsCellsShowWithRow() {
        
        let stubTransactionListCell = sut.stubTransactionListCell
        let row = TransactionListRowViewModel.header(title: "Hello")
        
        let _ = sut.set(tableView: tableView, indexPath: indexPath).show(row: row)
        
        XCTAssertEqual(stubTransactionListCell.row, row)
    }
    
    class StubTransactionListCellConfigurator: TransactionListCellConfigurator {
        
        let stubTransactionListCell = StubTransactionListCell()
        
        override func tableCell(row: TransactionListRowViewModel) -> UITableViewCell {
            return stubTransactionListCell
        }
    }
    
    class StubTransactionListCell: UITableViewCell, TransactionListCell {
        
        var row: TransactionListRowViewModel?
        
        func show(row: TransactionListRowViewModel) {
            self.row = row
        }
    }
}

extension TransactionListRowViewModel: Equatable {}

public func == (lhs: TransactionListRowViewModel, rhs: TransactionListRowViewModel) -> Bool {
    
    switch (lhs, rhs) {
    case let (.header(a), .header(b)) :
        return a == b
    default:
        return false
    }
}
