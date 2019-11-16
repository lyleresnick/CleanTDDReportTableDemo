//  Copyright © 2017 Lyle Resnick. All rights reserved.

import XCTest
@testable import CleanTDDReportTableDemo

class TransactionViewerViewControllerIBInjectionTests: XCTestCase {

    private var sut: TransactionListViewController!
    private var tableView: UITableView!

    override func setUp() {
        super.setUp()
        
        EntityGatewayFactory.gateway = FakeNilEntityGateway()

        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        sut = storyboard.instantiateViewController(withIdentifier: String(describing: TransactionListViewController.self) ) as? TransactionListViewController
        
        _ = sut.view
        
        tableView = sut.value(forKey: "tableView") as? UITableView
    }
    
    func test_IB_InjectsAllSutOutlets() {
        
        XCTAssertNotNil(tableView)
    }
    
    func test_tableView_CanDequeueAllCellIds() {
        
        for cellId in ["header", "subheader", "detail", "subfooter", "footer", "grandfooter", "message"] {
        
            let cell = tableView.dequeueReusableCell(withIdentifier: cellId)
            XCTAssertNotNil(cell, "Can't dequeue cellId: \(cellId)" )
        }
    }
    
    func test_IB_InjectsOutletsOfHeaderCell() {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "header") as! TransactionListHeaderCell
        let titleLabel = cell.value(forKey: "titleLabel")
        XCTAssertNotNil(titleLabel)
    }
    
    func test_IB_InjectsOutletsOfSubheaderCell() {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "subheader") as! TransactionListSubheaderCell
        let titleLabel = cell.value(forKey: "titleLabel")
        XCTAssertNotNil(titleLabel)
    }
    
    func test_IB_InjectsOutletsOfDetailCell() {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "detail") as! TransactionListDetailCell
        let descriptionLabel = cell.value(forKey: "descriptionLabel")
        XCTAssertNotNil(descriptionLabel)
        let amountLabel = cell.value(forKey: "amountLabel")
        XCTAssertNotNil(amountLabel)
    }
    
    func test_IB_InjectsOutletsOfFooterCell() {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "footer") as! TransactionListFooterCell
        let totalLabel = cell.value(forKey: "totalLabel")
        XCTAssertNotNil(totalLabel)
    }
    
    func test_IB_InjectsOutletsOfGrandFooterCell() {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "grandfooter") as! TransactionListGrandFooterCell
        let totalLabel = cell.value(forKey: "totalLabel")
        XCTAssertNotNil(totalLabel)
    }
    
    func test_IB_InjectsOutletsOfMessageCell() {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "message") as! TransactionListMessageCell
        let messageLabel = cell.value(forKey: "messageLabel")
        XCTAssertNotNil(messageLabel)
    }
}
