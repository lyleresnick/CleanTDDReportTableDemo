//  Copyright © 2017 Lyle Resnick. All rights reserved.

import XCTest
@testable import CleanTDDReportTableDemo

class TransactionListCellTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    let testString = "TestString"
    let testString2 = "TestString2"
    
    func test_HeaderCell_show_SetsCorrectly() {
        
        let cell = TransactionListHeaderCell()
        cell.setValue(UILabel(), forKey: "titleLabel")
        
        cell.show(row: .header(title: testString))
        
        let titleLabel = cell.value(forKey: "titleLabel") as! UILabel
        XCTAssertTrue(titleLabel.text == testString)
    }
    
    func test_SubheaderCell_show_SetsCorrectly() {
        
        let cell = TransactionListSubheaderCell()
        cell.setValue(UILabel(), forKey: "titleLabel")
        
        cell.show(row: .subheader(title: testString, odd: true))
        
        let titleLabel = cell.value(forKey: "titleLabel") as! UILabel
        XCTAssertTrue(titleLabel.text == testString)
        XCTAssertTrue(cell.backgroundColor ==
            UIColor(rgb: TransactionListSubheaderCell.oddBackgroundRGB))
    }
    
    func test_DetailCell_show_SetsCorrectly() {
        
        let cell = TransactionListDetailCell()
        cell.setValue(UILabel(), forKey: "descriptionLabel")
        cell.setValue(UILabel(), forKey: "amountLabel")
        
        cell.show(row: .detail(description: testString, amount: testString2, odd: true))
        
        let descriptionLabel = cell.value(forKey: "descriptionLabel") as! UILabel
        XCTAssertTrue(descriptionLabel.text == testString)
        
        let amountLabel = cell.value(forKey: "amountLabel") as! UILabel
        XCTAssertTrue(amountLabel.text == testString2)
        
        XCTAssertTrue(cell.backgroundColor ==
            UIColor(rgb: TransactionListDetailCell.oddBackgroundRGB))
    }
    
    func test_FooterCell_show_SetsCorrectly() {
        
        let cell = TransactionListFooterCell()
        cell.setValue(UILabel(), forKey: "totalLabel")
        
        cell.show(row: .footer(total: testString, odd: false))
        
        let totalLabel = cell.value(forKey: "totalLabel") as! UILabel
        XCTAssertTrue(totalLabel.text == testString)
        XCTAssertTrue(cell.backgroundColor ==
            UIColor(rgb: TransactionListFooterCell.evenBackgroundRGB))
    }
    
    func test_GrandFooterCell_show_SetsCorrectly() {
        
        let cell = TransactionListGrandFooterCell()
        cell.setValue(UILabel(), forKey: "totalLabel")
        
        cell.show(row: .grandfooter(total: testString))
        
        let totalLabel = cell.value(forKey: "totalLabel") as! UILabel
        XCTAssertTrue(totalLabel.text == testString)
    }
    
    func test_MessageCell_show_SetsCorrectly() {
        
        let cell = TransactionListMessageCell()
        cell.setValue(UILabel(), forKey: "messageLabel")
        
        cell.show(row: .message(message: testString))
        
        let totalLabel = cell.value(forKey: "messageLabel") as! UILabel
        XCTAssertTrue(totalLabel.text == testString)
    }
}

